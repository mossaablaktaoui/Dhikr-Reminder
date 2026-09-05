#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
SYSTEMD_DIR="$HOME/.config/systemd/user"
SCRIPT_PATH="$BIN_DIR/dhikr-reminder"
SERVICE_PATH="$SYSTEMD_DIR/dhikr-reminder.service"
TIMER_PATH="$SYSTEMD_DIR/dhikr-reminder.timer"

if ! command -v notify-send >/dev/null 2>&1; then
  echo "Error: notify-send is not installed."
  echo "On Ubuntu/Debian, install it with: sudo apt install libnotify-bin"
  exit 1
fi

if ! command -v systemctl >/dev/null 2>&1; then
  echo "Error: systemctl is not available on this system."
  exit 1
fi

mkdir -p "$BIN_DIR" "$SYSTEMD_DIR"

cat > "$SCRIPT_PATH" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

adhkar=(
  "🌿 سبحان الله"
  "🤲 الحمد لله"
  "✨ الله أكبر"
  "🕋 لا إله إلا الله"
  "💚 أستغفر الله"
  "🌸 سبحان الله وبحمده"
  "🌙 سبحان الله العظيم"
  "🕊️ لا حول ولا قوة إلا بالله"
  "🌟 اللهم صلِّ وسلم على نبينا محمد"
  "🤍 رضيت بالله رباً وبالإسلام ديناً وبمحمد ﷺ نبياً"
  "🤲 اللهم اغفر لي وارحمني"
  "🌿 يا حي يا قيوم برحمتك أستغيث"
  "🛡️ حسبي الله لا إله إلا هو"
  "💫 اللهم إنك عفو تحب العفو فاعف عني"
  "🌱 رب اغفر لي وتب علي"
  "✨ سبحانك اللهم وبحمدك"
  "🤲 اللهم أعني على ذكرك وشكرك وحسن عبادتك"
  "🌊 لا إله إلا أنت سبحانك إني كنت من الظالمين"
  "🌺 اللهم آتنا في الدنيا حسنة وفي الآخرة حسنة"
  "🤍 ربنا تقبل منا إنك أنت السميع العليم"
  "☀️ أصبحنا وأصبح الملك لله"
  "🌙 أمسينا وأمسى الملك لله"
  "💚 لا إله إلا الله وحده لا شريك له"
  "✨ له الملك وله الحمد وهو على كل شيء قدير"
  "🤲 رب زدني علماً"
  "🌿 رب اشرح لي صدري ويسر لي أمري"
  "🕊️ اللهم اهدني وسددني"
  "🌸 اللهم ارزقني حسن الخاتمة"
  "💫 اللهم ثبت قلبي على دينك"
  "🤍 اللهم طهر قلبي"
  "🌱 اللهم بارك لي في وقتي وعملي"
  "🛡️ أعوذ بكلمات الله التامات من شر ما خلق"
  "🌟 اللهم إني أسألك العفو والعافية"
  "🤲 اللهم إنك أنت السلام ومنك السلام"
  "🕋 لا إله إلا الله الملك الحق المبين"
  "🌿 سبحان الله والحمد لله ولا إله إلا الله والله أكبر"
  "💚 أستغفر الله العظيم وأتوب إليه"
  "✨ اللهم لك الحمد كما ينبغي لجلال وجهك وعظيم سلطانك"
  "🌺 ربنا ظلمنا أنفسنا وإن لم تغفر لنا وترحمنا لنكونن من الخاسرين"
  "🕊️ اللهم اجعل القرآن ربيع قلبي"
)

index=$(( RANDOM % ${#adhkar[@]} ))
message=${adhkar[$index]}

/usr/bin/notify-send \
  --app-name="Dhikr Reminder" \
  --urgency=normal \
  --expire-time=10000 \
  --icon=dialog-information \
  "ذِكر" \
  "$message"
EOF

cat > "$SERVICE_PATH" <<'EOF'
[Unit]
Description=Show a random dhikr notification

[Service]
Type=oneshot
ExecStart=%h/.local/bin/dhikr-reminder
EOF

cat > "$TIMER_PATH" <<'EOF'
[Unit]
Description=Show dhikr notification every 5 minutes

[Timer]
OnBootSec=30s
OnUnitActiveSec=5min
AccuracySec=30s
Unit=dhikr-reminder.service

[Install]
WantedBy=timers.target
EOF

chmod +x "$SCRIPT_PATH"
systemctl --user daemon-reload
systemctl --user enable --now dhikr-reminder.timer
systemctl --user start dhikr-reminder.service || true

echo "✅ Dhikr Reminder installed successfully."
echo "It will show a random dhikr notification every 5 minutes."
echo
echo "Test now:     $SCRIPT_PATH"
echo "Check status: systemctl --user status dhikr-reminder.timer"
echo "Stop:         systemctl --user stop dhikr-reminder.timer"
echo "Disable:      systemctl --user disable dhikr-reminder.timer"
