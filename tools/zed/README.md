# Zed IDE Configuration

This directory contains the configuration files for the [Zed IDE](https://zed.dev/), a high-performance, multiplayer code editor.

## Files

- `settings.json`: Main configuration settings for Zed.
- `install.sh`: Installation script to install Zed and link the configuration.

## Installation

To install Zed and link this configuration, run:

```bash
./install.sh
```

## Manual Setup

If you prefer to manually link the configuration:

```bash
ln -sf "$(pwd)/settings.json" ~/.config/zed/settings.json
```
