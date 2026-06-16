# Vim & LazyVim Cheat Sheet

A unified reference for native Vim editing and the current LazyVim setup.

- **Part I** covers portable Vim commands that work in Vim and Neovim.
- **Part II** covers LazyVim shortcuts, plugins, AI tools, and local setup details.
- `<Space>` means the leader key.
- `Ctrl-x` means hold Control and press `x`.

## Table of Contents

- [Quick Start](#quick-start)
- [Part I: Vim Essentials](#part-i-vim-essentials)
  - [Modes](#modes)
  - [Saving and Exiting](#saving-and-exiting)
  - [Movement](#movement)
  - [Search and Jumps](#search-and-jumps)
  - [Editing Text](#editing-text)
  - [Text Objects](#text-objects)
  - [Visual Selection and Indentation](#visual-selection-and-indentation)
- [Part II: LazyVim Workflow](#part-ii-lazyvim-workflow)
  - [Current Setup](#current-setup)
  - [Daily Workflow](#daily-workflow)
  - [Files, Explorer, and Windows](#files-explorer-and-windows)
  - [Buffers](#buffers)
  - [Project Search](#project-search)
  - [Code and LSP](#code-and-lsp)
  - [Formatting and Linting](#formatting-and-linting)
  - [Git](#git)
  - [Terminal](#terminal)
  - [Avante and OpenAI](#avante-and-openai)
  - [MCP Hub and Context7](#mcp-hub-and-context7)
  - [Theme](#theme)
  - [Useful LazyVim Commands](#useful-lazyvim-commands)
  - [Enabled Extras and Plugins](#enabled-extras-and-plugins)
  - [Optional Health Warnings](#optional-health-warnings)
  - [LazyVim Mental Model](#lazyvim-mental-model)

## Quick Start

### Essential Vim

| Action | Command |
|---|---|
| Normal mode | `Esc` |
| Insert before cursor | `i` |
| Insert after cursor | `a` |
| Save | `:w` |
| Quit | `:q` |
| Save and quit | `:wq` |
| Force quit without saving | `:q!` |
| Undo / redo | `u` / `Ctrl-r` |
| Copy line | `yy` |
| Delete line | `dd` |
| Paste after cursor | `p` |
| Search forward | `/pattern` |
| Repeat last change | `.` |

### Essential LazyVim

| Action | Shortcut |
|---|---|
| Find file | `<Space> f f` |
| Search project | `<Space> /` |
| Open explorer | `<Space> e` |
| Next / previous buffer | `Shift-l` / `Shift-h` |
| Go to definition | `gd` |
| Hover documentation | `K` |
| Code action | `gra` |
| Show diagnostics | `<Space> c d` |
| Open LazyGit | `<Space> g g` |
| Open Avante chat | `<Space> a c` |
| Open MCP Hub | `<Space> a H` |

# Part I: Vim Essentials

## Modes

| Command | Description |
|---|---|
| `i` | Enter Insert mode before the cursor |
| `a` | Enter Insert mode after the cursor |
| `A` | Enter Insert mode at the end of the line |
| `o` | Open a new line below and enter Insert mode |
| `O` | Open a new line above and enter Insert mode |
| `v` | Enter character-wise Visual mode |
| `V` | Enter line-wise Visual mode |
| `Ctrl-v` | Enter Visual Block mode |
| `:` | Enter Command-line mode |
| `R` | Enter Replace mode |
| `Esc` | Return to Normal mode |

## Saving and Exiting

| Command | Description |
|---|---|
| `:w` | Save the current file |
| `:wa` | Save all open files |
| `:q` | Quit; fail if there are unsaved changes |
| `:q!` | Quit and discard unsaved changes |
| `:wq` or `:x` | Save and quit |
| `:wqa` | Save all files and quit |

## Movement

### Basic Movement

| Command | Description |
|---|---|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |

Most motions accept a count. For example, `5j` moves down five lines and `3w`
moves forward three words.

### Within a Line

| Command | Description |
|---|---|
| `0` | Move to the beginning of the line |
| `^` | Move to the first non-blank character |
| `$` | Move to the end of the line |
| `fx` | Find the next `x` on the line |
| `Fx` | Find the previous `x` on the line |
| `tx` | Move just before the next `x` |
| `Tx` | Move just after the previous `x` |
| `;` | Repeat the last `f`, `F`, `t`, or `T` forward |
| `,` | Repeat the last `f`, `F`, `t`, or `T` backward |

### Words and WORDS

- A **word** is a sequence of letters, digits, or underscores, or a sequence of
  other non-blank characters. See `:h word`.
- A **WORD** is any sequence of non-blank characters. See `:h WORD`.

| Command | Description |
|---|---|
| `w` / `W` | Move to the start of the next word / WORD |
| `b` / `B` | Move to the start of the previous word / WORD |
| `e` / `E` | Move to the end of the next word / WORD |
| `ge` / `gE` | Move to the end of the previous word / WORD |

### Sentences and Paragraphs

| Command | Description |
|---|---|
| `)` | Move to the next sentence |
| `(` | Move to the previous sentence |
| `}` | Move to the next paragraph |
| `{` | Move to the previous paragraph |

A Vim paragraph is normally a block of consecutive non-empty lines. See
`:h paragraph` and `:h sentence` for exact definitions.

### Lines and Window Positions

| Command | Description |
|---|---|
| `gg` | Move to the first line |
| `G` | Move to the last line |
| `{number}G` | Move to line `{number}` |
| `{number}j` | Move down `{number}` lines |
| `{number}k` | Move up `{number}` lines |
| `H` | Move to the top visible line |
| `M` | Move to the middle visible line |
| `L` | Move to the bottom visible line |

### Delimiters and Methods

| Command | Description |
|---|---|
| `%` | Jump between matching parentheses, brackets, or braces |
| `[(` | Previous unmatched `(` |
| `[{` | Previous unmatched `{` |
| `])` | Next unmatched `)` |
| `]}` | Next unmatched `}` |
| `[m` / `]m` | Previous / next method start in supported languages |
| `[M` / `]M` | Previous / next method end in supported languages |

### Screen Movement and Scrolling

| Command | Description |
|---|---|
| `Ctrl-f` | Move forward one full screen |
| `Ctrl-b` | Move backward one full screen |
| `Ctrl-d` | Move down half a screen |
| `Ctrl-u` | Move up half a screen |
| `zz` | Center the current line |
| `zt` | Put the current line at the top |
| `zb` | Put the current line at the bottom |
| `Ctrl-e` | Scroll down one line without moving the cursor |
| `Ctrl-y` | Scroll up one line without moving the cursor |

## Search and Jumps

### Search

| Command | Description |
|---|---|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `*` | Search forward for the word under the cursor |
| `#` | Search backward for the word under the cursor |
| `n` | Repeat the search in the same direction |
| `N` | Repeat the search in the opposite direction |
| `:nohl` | Temporarily clear search highlighting |

Useful options:

```vim
:set ignorecase
:set smartcase
```

`ignorecase` makes searches case-insensitive. `smartcase` restores
case-sensitivity when the pattern contains uppercase characters.

### Jump List

Long-distance motions and file changes add entries to the jump list. Inspect it
with `:jumps`.

| Command | Description |
|---|---|
| `Ctrl-o` | Move to the previous jump position |
| `Ctrl-i` | Move to the next jump position |

Common jump-producing commands include `G`, `gg`, `{number}G`, `/`, `?`, `n`,
`N`, `%`, `(`, `)`, `{`, `}`, `H`, `M`, and `L`. Plain counted `j` and `k`
motions do not add jump-list entries.

## Editing Text

### Operator + Motion

Vim editing is built around:

```text
operator + motion
```

Examples:

```text
dw    delete to the start of the next word
de    delete to the end of the word
dG    delete to the end of the file
cw    change to the start of the next word
y}    yank to the next paragraph
```

Counts also compose with operators and motions:

```text
2dd   delete two lines
d3w   delete three words
3p    paste three times
```

### Delete

| Command | Description |
|---|---|
| `d{motion}` | Delete over a motion and copy to a register |
| `dd` | Delete the current line |
| `D` | Delete from the cursor to the end of the line |
| `x` | Delete the character under the cursor |

### Change

Change commands delete text and then enter Insert mode.

| Command | Description |
|---|---|
| `c{motion}` | Change over a motion |
| `cc` | Change the current line |
| `C` | Change from the cursor to the end of the line |
| `r{character}` | Replace the character under the cursor |
| `R` | Enter Replace mode |

### Yank and Put

| Command | Description |
|---|---|
| `y{motion}` | Yank text covered by a motion |
| `yy` | Yank the current line |
| `Y` | Yank the current line |
| `p` | Put after the cursor or below the current line |
| `P` | Put before the cursor or above the current line |

Delete, change, and `x` commands also place removed text in registers.

### Undo, Redo, and Repeat

| Command | Description |
|---|---|
| `u` | Undo the last change |
| `Ctrl-r` | Redo an undone change |
| `.` | Repeat the last change |

The dot command is one of Vim's highest-leverage commands. Make one complete
edit, move to the next target, and press `.`.

### Change Case

| Command | Description |
|---|---|
| `~` | Toggle the case of the character under the cursor |
| `~{motion}` | Toggle case over a motion |
| `gu{motion}` | Convert text to lowercase |
| `guu` | Convert the current line to lowercase |
| `gU{motion}` | Convert text to uppercase |
| `gUU` | Convert the current line to uppercase |

### Search and Replace

| Command | Description |
|---|---|
| `:%s/old/new/g` | Replace all matches in the file |
| `:%s/old/new/gc` | Replace all matches with confirmation |
| `:%s/old/new/gi` | Replace all matches, ignoring case |

## Text Objects

Text objects combine with operators such as `d`, `c`, and `y`, or with `v` for
selection.

- `i` means **inside**.
- `a` means **around**, including delimiters or surrounding whitespace.

| Object | Description |
|---|---|
| `iw` / `aw` | Inner word / a word |
| `ip` / `ap` | Inner paragraph / a paragraph |
| `i"` / `a"` | Inside / around double quotes |
| `i'` / `a'` | Inside / around single quotes |
| `i(` / `a(` | Inside / around parentheses |
| `i[` / `a[` | Inside / around brackets |
| `i{` / `a{` | Inside / around braces |
| `i<` / `a<` | Inside / around angle brackets |
| `it` / `at` | Inside / around an HTML or XML tag |

Examples:

| Command | Description |
|---|---|
| `diw` | Delete the word under the cursor |
| `daw` | Delete the word and surrounding whitespace |
| `ci"` | Change text inside double quotes |
| `da(` | Delete parenthesized text and its parentheses |
| `yit` | Yank text inside an HTML or XML tag |
| `vip` | Select the current paragraph |

## Visual Selection and Indentation

### Selection

| Command | Description |
|---|---|
| `v` | Select characters |
| `V` | Select lines |
| `Ctrl-v` | Select a rectangular block |
| `d` | Delete the selection |
| `y` | Yank the selection |
| `c` | Change the selection |
| `>` | Indent the selection |
| `<` | Unindent the selection |

### Normal-mode Indentation

| Command | Description |
|---|---|
| `>{motion}` | Indent over a motion |
| `<{motion}` | Unindent over a motion |
| `>>` | Indent the current line |
| `<<` | Unindent the current line |
| `2>>` | Indent the current and following line |

### Replace an Entire File

```text
gg
VG
d
i
paste new content
Esc
:w
```

# Part II: LazyVim Workflow

## Current Setup

```text
Neovim: 0.12.2
Base config: LazyVim
Config path: ~/.config/nvim
Terminal: iTerm2 normally, Ghostty for inline image support
AI: Avante.nvim with OpenAI provider + MCP Hub (Context7 docs)
Theme: Tokyo Night (Catppuccin installed but disabled)
```

The explorer is configured on the **right side**, with hidden files visible by
default.

## Daily Workflow

Typical coding session:

```text
1. cd into project
2. nvim .
3. <Space> e              open explorer
4. <Space> f f            find a file
5. <Space> a H            open MCP Hub and start Context7
6. <Space> a c            open Avante chat
7. ask question           use Ctrl-s to submit
8. gd / K / <Space> c d   navigate code and diagnostics
9. <Space> g g            open LazyGit
```

Example documentation prompt:

```text
Look up the latest Next.js App Router docs for the metadata API
```

## Files, Explorer, and Windows

### File Navigation

| Action | Shortcut |
|---|---|
| Find file | `<Space> f f` or dashboard `f` |
| Recent files | `<Space> f r` |
| Search project | `<Space> /` |
| Open explorer | `<Space> e` |
| Toggle hidden files | `H` inside explorer |
| Toggle ignored files | `I` inside explorer |
| Open file | `Enter` or `l` inside explorer |
| Go up a folder | `Backspace` inside explorer |
| Close folder | `h` inside explorer |
| Add file or folder | `a` inside explorer |
| Rename file or folder | `r` inside explorer |
| Delete file or folder | `d` inside explorer |

### Window Navigation

Because the explorer is on the right, use standard Vim window navigation:

| Action | Shortcut |
|---|---|
| Focus explorer on the right | `Ctrl-w l` |
| Focus file buffer on the left | `Ctrl-w h` |
| Focus lower window | `Ctrl-w j` |
| Focus upper window | `Ctrl-w k` |

Mental model:

```text
Ctrl-w = window command
h/j/k/l = move left/down/up/right
```

## Buffers

| Action | Shortcut |
|---|---|
| Next buffer | `Shift-l` |
| Previous buffer | `Shift-h` |
| Close current buffer | `<Space> b d` |
| List buffers | `<Space> b b` |

## Project Search

| Action | Shortcut |
|---|---|
| Search text in project | `<Space> /` |
| Search current word | `<Space> s w` |
| Search commands | `<Space> s c` |
| Search keymaps | `<Space> s k` |
| Search files | `<Space> f f` |

Native Vim search commands such as `/`, `?`, `*`, `#`, `n`, and `N` remain
available inside the current buffer.

## Code and LSP

| Action | Shortcut |
|---|---|
| LSP info | `<Space> c l` |
| Go to definition | `gd` |
| Go to references | `grr` |
| Rename symbol | `grn` |
| Code action | `gra` |
| Hover documentation | `K` |
| Show diagnostics | `<Space> c d` |
| Next diagnostic | `]d` |
| Previous diagnostic | `[d` |

Confirmed active clients for Next.js and TypeScript projects:

```text
vtsls
eslint
tailwindcss
```

Other installed or available language servers:

```text
jsonls
yamlls
dockerls
docker_compose_language_service
pyright
ruff
prismals
vue_ls
rust_analyzer
```

## Formatting and Linting

| Action | Shortcut or Command |
|---|---|
| Format current file | `:LazyFormat` |
| Show formatting info | `:LazyFormatInfo` |
| ESLint diagnostics | Automatic |
| Prettier formatting | Through `conform.nvim` |

Current responsibility split:

```text
Prettier -> conform.nvim
ESLint -> eslint-lsp
```

## Git

| Action | Shortcut |
|---|---|
| Open LazyGit | `<Space> g g` |
| Git status picker | `<Space> g s` |
| Git commits | `<Space> g c` |
| Git branches | `<Space> g b` |

Inside LazyGit:

| Action | Shortcut |
|---|---|
| Quit | `q` |
| Stage file | `Space` |
| Commit | `c` |
| Push | `P` |
| Pull | `p` |
| Confirm commit on macOS | `Command-Enter` |

If LazyGit is running in a Neovim terminal buffer, pressing `q` may leave the
terminal window open. Use `:q` to close that buffer or window.

## Terminal

| Action | Shortcut |
|---|---|
| Open terminal | `<Space> f t` or `<Space> t t` |
| Exit terminal mode | `Ctrl-\`, then `Ctrl-n` |

## Avante and OpenAI

Avante provides Cursor-like AI features inside Neovim.

| Action | Shortcut or Command |
|---|---|
| Ask Avante | `<Space> a a` or `:AvanteAsk` |
| Open chat | `<Space> a c` or `:AvanteChat` |
| Edit with Avante | `<Space> a e` or `:AvanteEdit` |
| Focus Avante panel | `<Space> a f` or `:AvanteFocus` |
| Open history | `<Space> a h` or `:AvanteHistory` |
| Select model | `<Space> a m` or `:AvanteModels` |
| Start new chat | `<Space> a n` or `:AvanteChatNew` |
| Switch provider | `<Space> a p` or `:AvanteSwitchProvider` |
| Refresh Avante | `<Space> a r` or `:AvanteRefresh` |
| Stop Avante | `<Space> a s` or `:AvanteStop` |
| Toggle Avante panel | `<Space> a t` or `:AvanteToggle` |
| Submit input | `Ctrl-s` |
| Unfreeze terminal after `Ctrl-s` | `Ctrl-q` |

Provider configuration:

```text
~/<your-dotfiles>/lazyvim/lua/plugins/avante.lua
```

Documented provider: OpenAI (`gpt-5.5`, legacy mode).

### API Keys

Add keys to `~/.zshenv`, not to any committed dotfiles/config repository:

```zsh
export OPENAI_API_KEY="your_key_here"
export CONTEXT7_API_KEY="ctx7sk_..."   # optional, higher Context7 rate limits
```

Safe checks that do not print the key:

```zsh
echo ${OPENAI_API_KEY:+set}
echo ${CONTEXT7_API_KEY:+set}
```

Do not print actual keys in terminal output or commit them to Git.

Context7 dashboard: <https://context7.com/dashboard>

## MCP Hub and Context7

MCP Hub connects external tools to Avante. Context7 supplies current library and
framework documentation for tools such as React, Next.js, and Prisma.

Configuration files:

```text
~/<your-dotfiles>/lazyvim/lua/plugins/mcphub.lua
~/<your-dotfiles>/lazyvim/mcphub/servers.json
```

### Quick Start

1. Open MCP Hub with `<Space> a H` or `:MCPHub`.
2. Start the `context7` server in the UI.
3. Open Avante chat with `<Space> a c`.
4. Ask a question that needs current library documentation.

Avante can call Context7 through MCP when documentation is needed.

### MCP Hub Shortcuts

| Action | Shortcut or Command |
|---|---|
| Open MCP Hub | `<Space> a H` or `:MCPHub` |
| Toggle auto-approve for all tools | `ga` inside MCP Hub |
| Toggle auto-approve for one server or tool | `a` on its line |

By default, MCP tool calls display a confirmation dialog with the server, tool,
and arguments. Auto-approval can also be enabled with `auto_approve = true` in
`mcphub.lua`.

### Slash Commands

MCP server prompts appear in Avante as slash commands:

```text
/mcp:context7:...
```

Type `/` in Avante input and select from completions.

### Adding MCP Servers

Edit `mcphub/servers.json` or use the `:MCPHub` marketplace UI.

Servers that may be copied from `~/.cursor/mcp.json`:

```text
context7
chrome-devtools
shadcn
```

Example:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--headless"]
    }
  }
}
```

Restart or reload MCP Hub after editing. Project-local configurations can live
in `.mcphub/servers.json` or `.cursor/mcp.json`.

### Troubleshooting MCP

| Problem | Fix |
|---|---|
| Context7 unavailable in chat | Open `:MCPHub` and confirm `context7` is running |
| Tool calls blocked | Confirm `disable_tools` is not set in `avante.lua` |
| Context7 rate limit | Set `CONTEXT7_API_KEY` in `~/.zshenv` |
| MCP Hub will not start | Confirm Node.js 18+ with `node --version` |
| Hub binary missing after update | Run `:Lazy build mcphub.nvim` |
| General diagnostics | Run `:checkhealth mcphub` |

## Theme

Active colorscheme: **Tokyo Night** (`tokyonight-night`).

| Action | Command |
|---|---|
| Switch to Tokyo Night | `:colorscheme tokyonight-night` |
| Try Catppuccin | Enable it in `lua/plugins/disabled.lua`, then run `:colorscheme catppuccin` |

Configuration files:

```text
~/<your-dotfiles>/lazyvim/lua/plugins/tokyonight.lua
~/<your-dotfiles>/lazyvim/lua/plugins/catppuccin.lua
~/<your-dotfiles>/lazyvim/lua/plugins/disabled.lua
```

## Useful LazyVim Commands

| Action | Command |
|---|---|
| Plugin manager | `:Lazy` |
| LazyVim extras | `:LazyExtras` |
| Full health check | `:checkhealth` |
| Avante health check | `:checkhealth avante` |
| MCP Hub health check | `:checkhealth mcphub` |
| MCP Hub UI | `:MCPHub` |
| Rebuild MCP Hub binary | `:Lazy build mcphub.nvim` |
| Mason tools | `:Mason` |

## Enabled Extras and Plugins

Enabled extras from `lazyvim.json`:

```text
ai.avante
formatting.black
formatting.prettier
lang.docker
lang.json
lang.markdown
lang.prisma
lang.python
lang.rust
lang.sql
lang.tailwind
lang.typescript
lang.vue
lang.yaml
linting.eslint
lsp.neoconf
```

Installed or added plugins and tools:

```text
LazyVim
snacks.nvim
Avante.nvim
mcphub.nvim
conform.nvim
eslint-lsp
vtsls
tailwindcss-language-server
pyright
ruff
lazygit
tokyonight.nvim
```

## Optional Health Warnings

These warnings do not block normal coding:

```text
Node provider warning
Python provider warning
Ruby provider warning
Perl provider warning
luarocks Lua 5.1 warning
Snacks.image document rendering warnings in iTerm2
```

Recommended approach:

```text
Ignore Ruby and Perl provider warnings.
Fix Node and Python provider warnings only when needed.
Use Ghostty for inline image support.
Install Ghostscript or Mermaid CLI only if PDF or Mermaid rendering is needed.
```

## LazyVim Mental Model

```text
<Space> = main menu
<Space> f = files
<Space> g = git
<Space> c = code
<Space> s = search
<Space> b = buffers
<Space> a = AI
```

Avante and MCP Hub:

```text
a a = ask          a c = chat         a e = edit
a f = focus        a h = history      a m = model
a n = new chat     a p = provider     a r = refresh
a s = stop         a t = toggle       a H = MCP Hub
```

The practical workflow is:

```text
Use Vim motions and operators for editing.
Use <Space> menus for project-level LazyVim actions.
Use LSP commands for code intelligence.
Use Avante and Context7 when AI or current documentation is useful.
```
