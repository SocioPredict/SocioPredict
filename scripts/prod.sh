#!/bin/bash

# Make sure the script can only be run via SocioPredict Script
[ -z "$CALLED_FROM_SOCIOPREDICT" ] && { echo "Not called from SocioPredict"; exit 42; }

# Check for .env file
export CALLED_FROM_SOCIOPREDICT=yes
source "$SCRIPT_DIR/scripts/prod/env_writer_prod.sh"
_main
unset CALLED_FROM_SOCIOPREDICT

source_env

sleep 1;

# Build Docker Images
export CALLED_FROM_SOCIOPREDICT=yes
source "$SCRIPT_DIR/scripts/prod/build_prod.sh"
unset CALLED_FROM_SOCIOPREDICT
