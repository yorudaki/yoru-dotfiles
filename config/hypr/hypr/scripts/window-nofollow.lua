local app_workspaces = {}

local ignored_apps = {
    ["xdg-desktop-portal"] = true,
    ["xdg-desktop-portal-gtk"] = true,
    ["xdg-desktop-portal-hyprland"] = true,

    ["polkit-gnome-authentication-agent-1"] = true,
    ["org.kde.polkit-kde-authentication-agent-1"] = true,

    ["pavucontrol"] = true,
    ["nm-connection-editor"] = true,

    ["blueman-manager"] = true,
    ["blueman-applet"] = true,

    ["xwaylandvideobridge"] = true,
}

hl.on("window.open", function(window)
    if window == nil then
        return
    end

    local class = window.initial_class
    
    if class == nil or class == "" then
        return
    end
    
    if ignored_apps[class] then
        return
    end

    local workspace = window.workspace

    if workspace == nil then
        return
    end

    local workspace_id = workspace.id

    if workspace_id == nil then
        return
    end
    
    if app_workspaces[class] == nil then
        app_workspaces[class] = workspace_id

        return
    end
    
    local target = app_workspaces[class]
    
    if workspace_id == target then
        return
    end
    
    hl.dispatch(
        hl.dsp.window.move({
            window = window,
            workspace = tostring(target),
            follow = false
        })
    )
end)