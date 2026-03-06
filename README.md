# node-healthcheck

A simple Bash-based healthcheck tool for node operators using WSL or Ubuntu.

## Features

- Hostname check
- User check
- Uptime check
- Load average check
- Memory check
- Disk check
- Root disk usage percentage
- Process check
- Port check

## Structure

- scripts/ -> main healthcheck script
- docs/ -> usage notes
- examples/ -> sample output

## Main Script

### healthcheck.sh
Runs a quick health report for a local machine.

## Usage

Run:
bash scripts/healthcheck.sh

Optional:
bash scripts/healthcheck.sh bash 22

This means:
- check process name: bash
- check port: 22

## Roadmap

- Add colorized output
- Add log file export
- Add custom process list
- Add warning thresholds
