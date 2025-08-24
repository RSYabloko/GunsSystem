#!/bin/bash

cleanup() {
  echo "🛑 Скрипт завершён, отключаю ICMP (ping)..."
  sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1
  exit 0
}

trap cleanup SIGINT SIGTERM EXIT

if [ "$1" == "on" ]; then
  echo "✅ Включаю ICMP (ping)..."
  sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0
  echo "⌛ Пинг разрешён. Нажми Ctrl+C для отключения..."
  # Ждём пока скрипт не получит сигнал прерывания
  while true; do sleep 1; done
elif [ "$1" == "off" ]; then
  echo "❌ Отключаю ICMP (ping)..."
  sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1
else
  echo "Использование: $0 {on|off}"
  exit 1
fi

