# GUI-Friendly Keybindings

This profile adds VS Code/Cursor-style shortcuts without removing LazyVim's
native leader mappings. It is enabled by default and can be disabled without
deleting any configuration.

## Enable, Disable, and Inspect

| Goal | Command or change |
|---|---|
| Show current state | `:GuiKeybindingsStatus` |
| Disable for one launch | `NVIM_GUI_KEYS=0 nvim` |
| Force-enable for one launch | `NVIM_GUI_KEYS=1 nvim` |
| Disable persistently | Set `default_enabled = false` in `lua/config/gui_keybindings.lua`, then restart Neovim |
| Enable persistently | Set `default_enabled = true` in `lua/config/gui_keybindings.lua`, then restart Neovim |
| Disable Ghostty forwarding | Comment the `config-file = /Users/tarik/zshFiles/symlinks/misc/ghostty_gui_keybindings` line in `ghostty_config`, then reload Ghostty |
| Enable Ghostty forwarding | Uncomment the include line, then press `Cmd+Shift+,` to reload Ghostty |

`NVIM_GUI_KEYS` accepts `1`, `true`, `yes`, or `on` to enable and `0`, `false`,
`no`, or `off` to disable. Environment overrides take precedence over
`default_enabled`.

Neovim mappings and options are selected during startup. Changing the profile
requires restarting Neovim.

## Terminology

- **Editor tab** means a Neovim buffer shown in Bufferline.
- **Editor group** means a Neovim window or split.
- **Copy** is Vim's yank operation using the system clipboard.
- Modes: **N** Normal, **I** Insert, **V** Visual, **S** Select, **T** Terminal.

## Files, Commands, and Editor Tabs

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| N/I/V/S | `Ctrl+S` | LazyVim saved and returned to Normal mode | Save File | Writes the current file |
| N/I/V/S | `Cmd+S` | No Neovim mapping | Save File | Ghostty does not claim this key |
| N | `Ctrl+P` | Move one line up | Quick Open File | Opens the Snacks file picker at the project root; Insert-mode completion remains unchanged |
| N | `Cmd+P` | No Neovim mapping | Quick Open File | Opens the Snacks file picker; Ghostty does not claim this key |
| N | `Ctrl+Shift+P` | No custom mapping | Show Commands | Opens the Snacks command picker |
| N | `F1` | No custom mapping | Show Commands | Opens the Snacks command picker |
| N | `Ctrl+N` | Move one line down | New File | Creates an empty editor; Insert-mode completion remains unchanged |
| N | `Alt+W` | No custom mapping | Close Editor | Uses `Snacks.bufdelete()` and prompts for modified files |
| N | `Ctrl+F4` | No custom mapping | Close Editor | Same safe close behavior as `Alt+W` |
| N/I/V/S | `Ctrl+Tab` | Ghostty selected its next terminal tab | Next Editor Tab | Ghostty forwarding releases this key to Neovim |
| N/I/V/S | `Ctrl+Shift+Tab` | Ghostty selected its previous terminal tab | Previous Editor Tab | Ghostty forwarding releases this key to Neovim |

Ghostty terminal tabs remain available through `Cmd+Shift+[` and
`Cmd+Shift+]`.

## Search

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| N/I/V/S | `Ctrl+F` | Normal mode scrolled forward; other modes had native behavior | Find in File | Opens `/` search |
| N | `Ctrl+Shift+F` | No custom mapping | Search Project | Opens Snacks grep at the project root |
| N | `Ctrl+Shift+H` | No custom mapping | Replace in Project | Opens Grug Far |
| N | `F3` | No custom mapping | Next Search Result | Uses LazyVim's corrected `n` behavior |
| N | `Shift+F3` | No custom mapping | Previous Search Result | Uses LazyVim's corrected `N` behavior |

`Cmd+F` remains Ghostty's terminal scrollback search and is intentionally not
reassigned.

## Movement and Selection

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| N/I/S | `Shift+Arrow` | Ghostty adjusted terminal-screen selection | Select or Extend Selection | Ghostty releases all four keys; Neovim Select mode handles them |
| Mouse | Drag selection | Neovim Visual selection | Neovim Select selection | Typing replaces the selected text |
| N/I | `Option+Left` | Ghostty sent `Esc+b`; Insert mode could unexpectedly exit | Move One Word Left | Ghostty releases the key to the mode-aware Neovim mapping |
| N/I | `Option+Right` | Ghostty sent `Esc+f`; Insert mode could unexpectedly exit | Move One Word Right | Ghostty releases the key to the mode-aware Neovim mapping |
| N/I/S | `Shift+Option+Left` | No custom mapping | Select One Word Left | Starts or extends Select mode |
| N/I/S | `Shift+Option+Right` | No custom mapping | Select One Word Right | Starts or extends Select mode |

Plain arrow keys continue to move the cursor. `hjkl` remains available for
native Vim commands and plugins, but the profile does not require it.
Selections use exclusive end positions, matching GUI editors rather than
Neovim's stock inclusive selection.

## Clipboard and Undo

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| N/I/S | `Ctrl+A` | Increment number in Normal mode; native Insert behavior | Select All | Selects the entire file in Select mode |
| V/S | `Ctrl+C` | Cancelled or left the selection | Copy | Copies to the system clipboard |
| V/S | `Ctrl+X` | Subtracted numbers or used native selection behavior | Cut | Deletes into the system clipboard |
| I | `Ctrl+V` | Insert the next character literally | Paste | Inserts the system clipboard |
| V/S | `Ctrl+V` | Entered block Visual mode or used native selection behavior | Paste | Replaces the selection without overwriting the clipboard |
| N | `Ctrl+V` | Enter block Visual mode | Unchanged | Normal-mode block selection is deliberately preserved |
| N/I/S | `Ctrl+Z` | Suspended Neovim in Normal mode or used native mode behavior | Undo | Shell `Ctrl+Z` remains unchanged outside Neovim |
| N/I/S | `Ctrl+Shift+Z` | No custom mapping | Redo | Redoes the most recently undone change |

Ghostty continues to own `Cmd+A`, `Cmd+C`, `Cmd+V`, `Cmd+Z`, and
`Cmd+Shift+Z`. Those shortcuts operate on terminal selection, terminal
clipboard, or terminal scrollback, not Neovim text.

## Code

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| N | `F2` | No custom mapping | Rename Symbol | Calls LSP rename |
| N | `F12` | No custom mapping | Go to Definition | Calls LSP definition |
| N | `Shift+F12` | No custom mapping | Find References | Calls LSP references |
| N/V | `Ctrl+.` | No custom mapping | Code Action | Calls the LSP code-action menu |
| N/V | `Cmd+.` | No custom mapping | Code Action | Ghostty does not claim this key |
| N | `Option+/` | No custom mapping | Toggle Line Comment | Uses the active commenting provider |
| V | `Option+/` | No custom mapping | Toggle Selection Comment | Comments or uncomments the selection |
| N | `Cmd+/` | No custom mapping | Toggle Line Comment | Ghostty does not claim this key |
| V | `Cmd+/` | No custom mapping | Toggle Selection Comment | Comments or uncomments the selection |
| N/V | `Shift+Option+F` | No custom mapping | Format Document | Forces LazyVim formatting |
| N | `F8` | No custom mapping | Next Problem | Moves to the next diagnostic and opens its message |
| N | `Shift+F8` | No custom mapping | Previous Problem | Moves to the previous diagnostic |
| N | `Ctrl+Shift+M` | No custom mapping | Show Problems | Opens the Snacks diagnostics picker |

LSP shortcuts require an attached language server. Function keys may require
holding the Mac keyboard's `Fn` key, depending on macOS keyboard settings.

## Editor Groups and Terminal

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| N | `Ctrl+Option+Left` | No custom mapping | Focus Left Editor Group | Avoids macOS Spaces shortcuts that own plain `Ctrl+Left/Right` |
| N | `Ctrl+Option+Right` | No custom mapping | Focus Right Editor Group | Focuses the adjacent split |
| N | `Ctrl+Option+Up` | No custom mapping | Focus Upper Editor Group | Focuses the adjacent split |
| N | `Ctrl+Option+Down` | No custom mapping | Focus Lower Editor Group | Focuses the adjacent split |
| N | `Ctrl+Option+Shift+Left` | No custom mapping | Shrink Editor Group Width | Resizes by two columns |
| N | `Ctrl+Option+Shift+Right` | No custom mapping | Grow Editor Group Width | Resizes by two columns |
| N | `Ctrl+Option+Shift+Up` | No custom mapping | Grow Editor Group Height | Resizes by two rows |
| N | `Ctrl+Option+Shift+Down` | No custom mapping | Shrink Editor Group Height | Resizes by two rows |
| N | `Ctrl+\` | Prefix for native mode-forcing commands | Split Editor Right | Native `<leader>\|` remains available |
| N/T | `` Ctrl+` `` | No custom mapping | Toggle Terminal | Opens or focuses the project-root Snacks terminal |

## Explorer

Arrow Up/Down, Enter, and Backspace already worked in Snacks Explorer and stay
unchanged. The profile adds or changes:

| Context | Key | Before | GUI profile | Triggered action / notes |
|---|---|---|---|---|
| Explorer | `Left` | No explorer-specific action | Collapse Directory | Closes the selected directory |
| Explorer | `Right` | No explorer-specific action | Open | Opens a file or toggles a directory |
| Explorer | `F2` | No explorer-specific action | Rename | Renames the selected file or directory |
| Explorer | `Delete` | No explorer-specific action | Delete | Moves the selected path to trash after confirmation |
| Explorer | `Ctrl+C` | Set terminal working directory | Copy File Paths | Copies selected paths for Explorer paste |
| Explorer | `Ctrl+V` | Open in a vertical split | Paste Files | Copies the paths stored by Explorer into the current directory |

The original Explorer keys (`a`, `r`, `d`, `y`, `p`, and others) remain
available.

## Friendly LazyVim Labels

These keys keep their original behavior. Only their visible descriptions use
GUI-editor terminology.

| Key | Before label | GUI profile label |
|---|---|---|
| `Shift+H` / `[b` | Previous Buffer | Previous Editor Tab |
| `Shift+L` / `]b` | Next Buffer | Next Editor Tab |
| `<leader>,` | Buffers | Open Editor Tabs |
| `<leader>bd` | Delete Buffer | Close Editor |
| `<leader>bo` | Delete Other Buffers | Close Other Editors |
| `<leader>bi` | Delete Invisible Buffers | Close Hidden Editors |
| `<leader>bD` | Delete Buffer and Window | Close Editor and Group |
| `<leader>wd` | Delete Window | Close Editor Group |
| `<leader>b` group | buffer | editor tabs |
| `<leader>w` group | windows | editor groups |

## Bufferline

| Behavior | Before | GUI profile |
|---|---|---|
| Visibility | LazyVim hid the bar when only one editor was open | Always visible |
| Left click | Select editor | Unchanged |
| Close icon | Safely close through `Snacks.bufdelete()` | Unchanged |
| Right click | Safely close through `Snacks.bufdelete()` | Unchanged |
| Middle click | No action | Safely close through `Snacks.bufdelete()` |

## Ghostty Forwarding

The optional `ghostty_gui_keybindings` file removes only bindings that must
reach Neovim:

| Ghostty key | Before | With include |
|---|---|---|
| `Ctrl+Tab` | Next Ghostty tab | Forward to child application |
| `Ctrl+Shift+Tab` | Previous Ghostty tab | Forward to child application |
| `Shift+Left/Right/Up/Down` | Adjust Ghostty terminal selection | Forward to child application |
| `Option+Left` | Send `Esc+b` | Forward the distinct modified-arrow key |
| `Option+Right` | Send `Esc+f` | Forward the distinct modified-arrow key |

The include affects every program running in Ghostty, not only Neovim. Disable
the include when a terminal application needs Ghostty's original handling.

Ghostty keeps ownership of `Cmd+W`, `Cmd+F`, `Cmd+A`, `Cmd+C`, `Cmd+V`,
`Cmd+Z`, and other standard terminal/window shortcuts.

## Editor Options

| Option | Before | GUI profile |
|---|---|---|
| `scrolloff` | `4` lines | `8` lines |
| `selection` | `inclusive` | `exclusive`, matching GUI selection end positions |
| `selectmode` | Empty | `mouse,key` |
| `keymodel` | Empty | `startsel,stopsel` |
| Absolute and relative line numbers | Enabled | Unchanged |

## Complete Rollback

To return to the exact pre-profile behavior:

1. Set `default_enabled = false` in `lua/config/gui_keybindings.lua`, or launch
   with `NVIM_GUI_KEYS=0 nvim`.
2. Restart Neovim.
3. Comment
   `config-file = /Users/tarik/zshFiles/symlinks/misc/ghostty_gui_keybindings`
   in `ghostty_config`.
4. Press `Cmd+Shift+,` in Ghostty to reload its configuration.

With both switches disabled, LazyVim options, mappings, Bufferline behavior,
Explorer bindings, which-key labels, and Ghostty shortcuts use their prior
defaults.
