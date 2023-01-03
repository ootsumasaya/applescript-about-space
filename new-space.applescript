#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title new-space
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title new-space
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

on run
    my make_new_space()
    delay 0.3
    my move_new_space()
end run

on make_new_space()
    do shell script "open -b 'com.apple.exposelauncher'"
    delay 0.3
    tell application id "com.apple.systemevents"
        tell (every application process whose bundle identifier = "com.apple.dock")
            click (button 1 of group 2 of group 1 of group 1)
        end tell
    end tell
end make_new_space

on move_new_space()
    -- search current and new space
    set command to "/usr/libexec/PlistBuddy -c " & ¬
        "\"print :SpacesDisplayConfiguration:Management\\ Data:Monitors:0:Current\\ Space:uuid\" " & ¬
        "${HOME}/Library/Preferences/com.apple.spaces.plist"
    set current_uuid to (do shell script command)
    set i to 0
    repeat
        try
            set command to "/usr/libexec/PlistBuddy -c " & ¬
                "\"print :SpacesDisplayConfiguration:Management\\ Data:Monitors:0:Spaces:" & i & ":uuid\" " & ¬
                "${HOME}/Library/Preferences/com.apple.spaces.plist"
            set tmp_uuid to (do shell script command)
            if current_uuid = tmp_uuid then
                set current_space_num to i + 1
            end if
            set i to i + 1
        on error
            exit repeat
        end try
        tell application id "com.apple.systemevents"
            tell list 1 of group 2 of group 1 of group 1 of process "Dock"
                set new_space_num to count of buttons
            end tell
        end tell
    end repeat
    -- move new space to right of current space
    tell application id "com.apple.systemevents"
        tell (every application process whose bundle identifier = "com.apple.dock")
            tell button new_space_num of list 1 of group 2 of group 1 of group 1
                set p to position
                set s to size
                set x1 to {(item 1 of item 1 of p) + (item 1 of item 1 of s) / 2} as integer
                set y1 to {(item 2 of item 1 of p) + (item 2 of item 1 of s) / 2} as integer
            end tell
            tell button current_space_num of list 1 of group 2 of group 1 of group 1
                set p to position
                set s to size
                set x2 to {(item 1 of item 1 of p) + (item 1 of item 1 of s)*0.8} as integer
                set y2 to {(item 2 of item 1 of p) + (item 2 of item 1 of s) / 2} as integer
            end tell
            do shell script "/opt/homebrew/bin/cliclick -e 50 -w 500 m:" & x1 & "," & y1 & " dd:" & x1 & "," & y1 & " dm:" & x2 & "," & y2 & " du:" & x2 & "," & y2 & " kp:esc"
        end tell
    end tell
end move_new_space