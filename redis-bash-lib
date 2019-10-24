#!/bin/bash
# https://github.com/caquino/redis-bash

# -- redis-client
#
#  returns an array
#
# Args:
# value -- file descriptor
# value -- message to be sent (only read if blank)
#

if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "This script requires bash version 4+"
    exit 1
fi

function redis-client() {
  if [ ${#FUNCNAME[@]} -lt 100 ]; then
    FD=${1}
    shift;
    if [ ${#} -ne 0 ]; then # always use unified protocol and let the server validate the number of parameters
      local ARRAY=( "${@}" )
      local CMD=("*$[${#ARRAY[@]}]")
      local i=0
      for ((i=0;i<${#ARRAY[@]};i++)); do
        CMD=( "${CMD[@]}" "\$${#ARRAY[${i}]}" "${ARRAY[${i}]}" )
      done
      printf "%s\r\n" "${CMD[@]}" >&${FD}
    fi
    local ARGV
    read -r -u ${FD}

    if [ ${#REPLY} -eq 0 ]; then
        printf "error: no reply\n"
        exit 1
    fi

    REPLY=${REPLY:0:${#REPLY}-1}
    case ${REPLY} in
      -*|\$-*) # error message
        echo "${REPLY:1}"
        return 1;;
      \$*) # message size
        [ ${REPLY:1} -gt 0 ] && read -r -N $[${REPLY:1}+2] -u "${FD}" # read again to get the value itself
        ARGV=( "${REPLY:0:(-2)}" );;
      :*) # integer message
        ARGV=( "${REPLY:1}" );;
      \**) # bulk reply - recursive based on number of messages
        unset ARGV
        for ((ARGC="${REPLY:1}";${ARGC}>0;ARGC--)); do
          ARGV=("${ARGV[@]}" $(redis-client ${FD}))
        done;;
      +*) # standard message
        ARGV=( "${REPLY:1}" );;
      *) # wtf? just in case...
        ARGV=( "${ARGV[@]}" "${REPLY}" );;
    esac
    printf "%s\n" "${ARGV[@]}"
  else
    printf "ERROR: Recursive function call limit.\n"
  fi
}
