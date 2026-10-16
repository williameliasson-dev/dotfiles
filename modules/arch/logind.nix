{ ... }: {
  # Short press of the (badly placed) power button does nothing;
  # hold it ~5s to power off on purpose.
  # Apply without reboot: sudo systemctl kill -s HUP systemd-logind
  environment.etc."systemd/logind.conf.d/power-key.conf".text = ''
    [Login]
    HandlePowerKey=ignore
    HandlePowerKeyLongPress=poweroff
  '';
}
