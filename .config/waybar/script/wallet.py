import os
from dotenv import load_dotenv
import time
import requests
from sign import sign
from os.path import expanduser

load_dotenv(expanduser("~/.config/waybar/script/.env"))

API_KEY = os.getenv("KEY")
PRIVATE_KEY_PATH = os.getenv("KEY_PATH")

def get_wallet_balance():
    url = "https://api.bybit.com/v5/account/wallet-balance"
    params = {
        "accountType": "UNIFIED",
        "coin": "USDT",
        "api_key": API_KEY,
        "timestamp": str(int(time.time() * 1000))
    }
    params["sign"] = sign(params, PRIVATE_KEY_PATH)
    r = requests.get(url, params=params)
    data = r.json()
    if data["retCode"] != 0:
        raise Exception(f"API error wallet balance: {data.get('retMsg', 'unknown error')}")
    wallet_list = data["result"]["list"]
    if not wallet_list:
        raise Exception("Empty wallet list")
    return float(wallet_list[0].get("totalWalletBalance", 0))

if __name__ == "__main__":
    print(get_wallet_balance())
