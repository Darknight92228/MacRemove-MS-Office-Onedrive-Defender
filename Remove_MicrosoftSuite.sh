#!/bin/zsh

## VARIABLES ##
APPARRAY=(
    "Microsoft Word"
    "Microsoft Excel"
    "Microsoft PowerPoint"
    "Microsoft Outlook"
    "Microsoft OneNote"
    "Microsoft Teams"
    "OneDrive"
    "Microsoft AutoUpdate"
    "Microsoft Defender"
)

## FORCE QUIT RUNNING MICROSOFT APPLICATIONS ##
echo "Close running Office applications, OneDrive, and Microsoft Defender"
for APP in "${APPARRAY[@]}"
do
  if pgrep -x "$APP" > /dev/null; then
    echo "Application $APP is running. Quitting application now..."
    osascript -e "quit app \"$APP\""
    sleep 2
    if pgrep -x "$APP" > /dev/null; then
      echo "Application $APP did not quit with osascript. Killing application now..."
      pkill -x "$APP"
    fi
  fi
done

## DETERMINE IF MICROSOFT APPLICATIONS ARE STILL RUNNING. IF SO, EXIT SCRIPT ##
echo "Determine what Office products, OneDrive, or Microsoft Defender are currently running..."
MicrosoftRunning=$(pgrep -l -f "Microsoft\|OneDrive")
if [ -z "$MicrosoftRunning" ]; then
  echo "No Microsoft applications are running. Continue removal script."
else
  echo "Microsoft applications are still running. Exiting script."
  echo "$MicrosoftRunning"
  exit 0
fi

## REMOVE OFFICE AND ONEDRIVE ICONS FROM DOCK ##
if [ -f /usr/local/bin/dockutil ]; then
  for APP in "${APPARRAY[@]}"
  do
    /usr/local/bin/dockutil --allhomes --remove "$APP"
  done
fi

## REMOVE APPLICATIONS FROM "/APPLICATIONS/"
for APP in "${APPARRAY[@]}"
do
    sudo rm -rf "/Applications/${APP}.app"
done

## REMOVE SUPPORTING OFFICE FILES FROM SYSTEM LIBRARY ##
sudo rm -rf "/Library/LaunchDaemons/com.microsoft.office.licensingV2.helper.plist"
sudo rm -rf "/Library/LaunchDaemons/com.microsoft.autoupdate.helper.plist"
sudo rm -rf "/Library/LaunchDaemons/com.microsoft.onedriveupdaterdaemon.plist"
sudo rm -rf "/Library/LaunchAgents/com.microsoft.update.agent.plist"
sudo rm -rf "/Library/PrivilegedHelperTools/com.microsoft.office.licensingV2.helper"
sudo rm -rf "/Library/PrivilegedHelperTools/com.microsoft.autoupdate.helper"
sudo rm -rf "/Library/Preferences/com.microsoft.office.licensingV2.plist"

## REMOVE MICROSOFT DEFENDER FILES FROM SYSTEM LIBRARY ##
sudo rm -rf "/Library/Application Support/Microsoft/Defender"
sudo rm -rf "/Library/LaunchDaemons/com.microsoft.wdav.daemon.plist"
sudo rm -rf "/Library/LaunchDaemons/com.microsoft.wdav.uninstall.plist"
sudo rm -rf "/Library/LaunchAgents/com.microsoft.wdav.tray.plist"
sudo rm -rf "/Library/Preferences/com.microsoft.wdav.plist"

## REMOVE ONEDRIVE BACKGROUND PROCESSES AND FILES ##
sudo rm -rf "/Library/LaunchAgents/com.microsoft.OneDrive*"
sudo rm -rf "/Library/LaunchDaemons/com.microsoft.OneDrive*"
sudo rm -rf "/Library/PrivilegedHelperTools/com.microsoft.OneDrive*"

## REMOVE SUPPORTING OFFICE, DEFENDER, AND ONEDRIVE FILES FROM END USER LIBRARIES ##
for USER_HOME in /Users/*
do 
    USER_NAME=$(basename "$USER_HOME")
    if [ "$USER_NAME" != "Shared" ] && [ "$USER_NAME" != "Deleted Users" ]; then
        sudo rm -rf "$USER_HOME/Library/Containers/com.microsoft.*"
        sudo rm -rf "$USER_HOME/Library/Cookies/com.microsoft.*"
        sudo rm -rf "$USER_HOME/Library/Group Containers/UBF8T346G9.*"
        sudo rm -rf "$USER_HOME/Library/Application Support/Microsoft/Defender"
        sudo rm -rf "$USER_HOME/Library/Preferences/com.microsoft.wdav.plist"
        sudo rm -rf "$USER_HOME/Library/Preferences/com.microsoft.OneDrive*"
        sudo rm -rf "$USER_HOME/Library/Application Support/OneDrive"
        sudo rm -rf "$USER_HOME/Library/Logs/OneDrive"
        sudo rm -rf "$USER_HOME/Library/Caches/com.microsoft.OneDrive*"
    fi
done

echo "Microsoft Office, Microsoft Defender, and OneDrive removal script has completed."