# workspace-prev.sh
#!/bin/bash
CURRENT=$(hyprctl activeworkspace -j | jq '.id')
MIN=1

if [ "$CURRENT" -gt "$MIN" ]; then
	hyprctl dispatch "hl.dsp.focus({workspace = 'e-1'})"
fi
