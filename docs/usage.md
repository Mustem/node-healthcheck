# Usage

Basic usage:

bash scripts/healthcheck.sh

Custom usage:

bash scripts/healthcheck.sh <process_name> <port>

Example:

bash scripts/healthcheck.sh bash 22

The script also warns if root disk usage reaches 80% or more.
