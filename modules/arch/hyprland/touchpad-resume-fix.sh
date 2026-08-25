#!/bin/sh
# systemd-sleep hook: the Focaltech FTCS1000 touchpad (i2c_hid_acpi) doesn't
# reinitialize cleanly after s2idle resume — it stays bound but stops sending
# events, with no kernel error logged. Rebinding the driver forces a reprobe.
# Hyprland also needs a reload afterwards, or the freshly reprobed device
# falls back to libinput defaults (e.g. natural scroll) instead of hyprland.conf.
#
# Install: sudo install -m 755 touchpad-resume-fix.sh /etc/systemd/system-sleep/touchpad-resume-fix
# Logs to journal under -t touchpad-resume-fix (journalctl -t touchpad-resume-fix).

TOUCHPAD_DEV="i2c-FTCS1000:01"
DRIVER="i2c_hid_acpi"
TARGET_USER="william"
LOG_TAG="touchpad-resume-fix"

log() {
	logger -t "$LOG_TAG" "$1"
}

case "$1" in
post)
	log "hook fired (arg2=$2)"

	if echo "$TOUCHPAD_DEV" >"/sys/bus/i2c/drivers/$DRIVER/unbind" 2>&1; then
		log "unbind ok"
	else
		log "unbind FAILED"
	fi
	sleep 1

	if echo "$TOUCHPAD_DEV" >"/sys/bus/i2c/drivers/$DRIVER/bind" 2>&1; then
		log "bind ok"
	else
		log "bind FAILED"
	fi
	sleep 1

	RUNTIME_DIR="/run/user/$(id -u "$TARGET_USER")"
	HYPR_SIG=$(ls "$RUNTIME_DIR/hypr" 2>/dev/null | head -n1)
	if [ -n "$HYPR_SIG" ]; then
		if runuser -u "$TARGET_USER" -- env \
			XDG_RUNTIME_DIR="$RUNTIME_DIR" \
			HYPRLAND_INSTANCE_SIGNATURE="$HYPR_SIG" \
			hyprctl reload >/tmp/touchpad-resume-fix-hyprctl.log 2>&1; then
			log "hyprctl reload ok"
		else
			log "hyprctl reload FAILED, see /tmp/touchpad-resume-fix-hyprctl.log"
		fi
	else
		log "no Hyprland instance signature found under $RUNTIME_DIR/hypr, skipping reload"
	fi

	log "hook done"
	;;
esac
