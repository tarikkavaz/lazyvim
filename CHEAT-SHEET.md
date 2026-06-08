# LazyVim Cheat Sheet

## Table of Contents

- [Current Setup Summary](#current-setup-summary)
- [Daily Workflow](#daily-workflow)
- [Basics](#basics)
- [File Navigation](#file-navigation)
- [Moving Between File Buffer and Explorer](#moving-between-file-buffer-and-explorer)
- [Buffers and Tabs](#buffers-and-tabs)
- [Code and LSP](#code-and-lsp)
- [Formatting and Linting](#formatting-and-linting)
- [Git](#git)
- [Searching](#searching)
- [Terminal](#terminal)
- [Selection](#selection)
- [Avante / OpenAI Integration](#avante--openai-integration)
- [MCP Hub + Context7](#mcp-hub--context7)
- [Theme](#theme)
- [Useful LazyVim Commands](#useful-lazyvim-commands)
- [Enabled Extras](#enabled-extras)
- [Installed / Added Plugins](#installed--added-plugins)
- [Remaining Optional Health Warnings](#remaining-optional-health-warnings)
- [Mental Model](#mental-model)

## Current Setup Summary

```text
Neovim: 0.12.2
Base config: LazyVim
Config path: ~/.config/nvim -> ~/zshFiles/symlinks/lazyvim
Terminal: iTerm2 normally, Ghostty when you want inline image support
AI: Avante.nvim with OpenAI provider + MCP Hub (Context7 docs)
Theme: Tokyo Night (catppuccin plugin installed but disabled)
```

Your explorer is configured on the **right side** and hidden files are visible by default.

## Daily Workflow

Typical session when coding with AI:

```text
1. cd into project
2. nvim .
3. <Space> e              open explorer (right side)
4. <Space> f f            find file if needed
5. <Space> a H            open MCP Hub, start context7
6. <Space> a c            open Avante chat
7. ask question           use Ctrl+s to submit
8. gd / K / <Space> c d   LSP navigation and diagnostics as usual
9. <Space> g g            LazyGit when ready to commit
```

Quick doc lookup prompt example:

```text
Look up the latest Next.js App Router docs for the metadata API
```

## Basics

| Action | Shortcut |
|---|---|
| Open command mode | `:` |
| Save file | `:w` |
| Quit | `:q` |
| Save and quit | `:wq` |
| Force quit without saving | `:q!` |
| Normal mode | `Esc` |
| Insert mode | `i` |
| Undo | `u` |
| Redo | `Ctrl+r` |

## File Navigation

| Action | Shortcut |
|---|---|
| Find file | `<Space> f f` or dashboard `f` |
| Recent files | `<Space> f r` |
| Search in project | `<Space> /` |
| Open explorer | `<Space> e` |
| Toggle hidden files in explorer | `H` inside explorer |
| Toggle ignored files in explorer | `I` inside explorer |
| Open file from explorer | `Enter` or `l` |
| Go up folder in explorer | `Backspace` |
| Close folder in explorer | `h` |
| Add file/folder in explorer | `a` |
| Rename file/folder | `r` |
| Delete file/folder | `d` |

## Moving Between File Buffer and Explorer

Since the explorer is on the **right side**, use normal Vim window navigation.

| Action | Shortcut |
|---|---|
| Focus explorer on the right | `Ctrl+w l` |
| Focus file buffer on the left | `Ctrl+w h` |
| Focus lower window | `Ctrl+w j` |
| Focus upper window | `Ctrl+w k` |

Think of it as:

```text
Ctrl+w = window command
h/j/k/l = move left/down/up/right
```

## Buffers and Tabs

| Action | Shortcut |
|---|---|
| Next buffer | `<Shift+l>` |
| Previous buffer | `<Shift+h>` |
| Close current buffer | `<Space> b d` |
| List buffers | `<Space> b b` |

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

For your Next/TypeScript projects, confirmed active clients include:

```text
vtsls
eslint
tailwindcss
```

Other installed/ready language servers include:

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

| Action | Shortcut / Command |
|---|---|
| Format current file | `:LazyFormat` |
| Format info | `:LazyFormatInfo` |
| ESLint diagnostics | Automatic |
| Prettier formatting | Through `conform.nvim` |

Your clean setup is:

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

In LazyGit:

| Action | Shortcut |
|---|---|
| Quit LazyGit | `q` |
| Stage file | `Space` |
| Commit | `c` |
| Push | `P` |
| Pull | `p` |

On Mac, LazyGit's newer commit confirm shortcut is:

```text
Command + Enter
```

If LazyGit is running inside a Neovim terminal buffer, after pressing `q` you may also need:

```vim
:q
```

to close the terminal buffer/window.

## Searching

| Action | Shortcut |
|---|---|
| Search text in project | `<Space> /` |
| Search current word | `<Space> s w` |
| Search commands | `<Space> s c` |
| Search keymaps | `<Space> s k` |
| Search files | `<Space> f f` |

## Terminal

| Action | Shortcut |
|---|---|
| Open terminal | `<Space> f t` or `<Space> t t` |
| Exit terminal mode | `Ctrl+\` then `Ctrl+n` |

## Selection

| Action | Shortcut |
|---|---|
| Select characters | `v` |
| Select lines | `V` |
| Select block/column | `Ctrl+v` |
| Delete selection | `d` |
| Copy/yank selection | `y` |
| Paste | `p` |

Replace whole file content:

```text
gg
VG
d
i
paste new content
Esc
:w
```

## Avante / OpenAI Integration

Avante is installed for Cursor-like AI features inside Neovim.

| Action | Shortcut |
|---|---|
| Ask Avante | `<Space> a a` or `:AvanteAsk` |
| Chat with Avante | `<Space> a c` or `:AvanteChat` |
| Edit with Avante | `<Space> a e` or `:AvanteEdit` |
| Focus Avante panel | `<Space> a f` or `:AvanteFocus` |
| Avante history | `<Space> a h` or `:AvanteHistory` |
| Select model | `<Space> a m` or `:AvanteModels` |
| New chat | `<Space> a n` or `:AvanteChatNew` |
| Switch provider | `<Space> a p` or `:AvanteSwitchProvider` |
| Refresh Avante | `<Space> a r` or `:AvanteRefresh` |
| Stop Avante | `<Space> a s` or `:AvanteStop` |
| Toggle Avante panel | `<Space> a t` or `:AvanteToggle` |
| Submit question in Avante input | `Ctrl+s` |
| If terminal freezes after `Ctrl+s` | `Ctrl+q` |

Provider config lives in:

```text
~/zshFiles/symlinks/lazyvim/lua/plugins/avante.lua
```

Current provider: OpenAI (`gpt-5.5`, legacy mode).

### API Keys

Add to `~/.zshenv` (not the committed `zshFiles` repo):

```zsh
export OPENAI_API_KEY="your_key_here"
export CONTEXT7_API_KEY="ctx7sk_..."   # optional, higher Context7 rate limits
```

Safe check (prints `set` if defined, nothing if missing):

```zsh
echo ${OPENAI_API_KEY:+set}
echo ${CONTEXT7_API_KEY:+set}
```

Do **not** print the actual key in terminal output or commit it to Git.

Get a free Context7 key at: <https://context7.com/dashboard>

## MCP Hub + Context7

MCP Hub connects external tools to Avante. Context7 gives Avante up-to-date library/framework docs (React, Next.js, Prisma, etc.).

Config files:

```text
~/zshFiles/symlinks/lazyvim/lua/plugins/mcphub.lua   # plugin setup
~/zshFiles/symlinks/lazyvim/mcphub/servers.json        # MCP server list
```

### Quick Start

1. Open MCP Hub: `<Space> a H` or `:MCPHub`
2. Start the **context7** server (toggle it on in the UI)
3. Open Avante chat: `<Space> a c`
4. Ask something that needs current docs (see [Daily Workflow](#daily-workflow))

Avante calls Context7 automatically via MCP when it needs library documentation.

### MCP Hub Shortcuts

| Action | Shortcut / Command |
|---|---|
| Open MCP Hub UI | `<Space> a H` or `:MCPHub` |
| Toggle auto-approve all tools | `ga` inside MCP Hub |
| Toggle auto-approve server/tool | `a` on a server or tool line |

### Tool Approval

By default, MCP tool calls show a confirmation dialog (server name, tool name, arguments). Options:

- Press confirm in the dialog each time
- Toggle auto-approve globally with `ga` in MCP Hub
- Set `auto_approve = true` in `mcphub.lua` to skip all prompts

### Slash Commands

MCP server prompts appear as slash commands in Avante chat:

```text
/mcp:context7:...
```

Type `/` in the Avante input and pick from completions (via blink-cmp-avante).

### Adding More MCP Servers

Edit `mcphub/servers.json` or use the `:MCPHub` UI (add/install from marketplace).

Your Cursor config at `~/.cursor/mcp.json` also has servers you can copy over:

```text
context7        # already in mcphub/servers.json
chrome-devtools # browser automation
shadcn          # shadcn/ui component lookup
```

Example — add chrome-devtools to `mcphub/servers.json`:

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

Restart or reload MCP Hub after editing. Project-local configs also work via `.mcphub/servers.json` or `.cursor/mcp.json` in a repo.

### Troubleshooting MCP

| Problem | Fix |
|---|---|
| Context7 not available in chat | Open `:MCPHub`, make sure **context7** is running |
| Tool calls blocked / nothing happens | Check `disable_tools` is not set in `avante.lua` |
| Rate limit errors from Context7 | Set `CONTEXT7_API_KEY` in `~/.zshenv` |
| MCP Hub won't start | Requires Node.js 18+; run `node --version` |
| Hub binary missing after update | Run `:Lazy build mcphub.nvim` |
| General MCP Hub diagnostics | `:checkhealth mcphub` |

## Theme

Active colorscheme: **Tokyo Night** (`tokyonight-night`).

| Action | Command |
|---|---|
| Switch theme manually | `:colorscheme tokyonight-night` |
| Try Catppuccin (disabled by default) | Enable in `lua/plugins/disabled.lua`, then `:colorscheme catppuccin` |

Config files:

```text
~/zshFiles/symlinks/lazyvim/lua/plugins/tokyonight.lua   # active theme
~/zshFiles/symlinks/lazyvim/lua/plugins/catppuccin.lua     # installed, disabled
~/zshFiles/symlinks/lazyvim/lua/plugins/disabled.lua       # catppuccin disabled here
```

## Useful LazyVim Commands

| Action | Command |
|---|---|
| Plugin manager | `:Lazy` |
| LazyVim extras | `:LazyExtras` |
| Health check (all) | `:checkhealth` |
| Avante health check | `:checkhealth avante` |
| MCP Hub health check | `:checkhealth mcphub` |
| MCP Hub UI | `:MCPHub` |
| Rebuild MCP Hub binary | `:Lazy build mcphub.nvim` |
| Mason tools | `:Mason` |

Formatting commands: see [Formatting and Linting](#formatting-and-linting).

## Enabled Extras

Your setup currently includes (from `lazyvim.json`):

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

## Installed / Added Plugins

```text
LazyVim
snacks.nvim
Avante.nvim
mcphub.nvim          # MCP client, connects Context7 to Avante
conform.nvim
eslint-lsp
vtsls
tailwindcss-language-server
pyright
ruff
lazygit
tokyonight.nvim
```

## Remaining Optional Health Warnings

These are not blocking normal coding:

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
Fix Node/Python provider warnings later only if needed.
Use Ghostty for inline image support.
Install Ghostscript or Mermaid CLI later only if you need PDF/Mermaid rendering inside Neovim.
```

## Mental Model

Use LazyVim like this:

```text
<Space> = main menu
<Space> f = files
<Space> g = git
<Space> c = code
<Space> s = search
<Space> b = buffers
<Space> a = AI (Avante + MCP Hub)
```

`<Space> a` breakdown:

```text
a a = ask          a c = chat         a e = edit
a f = focus        a h = history      a m = model
a n = new chat     a p = provider     a r = refresh
a s = stop         a t = toggle       a H = MCP Hub
```

That is enough to be productive without memorizing everything.
