#!/usr/bin/env bash
# Pi-hole: A black hole for Internet advertisements
# (c) 2017 Pi-hole, LLC (https://pi-hole.net)
# Network-wide ad blocking via your own hardware.
#
# Script to hold utility functions for use in other scripts
#
# This file is copyright under the latest version of the EUPL.
# Please see LICENSE file for your rights under this license.

# Basic Housekeeping rules
#  - Functions must be self contained
#  - Functions must be added in alphabetical order
#  - Functions must be documented
#  - New functions must have a test added for them in test/test_any_utils.py

#######################
# Takes either
#   - Three arguments: key, value, and file.
#   - Two arguments: key, and file
#
# Checks the target file for the existence of the key
#   - If it exists, it changes the value
#   - If it does not exist, it adds the value
#
# Example usage:
# addOrEditKeyValuePair "BLOCKING_ENABLED" "true" "/etc/pihole/setupVars.conf"
#######################
addOrEditKeyValPair() {
  local key="${1}"
  local value
  local file
  
  # If two arguments have been passed, then the second one is the file - there is no value
  if [ $# -lt 3 ]; then    
    file="${2}"
  else    
    value="${2}"
    file="${3}"
  fi

  if [[ "${value}" != "" ]]; then
    # value has a value, so it is a key pair
    if grep -q "^${key}=" "${file}"; then
      # Key already exists in file, modify the value
      sed -i "/^${key}=/c\\${key}=${value}" "${file}"
    else
      # Key does not already exist, add it and it's value
      echo "${key}=${value}" >> "${file}"
    fi
  else
    # value has no value, so it is just a key. Add it if it does not already exist
    if ! grep -q "^${key}" "${file}"; then
      # Key does not exist, add it.
      echo "${key}" >> "${file}"
    fi
  fi
}

#######################
# Takes two arguments key, and file.
# Deletes a key from target file
#
# Example usage:
# removeKey "PIHOLE_DNS_1" "/etc/pihole/setupVars.conf"
#######################
removeKey() {
  local key="${1}"
  local file="${2}"
  sed -i "/^${key}/d" "${file}"
}
