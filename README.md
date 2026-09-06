# dhakerni

A small time-aware dhikr reminder for Linux.

## Requirements

- Python 3
- `notify-send`
- systemd user services

## Install

```bash
chmod +x dhakerni
./dhakerni install
```

`install` copies the program to `~/.local/bin/dhakerni` and creates the user systemd timer. No separate installer or Makefile is required.

## Time-aware behavior

Default schedule:

- `05:00 → 12:00`: morning
- `12:00 → 17:00`: general
- `17:00 → 23:00`: evening
- `23:00 → 05:00`: quiet; no automatic notification

The program uses the computer's current local time. Change the ranges with `dhakerni config --help`.

## Commands

```text
dhakerni run
dhakerni install
dhakerni uninstall
dhakerni add
dhakerni remove
dhakerni list
dhakerni status
dhakerni config
```

Every command has its own help:

```bash
dhakerni --help
dhakerni run --help
dhakerni install --help
dhakerni config --help
```

## Examples

```bash
# Show the time-appropriate dhikr now
dhakerni run

# Manually override the time category
dhakerni run -c morning

# Install/update with a 15-minute interval
dhakerni install -i 15m

# Change the live timer interval later
dhakerni config --set-interval 10m

# Change time ranges
dhakerni config \
  --set-morning-start 05:30 \
  --set-general-start 12:30 \
  --set-evening-start 18:00 \
  --set-quiet-start 23:30

# Add/remove custom adhkar
dhakerni add "سبحان الله" -c general
dhakerni list
dhakerni remove 1

# Uninstall, keeping config
dhakerni uninstall

# Uninstall and remove config
dhakerni uninstall --purge
```

Notifications contain only the dhikr text. The previous dhikr is remembered so it is not immediately repeated when alternatives exist.
