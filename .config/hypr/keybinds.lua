mainMod = "SUPER"

vimLeft = "H"
vimDown = "J"
vimUp = "K"
vimRight = "L"

---- OPEN PROGRAM SHORTCUTS
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd(colorPicker))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(print))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(emoji))

---- MANAGE LAYOUT
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))    -- dwindle only
-- move focus
hl.bind(mainMod .. "+" .. vimLeft, hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+" .. vimRight, hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+" .. vimUp, hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+" .. vimDown, hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + TAB", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
-- move windows
-- mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) --lmb
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- rmb
-- keyboard
hl.bind(mainMod.. " + SHIFT +" .. vimLeft, hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod.. " + SHIFT +" .. vimRight, hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod.. " + SHIFT +" .. vimUp, hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod.. " + SHIFT +" .. vimDown, hl.dsp.window.swap({ direction = "down" }))

---- WORKSPACES
-- mouse
hl.bind(mainMod .. " + mouse:275", hl.dsp.focus({ workspace = "e+1" })) -- mouse5 (next)
hl.bind(mainMod .. " + mouse:276", hl.dsp.focus({ workspace = "e-1" })) -- mouse4 (prev)
-- keyboard
hl.bind(mainMod .. " + P", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + O", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "e-1" }))
-- switch workspaces with mainMod + [0-9]
-- move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

---- MISC
-- Switch keyboard layout
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
--
local closeWindowBind = hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + delete", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


---- UNUSED

--hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
--closeWindowBind:set_enabled(false)

-- Example special workspace (scratchpad)
--hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
--hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Laptop multimedia keys for volume and LCD brightness
--hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
--hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
--hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
--hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
--hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
--hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })


