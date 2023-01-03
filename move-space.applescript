#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title move-space
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "from_space_number","optional": false}
# @raycast.argument2 { "type": "text", "placeholder": "to_space_number","optional": false}


on run argv
    do shell script "open -b 'com.apple.exposelauncher'"
    delay 0.3
    do shell script "/opt/homebrew/bin/cliclick m:+0,0"
    tell application id "com.apple.systemevents"
        tell (every application process whose bundle identifier = "com.apple.dock")
            tell button (item 1 of argv as integer) of list 1 of group 2 of group 1 of group 1
                set p to position
                set s to size
                set x1 to {(item 1 of item 1 of p) + (item 1 of item 1 of s) / 2} as integer
                set y1 to {(item 2 of item 1 of p) + (item 2 of item 1 of s) / 2} as integer
            end tell
            tell button (item 2 of argv as integer) of list 1 of group 2 of group 1 of group 1
                set p to position
                set s to size
                set x2 to {(item 1 of item 1 of p) + (item 1 of item 1 of s)*0.8} as integer
                set y2 to {(item 2 of item 1 of p) + (item 2 of item 1 of s) / 2} as integer
            end tell
            do shell script "/opt/homebrew/bin/cliclick -e 50 -w 500 m:" & x1 & "," & y1 & " dd:" & x1 & "," & y1 & " dm:" & x2 & "," & y2 & " du:" & x2 & "," & y2 & " kp:esc"
        end tell
    end tell
end run