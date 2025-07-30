# ✅ Assignment 5: Server Health Check Automation Script

This project includes a Bash script to monitor basic server health metrics and log them for analysis and alerting.

---

## 🔧 Features

- ✅ CPU, Memory, and Disk usage checks
- ✅ Log outputs to `/var/log/sys_health.log`
- ✅ Alerts if any metric exceeds 80%
- ✅ Auto-clean logs older than 7 days
- ✅ Easily schedule via cron (every 15 mins)

---

## 🚀 Usage

### 1️⃣ Copy Script

Save `server_health_check.sh` somewhere accessible, e.g., `/usr/local/bin/` and make it executable:

```bash
chmod +x /usr/local/bin/server_health_check.sh
```

### 2️⃣ Setup Cron Job

Edit crontab:

```bash
crontab -e
```

Add the following line:

```cron
*/15 * * * * /usr/local/bin/server_health_check.sh
```

### 3️⃣ Logs

Logs will be written to:

```
/var/log/sys_health.log
```

Old logs older than 7 days are automatically removed.

---

## 📬 Alerts

If CPU, memory, or disk usage exceeds 80%, an alert is logged in the same file.

---

## 📜 License

This script is open-sourced under the MIT license.
