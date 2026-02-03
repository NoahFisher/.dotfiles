# claude-dashboard

Displays all running Claude Code sessions across your tmux server with real-time status detection.

## Usage

```bash
claude-dashboard              # print status list and exit
claude-dashboard --list       # same as above
claude-dashboard -i           # interactive fzf picker with auto-refresh
claude-dashboard --interactive
claude-dashboard -w           # watch mode, re-renders every 2s
claude-dashboard --watch
```

## tmux keybinding

`prefix + a` opens the interactive picker as a floating popup (80% x 70%).

Defined in `tmux/.tmux.conf`:
```
bind-key a display-popup -w 80% -h 70% -E "claude-dashboard --interactive"
```

## How it works

### Session discovery

Lists all tmux panes via:
```
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command} #{pane_current_path} #{pane_activity}'
```

Claude Code sets its process name to the semver version (e.g. `2.1.29`), so panes are filtered where `pane_current_command` matches `^[0-9]+\.[0-9]+\.[0-9]+$`.

### Status detection

For each Claude pane, captures the last 30 lines (`tmux capture-pane -t <target> -p | tail -30`) and matches patterns in priority order:

| Priority | Pattern | Status |
|----------|---------|--------|
| 1 | `Do you want to proceed`, `Yes, allow`, `No, and tell Claude` | **WAITING** |
| 2 | `Tab to amend`, `Esc to cancel` | **WAITING** |
| 3 | `esc to interrupt`, `ctrl+c to interrupt` | **RUNNING** |
| 4 | Active spinner words ending in `…` (e.g. `Brewing…`, `Germinating…`, `Baking…`) | **RUNNING** |
| 5 | None of the above | **IDLE** |

Note: Past-tense completion messages like `Brewed for 38s` are deliberately excluded from RUNNING detection — the `…` suffix distinguishes active spinners from completion summaries.

### Context extraction

Each entry shows contextual activity text:

- **WAITING**: The last `⏺` action line (the command being asked about)
- **RUNNING**: The last progress/spinner line
- **IDLE**: The last user prompt (text after `❯`)

### Sorting

Entries are sorted by:
1. Status priority: WAITING (0) → RUNNING (1) → IDLE (2)
2. Within each group: most recently active first (by `pane_activity` timestamp, descending)

### Interactive mode

Uses fzf with:
- **Tab-delimited fields**: hidden pane target in field 1, display text in field 2
- **Preview pane**: live capture of the selected pane's content (`tmux capture-pane -t {1} -p | tail -40`)
- **Auto-refresh**: a background process sends `reload()` commands to fzf's `--listen` port every 3s via curl
- **Manual refresh**: `ctrl-r`
- **Session switching**: selecting an entry runs `tmux switch-client -t <session:window.pane>`

### Colors

Uses Catppuccin Mocha palette via 24-bit ANSI escape codes:
- Running: green `#a6e3a1`
- Waiting: yellow `#f9e2af`
- Idle: grey `#6c7086`
- Text: `#cdd6f4`
- Dim/borders: `#45475a`

## Dependencies

- tmux
- fzf (0.67+ for `--listen` auto-refresh support)
- curl (for poking fzf's listen port)
- grep, sed, cut, sort (standard unix)

## Design decisions

**Why bash instead of zsh?** The script was originally zsh but hit multiple issues: `status` and `path` are read-only zsh builtins, and `local var=value` in zsh subshell pipe contexts prints the assignment to stdout. Bash avoids all of these.

**Why `\x1f` (Unit Separator) as delimiter?** Pane content frequently contains `|`, `:`, tabs, and other common delimiters. The ASCII Unit Separator character is designed for exactly this purpose and never appears in terminal output.

**Why `--listen` + curl instead of fzf's built-in reload?** fzf doesn't have a `sleep()` action, so there's no way to create a polling loop purely within fzf bindings. The `--listen` HTTP API lets an external background process trigger reloads on a timer.

**Why `display-popup` instead of `split-window`?** A split competes with existing pane layout — if you already have vertical splits, the dashboard gets squeezed into a narrow column. `display-popup` overlays a floating window that doesn't disturb the layout.
