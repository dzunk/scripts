#!/usr/bin/env bash
#
# batt.sh
# Battery status indicator for the tmux status bar

RED='#[fg=red]'
YELLOW='#[fg=yellow]'
GREEN='#[fg=green]'

BATT='🔋'
CHARGING='⚡'
AC='🔌'

PWR_SRC=$(pmset -g batt | awk 'NR<2 { print $4 }' | sed "s/'//")
PERCENT=$(pmset -g batt | awk 'NR>1 { print $3 }' | sed "s/%;//")

if [[ $PWR_SRC == 'AC' ]]; then
  if [[ $PERCENT == '100' ]]; then
    ICON=$AC
    COLOR=$GREEN
  else
    ICON=$CHARGING
    COLOR=$GREEN
  fi
else
  ICON=$BATT
  if [[ $PERCENT -gt 60 ]]; then
    COLOR=$GREEN
  elif [[ $PERCENT -gt 20 ]]; then
    COLOR=$YELLOW
  else
    COLOR=$RED
  fi
fi

echo -e "$ICON $COLOR $PERCENT%"
