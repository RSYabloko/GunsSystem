cd disable_ping/ && sudo cp 99-disable-ping.conf /etc/sysctl.d/ && sudo systemctl --user daemon-reexec && sudo systemctl --user daemon-reload && sudo systemctl enable --now sync_obsidian.service
