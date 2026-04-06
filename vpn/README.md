# VPN Setup

OpenVPN services are auto-configured from `.ovpn` files in this directory.

## Setup

```
vpn/
├── configs/          ← drop .ovpn files here
│   └── example.ovpn
└── credentials       ← username:password (one per line)
```

**Step 1 — drop your `.ovpn` file(s) into `vpn/configs/`**

```bash
cp ~/Downloads/my-vpn.ovpn vpn/configs/
```

**Step 2 — create `vpn/credentials`**

```bash
cp vpn/credentials.example vpn/credentials
$EDITOR vpn/credentials   # fill in your username and password
chmod 600 vpn/credentials
```

**Step 3 — rebuild**

```bash
./bin/apply
```

A systemd service named `openvpn-<filename>` is created for each `.ovpn` file.
The VPN menu (`Super + Shift + Ctrl + V`) lists all of them.

## Security

`vpn/credentials` is in `.gitignore` — it will never be committed.
Never commit this file. It contains your VPN password.
