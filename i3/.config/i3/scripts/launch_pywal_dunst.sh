#!/bin/bash

[ -f "$HOME/.cache/wal/colors" ] && . "$HOME/.cache/wal/colors"

pidof dunst && killall dunst

dunst -lf  "${color0:-#ffffff}" \
      -lb  "${color1:-#eeeeee}" \
      -lfr "${color2:-#dddddd}" \
      -nf  "${color3:-#cccccc}" \
      -nb  "${color4:-#bbbbbb}" \
      -nfr "${color5:-#aaaaaa}" \
      -cf  "${color6:-#999999}" \
      -cb  "${color7:-#888888}" \
      -cfr "${color8:-#777777}" > /dev/null 2>&1 &
