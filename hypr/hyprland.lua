-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

require("hyprland/bindings")
require("hyprland/decorations")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "1920x0",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1"
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "~/.config/rofi/launchers/type-2/launcher.sh"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
    -- UI & Functionality
    hl.exec_cmd("awww-daemon & waybar & swaync")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("wl-paste --type text --watch cliphist store && $HOME/.local/bin/cliphist-trim.sh")
    hl.exec_cmd("wl-paste --type image --watch cliphist store && $HOME/.local/bin/cliphist-trim.sh")

    hl.exec_cmd("hypridle & /usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("/bin/warp-taskbar")
    hl.exec_cmd("fcitx5 -d")
--    hl.exec_cmd("gnome-keyring-daemon")


    -- Theming
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'char-white'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("GTK_THEME","Breeze-Dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ADW_DISABLE_PORTAL", 1)

-- Multilingual keyboard
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

hl.env("XCURSOR_THEME", "WhiteSur-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us, jp",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
	    scroll_factor = 0.9,
	    disable_while_typing = false
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

for i = 1, 8 do
    local dfl
    if i ==1 then dfl = "default = true" else dfl = "default = false" end 
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", dfl })
end
for i = 9, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", default = true})
end
-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

--- Thunar Transparent ---
--- Format: opacity <active> <inactive>, class:^(app_class)$
hl.window_rule({
    name = "thunar_transparent",
    match = { class = [[^(?i).*thunar.*$]] },
    opacity = "0.90 0.80",
})

--hl.window_rule({
--    name = "thunar_transparent",
--    match = { class = "thunar" },
--    opacity = "0.90 0.80",
--})

hl.window_rule({
    name = "waydroid scalability",
    match = { class = "(?i).*waydroid.*" },
    no_max_size = true,
    persistent_size = true,
})

hl.window_rule({
    name = "macro external monitors",
    match = { class = [[^(?i).*virt-manager.*$ | ^(?i).*remote-viewer>*$]] },
    monitor = "HDMI-A-1",
    fullscreen = true
})
