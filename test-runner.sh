file=$1
line=$2

if (( $# == 1 )); then
  command="rspec $file"
elif (( $# == 2 )); then
  command="rspec $file:$line"
else
  command=""
fi

osascript << EOF > /dev/null 2>&1
  set command to "$command"

  tell application "iTerm2"
    tell first session of current tab of current window
      write text command
    end tell
  end tell
EOF
