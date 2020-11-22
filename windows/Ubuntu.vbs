Set ws = CreateObject("Wscript.Shell")
ws.run "wsl -d Ubuntu-18.04 -u root /etc/init.wsl start", vbhide