# dhakerni

A desktop dhikr reminder for Linux. Shows random adhkar as desktop notifications on a configurable schedule.

## Requirements

- Python 3
- `notify-send` (`sudo apt install libnotify-bin` on Ubuntu/Debian)
- systemd (for timer/scheduling)

## Install

```bash
make install
```

## Uninstall

```bash
make uninstall
```

## Usage

```
dhakerni [command] [options]
```

### Commands

| Command | Description |
|---|---|
| `run` | Show a random dhikr notification now |
| `install` | Install systemd timer for recurring notifications |
| `uninstall` | Remove systemd timer |
| `add <text>` | Add a custom dhikr (optional: `--category`) |
| `remove <id>` | Remove a custom dhikr by ID |
| `list` | List all adhkar (optional: `--category`) |
| `status` | Show timer status |
| `config` | View or update settings |

### Options

| Flag | Description |
|---|---|
| `-c, --category` | Filter by category: morning, evening, sleep, wake, prayer, general |
| `-i, --interval` | Time between reminders (e.g. `5m`, `30m`, `1h`) |
| `-d, --duration` | Notification expiry time (e.g. `10s`, `30s`) |
| `-h, --help` | Show help |
| `-V, --version` | Show version |

## Examples

```bash
# Show a random dhikr now
dhakerni run

# Show a random morning dhikr
dhakerni run -c morning

# Install with 15 minute interval
dhakerni install -i 15m

# Install with custom notification duration
dhakerni install -i 10m -d 20s

# Add a custom dhikr
dhakerni add "اللهم بارك لنا فيما رزقتنا" -c general

# Add without category (appears in all)
dhakerni add "دعاء خاص"

# List all adhkar
dhakerni list

# List only evening adhkar
dhakerni list -c evening

# Remove a custom dhikr
dhakerni remove 3

# Check timer status
dhakerni status

# View config
dhakerni config

# Change defaults
dhakerni config --set-interval 10m
dhakerni config --set-duration 20s
dhakerni config --set-category morning
```

## Categories

| Category | Arabic | Description |
|---|---|---|
| `morning` | أذكار الصباح | Morning adhkar |
| `evening` | أذكار المساء | Evening adhkar |
| `sleep` | أذكار النوم | Before sleep |
| `wake` | أذكار الاستيقاظ | Upon waking |
| `prayer` | أذكار الصلاة | After prayer |
| `general` | أذكار عامة | General dhikr |

## Config

Settings are stored at `~/.config/dhakerni/`:

- `config.json` — default interval, duration, and category
- `dhkar.json` — custom adhkar list

## Files

```
~/.local/bin/dhakerni              # the CLI script
~/.config/dhakerni/config.json     # settings
~/.config/dhakerni/dhkar.json      # custom adhkar
~/.config/systemd/user/dhakerni.service
~/.config/systemd/user/dhakerni.timer
```
