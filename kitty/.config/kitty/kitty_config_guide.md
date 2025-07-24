# Kitty Configuration Guide: Emulating Tmux Workflow

This guide will help you leverage Kitty's powerful features to mimic your preferred Tmux workflow, focusing on window/tab management, pane/split control, and session handling.

## 1. `kitty.conf` - The Core Configuration File

Your main Kitty configuration is located at `~/.config/kitty/kitty.conf`. This file controls everything from fonts and colors to keybindings and window behavior.

## 2. Keybindings for Tmux-like Navigation

We've updated your `kitty.conf` with these. Here's a breakdown of the keybindings and their Tmux equivalents:

*   **`kitty_mod`**: This is `ctrl+space`. It acts as your "modifier" key, similar to the tmux prefix. **IMPORTANT: You must HOLD DOWN `ctrl+space` while pressing the subsequent key.** Kitty does not have a "prefix mode" like tmux where you press and release.

    ```conf
    # In kitty.conf
    kitty_mod ctrl+space
    ```

*   **Tab Management (Tmux "Windows")**
    *   **New Tab**: `ctrl+space+c` (Tmux: `prefix + c`)
        ```conf
        map ctrl+space+c new_tab_with_cwd
        ```
    *   **Close Tab**: `ctrl+space+x` (Tmux: `prefix + x`)
        ```conf
        map ctrl+space+x close_tab
        ```
    *   **Navigate between tabs**: `ctrl+l` (next) and `ctrl+h` (previous) (Tmux: `prefix + n/p` or `prefix + right/left`)
        ```conf
        map ctrl+l next_tab
        map ctrl+h previous_tab
        ```
    *   **Go to specific tab by number**: `ctrl+space+1` through `ctrl+space+9` (Tmux: `prefix + 1..9`)
        ```conf
        map ctrl+space+1 goto_tab 1
        map ctrl+space+2 goto_tab 2
        # ... up to 9
        ```
    *   **Show list of tabs**: `ctrl+space+s` (Tmux: `prefix + s`)
        ```conf
        map ctrl+space+s show_tabs
        ```
    *   **Move Tab Forward**: `ctrl+space+.` (Tmux: `prefix + }`)
        ```conf
        map ctrl+space+. move_tab_forward
        ```
    *   **Move Tab Backward**: `ctrl+space+,` (Tmux: `prefix + {`)
        ```conf
        map ctrl+space+, move_tab_backward
        ```
    *   **Custom: Open Notes Tab**: `ctrl+space+h` (Mimics your `bind-key h new-window "nvim ~/notes.md"`)
        ```conf
        map ctrl+space+h launch --type=tab nvim ~/notes.md
        ```

*   **Split Management (Tmux "Panes")**
    *   **Vertical Split**: `ctrl+e` (Tmux: `prefix + %`)
        ```conf
        map ctrl+e launch --location=vsplit --cwd=current
        ```
    *   **Horizontal Split**: `ctrl+o` (Tmux: `prefix + "`)
        ```conf
        map ctrl+o launch --location=hsplit --cwd=current
        ```
    *   **Navigate Splits**: `ctrl+space+j/k/l/h` (Tmux: `prefix + arrow keys` or `prefix + h/j/k/l`)
        ```conf
        map ctrl+space+j neighboring_window down
        map ctrl+space+k neighboring_window up
        map ctrl+space+l neighboring_window right
        map ctrl+space+h neighboring_window left
        ```
    *   **Resize Splits**: `ctrl+space+alt+j/k/l/h` (Tmux: `prefix + resize-pane`)
        ```conf
        map ctrl+space+alt+j resize_window down 2
        map ctrl+space+alt+k resize_window up 2
        map ctrl+space+alt+h resize_window right 2
        map ctrl+space+alt+l resize_window left 2
        ```
    *   **Zoom Split**: `ctrl+space+z` (Tmux: `prefix + z`)
        ```conf
        map ctrl+space+z toggle_layout stack
        ```
        *Note: `toggle_layout stack` will make the current split full screen. Press again to revert.*

*   **Miscellaneous**
    *   **Reload Config**: `ctrl+space+r` (Tmux: `prefix + r source-file ...`)
        ```conf
        map ctrl+space+r load_config_file
        ```

## 3. Kitty Sessions - Your Tmux Session Alternative

Kitty sessions allow you to define complex window and split layouts, along with the commands to run in each. They are `.conf` files that Kitty executes.

**Creating a Session File:**

1.  Create a new file, for example, `~/.config/kitty/my-project-session.conf`.
2.  Define your layout using Kitty's session commands:

    ```conf
    # ~/.config/kitty/my-project-session.conf

    # Set the default layout for new tabs in this session
    layout splits

    # --- First Tab: Development Environment ---
    new_tab MyProjectDev
    # Change directory for this tab
    cd ~/projects/my-project
    # Launch a shell in the first split
    launch
    # Create a vertical split
    launch --location=vsplit
    # Run nvim in the new split
    launch nvim .
    # Create a horizontal split in the right pane
    launch --location=hsplit
    # Run git status in the new split
    launch git status

    # --- Second Tab: Monitoring/Logs ---
    new_tab MyProjectLogs
    cd ~/projects/my-project/logs
    launch tail -f app.log
    # Create a vertical split
    launch --location=vsplit
    launch htop

    # --- Third Tab: Scratchpad ---
    new_tab Scratchpad
    launch
    ```

    *   `new_tab [title]`: Creates a new tab. You can optionally give it a title.
    *   `cd /path/to/dir`: Sets the working directory for the subsequent `launch` commands in that tab/split.
    *   `launch [command]`: Launches a command in the current split. If no command is given, it launches your default shell.
    *   `launch --location=vsplit` / `hsplit`: Creates a new split (vertical or horizontal) and moves the focus to it. Subsequent `launch` commands will run in this new split.

**Launching a Session:**

*   **Directly:**
    ```bash
    kitty --session ~/.config/kitty/my-project-session.conf
    ```
    This will open a new Kitty OS window with the defined session.

*   **Using the Session Manager Script (Recommended for Tmux-like behavior):**
    ```bash
    /home/nicolas/.config/kitty/sessions/kitty_session_manager.py MyProjectSessionName ~/.config/kitty/sessions/my-project-session.conf
    ```
    This script will check if `MyProjectSessionName` is already running in a Kitty window. If it is, it will focus that window. Otherwise, it will launch a new window with the session.

## 4. Enabling Remote Control for Session Management Script

For the `kitty_session_manager.py` script to work, Kitty's remote control feature must be enabled.

In your `kitty.conf`, ensure these lines are present and configured:

```conf
# Enable remote control
allow_remote_control yes

# Listen on a Unix socket (recommended for security and performance)
# You can choose a different path if /tmp is not suitable
listen_on unix:/tmp/kitty_remote
```

---
