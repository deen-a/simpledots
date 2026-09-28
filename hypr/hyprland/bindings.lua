---------------------
---- KEYBINDINGS ----
---------------------
-- ~/.config/hypr/bindings.lua
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more


-- Lua Keybind Variables
local terminal = "kitty"
local fileManager = "thunar"
local menu = "~/.config/rofi/launchers/type-2/launcher.sh"
local dmenu = "$HOME/.config/rofi/launchers/type-1/style-11.rasi"
local browser = "/usr/bin/firefox --enable-features=UseOzonePlatform --ozone-platform=wayland"
local waybar = "~/.config/waybar/scripts/launch.sh"
local discord = '/usr/bin/discord'

local mainMod = "SUPER" -- Sets "Windows" key as main modifier


-- Show App Launcher & Screen Locking
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprlock"))

-- Main App & Window Binds
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", 	   hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + X", 	   hl.dsp.window.close())
hl.bind(mainMod .. " + M", 	   hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + E", 	   hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofi -show emoji -theme " .. dmenu .. " | wl-copy"))
hl.bind(mainMod .. " + V", 	   hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + V",  hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme " .. dmenu .. " -p \"Clipboard\" | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + C",         hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(mainMod .. " + P",	   hl.dsp.window.pseudo())
hl.bind(mainMod .. " + O",	   hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", 	   hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + B",	   hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R",	   hl.dsp.exec_cmd(waybar))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.dpms({ action = "disable" }))
hl.bind(mainMod .. " + ALT + R", hl.dsp.dpms({ action = "enable" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(discord))

-- OBS
hl.bind("ALT + R", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
hl.bind("ALT + SHIFT + R", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))


-- Workspaces Navigation and Window Navigation Between Workspaces
for i = 1, 10 do
    local key = i % 10 -- maps 10 to 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end


-- Arrow keys / HJKL keys (nvim characters) in use for window manipulations
local directions = { left = "left", right = "right", up = "up", down = "down", H = "left", L= "right", K = "up", J = "down" }

local dirsval = {
    left = { x=-20, y=0 }, up = {  x=0, y=-20 },
    right = { x=20, y=0 }, down = { x=0, y=20 }, 
    H = { x=-20, y=0 },    K = { x=0, y=-20 },
    L = { x=20,  y=0 },    J = { x=0, y=20 },
}

for binds, dirs in pairs(directions) do
    --Move window focus
    hl.bind(mainMod .. " + " .. binds,  hl.dsp.focus({ direction = tostring(dirs) }))
    
    -- Swap window
    hl.bind(mainMod .. " + CTRL + " .. binds, hl.dsp.window.move({ direction = tostring(dirs) }))
end

for binds, axis in pairs(dirsval) do
    -- Resize window
    hl.bind(mainMod .. " + SHIFT + " .. binds, hl.dsp.window.resize({ x = axis.x,y = axis.y,relative = true}), { repeating = true })
    -- Move window 
    hl.bind(mainMod .. " + ALT + " .. binds, hl.dsp.exec_cmd(string.format("hyprctl dispatch moveactive %d %d", axis.x, axis.y)), { repeating = true })
end


-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", 	 hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll existing workspaces with SUPER + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse (bindm changes to default dispatcher)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot Bindings
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots")) -- Fullscreen
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots")) -- Active Window
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots")) -- Field / Area

-- Toggle keyboard language switching
hl.bind(mainMod .. " + ALT + SHIFT", function() hl.dispatch("switchxkblayout next") end)


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

