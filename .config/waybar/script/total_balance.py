#!/usr/bin/env python3
# total_balance.py
import json
import sys
from os.path import expanduser

STATE_FILE = expanduser("~/.config/waybar/script/balance_hidden.state")
DATA_FILE = expanduser("~/.config/waybar/script/balance.json")

def read_state():
    try:
        with open(STATE_FILE, "r") as f:
            return f.read().strip() == "hidden"
    except FileNotFoundError:
        return False

def write_state(hidden):
    with open(STATE_FILE, "w") as f:
        f.write("hidden" if hidden else "shown")

if len(sys.argv) > 1 and sys.argv[1] == "click=right":
    write_state(not read_state())
    sys.exit(0)

hidden = read_state()

try:
    with open(DATA_FILE, "r") as f:
        data = json.load(f)
    if "error" in data:
        text = "Error"
    else:
        total_balance = data["total"]
        text = f"USDT: {'*****💰' if hidden else f'{total_balance:.4f} 💰'}"
except FileNotFoundError:
    text = "No data"

print(json.dumps({"text": text, "tooltip": "Wallet+Earn"}))
