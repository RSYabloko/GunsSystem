import os
from dotenv import load_dotenv
import time
import requests
from sign import sign
from os.path import expanduser

load_dotenv(expanduser("~/.config/waybar/script/.env"))

API_KEY = os.getenv("KEY")
PRIVATE_KEY_PATH = os.getenv("KEY_PATH")

_last_request_time = 0
_last_response = {}

def get_price_in_usdt(symbol):
    global _last_request_time, _last_response
    now = time.time()
    symbol_lower = symbol.lower()

    # Если последний запрос был меньше минуты назад и цена для этого символа есть в кеше — вернуть из кеша
    if now - _last_request_time < 60 and symbol_lower in _last_response:
        return _last_response.get(symbol_lower, 0)

    # Иначе сделать запрос на CoinGecko для всех нужных монет одновременно,
    # чтобы обновить кеш сразу для всех символов
    symbol_map = {
        "usdt": "tether",
        "eth": "ethereum",
        "ltc": "litecoin",
        "btc": "bitcoin",
        # добавь нужные
    }

    # Формируем список coin_id для запроса — из ключей symbol_map
    coin_ids = ",".join(set(symbol_map.values()))
    url = f"https://api.coingecko.com/api/v3/simple/price?ids={coin_ids}&vs_currencies=usd"
    r = requests.get(url)
    if r.status_code == 200:
        data = r.json()
        _last_request_time = now
        # Обновляем кеш для всех монет из symbol_map
        for sym, coin_id in symbol_map.items():
            price = data.get(coin_id, {}).get("usd", 0)
            _last_response[sym] = price
        # Возвращаем цену нужного символа из кеша
        return _last_response.get(symbol_lower, 0)
    else:
        # Если запрос не удался — возвращаем цену из кеша, если есть, иначе 0
        return _last_response.get(symbol_lower, 0)

def get_earn_balance():
    url = "https://api.bybit.com/v5/earn/position"
    params = {
        "api_key": API_KEY,
        "timestamp": str(int(time.time() * 1000)),
        "category": "FlexibleSaving",
    }
    params["sign"] = sign(params, PRIVATE_KEY_PATH)
    response = requests.get(url, params=params)
    data = response.json()
    if data["retCode"] != 0:
        raise Exception(f"Earn API error: {data.get('retMsg', 'unknown error')}")
    total_usdt = 0.0
    for position in data["result"].get("list", []):
        coin = position.get("coin")
        amount = float(position.get("amount", 0))
        # total_pnl = float(position.get("totalPnl", 0))  # не нужен, если считаешь активы

        if amount > 0:
            price = get_price_in_usdt(coin)
            total_usdt += amount * price  # только количество * цена
    return total_usdt

if __name__ == "__main__":
    print(get_earn_balance())
