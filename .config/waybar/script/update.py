# updater.py
import json
import time
import traceback
from wallet import get_wallet_balance
from earn import get_earn_balance
from os.path import expanduser


FILE = expanduser("~/.config/waybar/script/balance.json")

while True:
    try:
        wallet_balance = get_wallet_balance()
        earn_balance = get_earn_balance()
        total_balance = wallet_balance + earn_balance
        with open(FILE, "w") as f:
            json.dump({"total": total_balance}, f)
    except Exception as e:
        with open(FILE, "w") as f:
            json.dump({"error": str(e)}, f)
    time.sleep(15)  # обновлять каждые 15 секунд
