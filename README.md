# rlggyp Dotfiles

This repository contains my personal dotfiles. They are used to configure my development environment to my liking.

## Getting Started

These instructions will guide you through getting a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

The following items need to be installed. You can install them using the command below:

```bash
sudo pacman -S zsh cronie dunst gcc podman git ttf-jetbrains-mono-nerd \
  noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra rofi flameshot
```

### Installing

If you are using a tiling window manager and want to enable the battery notification feature, you need to add the following configuration and enable a cronjob to check the battery level every minute:
```bash
*/1 * * * * /home/rlggyp/.local/bin/batterynotify
```
To enable the service to run the job that has been created, use the following commands:
```bash
systemctl enable cronie.service
systemctl start cronie.service
```