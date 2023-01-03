#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title del-space
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "del_space_number","optional": false}


on run argv
    do shell script "open -b 'com.apple.exposelauncher'"
    delay 0.3
    do shell script "/opt/homebrew/bin/cliclick m:+0,0"
    tell application id "com.apple.systemevents"
        tell list 1 of group 2 of group 1 of group 1 of process "Dock"
            set countSpaces to count of buttons
            if countSpaces is greater than 1 then
                perform action "AXRemoveDesktop" of button (item 1 of argv as integer)
            end if
        end tell
        delay 1
        key code 53 -- esc key
    end tell
end run