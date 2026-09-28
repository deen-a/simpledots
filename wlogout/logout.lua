local function grace_logout()
    os.execute("killall -s SIGTERM firefox 2>/dev/null")
    os.execute("sleep 1")
    os.execute("killall -s SIGTERM Hyprland")
end

grace_logout()

