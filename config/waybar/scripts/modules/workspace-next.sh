# workspace-next.sh
#!/bin/bash
CURRENT=$(hyprctl activeworkspace -j | jq '.id')
MAX=5

if [ "$CURRENT" -lt "$MAX" ]; then
	hyprctl dispatch "hl.dsp.focus({workspace = 'e+1'})"
fi
