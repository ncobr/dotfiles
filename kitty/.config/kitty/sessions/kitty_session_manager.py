#!/usr/bin/env python3

import subprocess
import sys
import json
import os

def get_kitty_windows():
    try:
        result = subprocess.run(['kitty', '@', 'ls', '--all', '--json'], capture_output=True, text=True, check=True)
        return json.loads(result.stdout)
    except (subprocess.CalledProcessError, json.JSONDecodeError) as e:
        print(f"Error getting kitty windows: {e}", file=sys.stderr)
        return []

def focus_kitty_window(window_id):
    try:
        subprocess.run(['kitty', '@', 'focus-window', '--match', f'id:{window_id}'], check=True)
        print(f"Focused on kitty window ID: {window_id}")
    except subprocess.CalledProcessError as e:
        print(f"Error focusing kitty window: {e}", file=sys.stderr)

def main():
    if len(sys.argv) < 3:
        print("Usage: kitty_session_manager.py <session_name> <session_file_path>", file=sys.stderr)
        sys.exit(1)

    session_name = sys.argv[1]
    session_file_path = os.path.expanduser(sys.argv[2]) # Expand ~ to home directory

    windows = get_kitty_windows()
    found_window_id = None

    for os_window in windows:
        for tab in os_window.get('tabs', []):
            # Kitty session files can set the tab title. We'll use this to identify.
            if tab.get('title') == session_name:
                found_window_id = os_window.get('id')
                break
        if found_window_id:
            break

    if found_window_id:
        focus_kitty_window(found_window_id)
    else:
        print(f"No existing session '{session_name}' found. Launching new session from {session_file_path}...")
        try:
            # Launch a new OS window with the session file
            subprocess.Popen(['kitty', '--session', session_file_path, '--title', session_name])
        except Exception as e:
            print(f"Error launching new kitty session: {e}", file=sys.stderr)

if __name__ == "__main__":
    main()
