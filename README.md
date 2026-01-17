# Neovim Configuration

A modern, opinionated Neovim configuration optimized for software development with support for 40+ languages, debugging, testing, and Git workflows.

## Table of Contents

- [Installation](#installation)
- [Core Concepts](#core-concepts)
- [Plugin Overview](#plugin-overview)
- [Keybindings Reference](#keybindings-reference)
- [LSP & Language Support](#lsp--language-support)
- [Workflows](#workflows)
- [Customization](#customization)

---

## Installation

1. Clone this repository to your Neovim config directory:
   ```bash
   git clone <repo-url> ~/.config/nvim
   ```

2. Open Neovim - lazy.nvim will automatically bootstrap and install plugins

3. Run `:MasonInstallAll` to install all configured language servers, formatters, and linters

### Dependencies

- **Neovim** >= 0.11.0
- **ripgrep** - for Telescope live grep
- **fd** - for Telescope file finding
- **Node.js** - for various LSP servers
- **lazygit** - for Git integration (optional)
- **lazydocker** - for Docker management (optional)

---

## Core Concepts

### Leader Key

The leader key is `<Space>`. Most custom keybindings start with the leader key.

### Plugin Manager

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. Plugins are lazy-loaded for fast startup.

- Open lazy.nvim UI: `:Lazy`
- Update plugins: `:Lazy update`
- Sync plugins: `:Lazy sync`

### Which-Key

Press `<Space>` and wait to see available keybindings. The which-key popup uses a Helix-inspired preset for organization.

---

## Plugin Overview

### Navigation & File Management

| Plugin | Purpose | Key Trigger |
|--------|---------|-------------|
| **oil.nvim** | File manager with buffer-like editing | `<leader>e` |
| **telescope.nvim** | Fuzzy finder for files, text, symbols | `<leader>f*` |
| **harpoon** | Quick file bookmarking | `<leader>a`, `<leader>o`, `<leader>1-4` |
| **flash.nvim** | Label-based motion | `s`, `S` |
| **vim-tmux-navigator** | Seamless tmux/vim pane navigation | `<C-h/j/k/l>` |

### Editor Enhancement

| Plugin | Purpose | Key Trigger |
|--------|---------|-------------|
| **Comment.nvim** | Toggle comments | `gcc` (line), `gc` (visual) |
| **nvim-autopairs** | Auto-close brackets and quotes | Automatic |
| **indent-blankline** | Visual indentation guides | Automatic |
| **undotree** | Visual undo history | `<leader>u` |
| **persistence.nvim** | Session management | `<leader>q*` |

### Development Tools

| Plugin | Purpose | Key Trigger |
|--------|---------|-------------|
| **nvim-lspconfig** | Language server configuration | `g*` keys |
| **blink.cmp** | Completion engine | Automatic |
| **conform.nvim** | Code formatting | `<leader>rf`, auto on save |
| **nvim-treesitter** | Syntax highlighting & parsing | Automatic |
| **trouble.nvim** | Diagnostics viewer | `<leader>x*` |

### Debugging & Testing

| Plugin | Purpose | Key Trigger |
|--------|---------|-------------|
| **nvim-dap** | Debug Adapter Protocol | `<leader>d*` |
| **neotest** | Test runner framework | `<leader>T*` |

### Git

| Plugin | Purpose | Key Trigger |
|--------|---------|-------------|
| **gitsigns.nvim** | Git signs, blame, hunks | `<leader>g*` |
| **lazygit** (via snacks) | Full Git UI | `<leader>tg` |

### UI

| Plugin | Purpose |
|--------|---------|
| **nightfox.nvim** | Nordfox colorscheme (dark, customized) |
| **lualine.nvim** | Status line |
| **bufferline.nvim** | Buffer tabs |
| **snacks.nvim** | Dashboard, notifications, zen mode |

---

## Keybindings Reference

### File & Buffer Operations

| Keybinding | Action |
|------------|--------|
| `<leader>w` | Save file |
| `<leader>qq` | Quit Neovim |
| `<leader>c` | Close current buffer |
| `<leader>bn` / `<leader>bp` | Next / previous buffer |
| `L` / `H` | Cycle buffers right / left |
| `>b` / `<b` | Move buffer right / left |
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>pa` | Copy full file path to clipboard |
| `<leader>fx` | Make current file executable |
| `<leader>rc` | Edit Neovim config |
| `<leader>?` | Show buffer-local keymaps |

### Search & Find (Telescope)

| Keybinding | Action |
|------------|--------|
| `<leader>ff` | Find files |
| `<leader>fF` | Find files (including hidden) |
| `<leader>fw` | Live grep (search text in project) |
| `<leader>fW` | Live grep (including hidden files) |
| `<leader>fb` | Search in current buffer |
| `<leader>fB` | Find open buffers |
| `<leader>fk` | Search keymaps |
| `<leader>fH` | Search help tags |
| `<leader>fc` | Find commands |
| `<leader>fq` | Search quickfix list |
| `<leader>fl` | Search location list |
| `<leader>fj` | Search jumplist |
| `<leader>fm` | Search marks |
| `<leader>fs` | Find document symbols |
| `<leader>fS` | Find workspace symbols |
| `<leader>fgc` | Search Git commits |
| `<leader>fgs` | Git status |
| `<leader>ft` | Find TODO comments |

Inside Telescope:
- `<C-t>` - Open in Trouble
- `<C-T>` - Add to Trouble

### Motion & Navigation

| Keybinding | Action |
|------------|--------|
| `s` | Flash jump (type characters, then label) |
| `S` | Flash treesitter (select syntax node) |
| `r` | Flash remote (operator pending) |
| `R` | Flash treesitter search |
| `<C-s>` | Toggle Flash in search mode |
| `<C-h/j/k/l>` | Navigate windows (tmux-aware) |
| `<C-d>` / `<C-u>` | Half-page down / up (centered) |
| `n` / `N` | Next / previous search result (centered) |
| `]]` / `[[` | Next / previous word reference |
| `]t` / `[t` | Next / previous TODO comment |
| `]d` / `[d` | Next / previous diagnostic |
| `<A-j>` / `<A-k>` | Move line down / up |
| `J` | Join lines (cursor stays in place) |

### Harpoon (Quick File Navigation)

| Keybinding | Action |
|------------|--------|
| `<leader>a` | Add current file to Harpoon |
| `<leader>o` | Open Harpoon menu |
| `<leader>1` | Jump to Harpoon file 1 |
| `<leader>2` | Jump to Harpoon file 2 |
| `<leader>3` | Jump to Harpoon file 3 |
| `<leader>4` | Jump to Harpoon file 4 |

### LSP

| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `gt` | Go to type definition |
| `gI` | Show incoming calls |
| `gO` | Show outgoing calls |
| `K` | Hover documentation |
| `<leader>ls` | Signature help |
| `<leader>la` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>rf` | Format buffer |
| `<leader>lwa` | Add workspace folder |
| `<leader>lwr` | Remove workspace folder |
| `<leader>lwl` | List workspace folders |

### Diagnostics & Trouble

| Keybinding | Action |
|------------|--------|
| `<leader>xx` | Workspace diagnostics (Trouble) |
| `<leader>xd` | Buffer diagnostics (Trouble) |
| `<leader>xl` | Location list (Trouble) |
| `<leader>xq` | Quickfix list (Trouble) |
| `<leader>xr` | LSP references (Trouble) |
| `<leader>xs` | Symbols (Trouble) |
| `<leader>xt` | TODO comments (Trouble) |
| `]x` / `[x` | Next / previous Trouble item |

### Debugging (DAP)

| Keybinding | Action |
|------------|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dc` | Continue / start debugging |
| `<leader>dC` | Run to cursor |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last debug config |
| `<leader>dt` | Terminate debug session |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression under cursor |

### Testing (Neotest)

| Keybinding | Action |
|------------|--------|
| `<leader>Tt` | Run nearest test |
| `<leader>Tf` | Run tests in current file |
| `<leader>Ta` | Run all tests |
| `<leader>Ts` | Toggle test summary |
| `<leader>To` | Show test output |
| `<leader>TO` | Toggle output panel |
| `<leader>TS` | Stop running tests |
| `<leader>Tw` | Toggle test watch mode |

### Git

| Keybinding | Action |
|------------|--------|
| `<leader>tg` | Open lazygit |
| `<leader>gf` | Lazygit current file history |
| `<leader>gb` | Git blame current line |
| `<leader>gD` | Show deleted lines |
| `<leader>gn` | Next hunk |
| `<leader>gp` | Previous hunk |
| `ih` | Select hunk (visual/operator) |

### Search & Replace (Spectre)

| Keybinding | Action |
|------------|--------|
| `<leader>sr` | Open Spectre (search & replace) |
| `<leader>sw` | Search current word |
| `<leader>sp` | Search in current file |

### Session Management

| Keybinding | Action |
|------------|--------|
| `<leader>qs` | Restore session for current directory |
| `<leader>qS` | Select session to restore |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session |

### Editor Features

| Keybinding | Action |
|------------|--------|
| `<leader>z` | Toggle zen mode |
| `<leader>Z` | Toggle zoom (maximize window) |
| `<leader>n` | Open scratch buffer |
| `<leader>h` | Show notification history |
| `<leader>un` | Dismiss all notifications |
| `<leader>ud` | Toggle dim mode |
| `<leader>u` | Toggle undotree |
| `<leader>;` | Append semicolon to line end |
| `<leader>,` | Append comma to line end |
| `jk` | Exit insert mode |
| `<Esc>` | Clear search highlights |

### Terminal

| Keybinding | Action |
|------------|--------|
| `<C-p>` | Toggle terminal |
| `<leader>td` | Toggle lazydocker |
| `<leader>tg` | Toggle lazygit |

### Visual Mode

| Keybinding | Action |
|------------|--------|
| `<` / `>` | Indent left / right (stay in visual) |
| `=` | Auto-indent (stay in visual) |
| `<A-j>` / `<A-k>` | Move selection down / up |
| `<leader>d` | Delete without yanking |
| `gc` | Comment selection |

### Window Resize

| Keybinding | Action |
|------------|--------|
| `<C-Up>` | Increase height |
| `<C-Down>` | Decrease height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

---

## LSP & Language Support

### Configured Language Servers

| Language | Server | Features |
|----------|--------|----------|
| Lua | lua_ls | Vim runtime, lazy.nvim libraries |
| Python | basedpyright, ruff | Type checking, linting |
| Rust | rust_analyzer | Clippy integration |
| TypeScript/JavaScript | ts_ls, eslint | Full TS support, linting |
| CSS/Tailwind | cssls, tailwindcss | CVA class regex support |
| HTML | html | Standard support |
| JSON | jsonls | Schema support |
| Markdown | marksman | Link completion |
| Bash | bashls | Standard support |
| Docker | dockerls, docker_compose | Dockerfile + compose |
| Svelte | svelte | Full support |
| GraphQL | graphql | Schema support |
| Cucumber | cucumber_language_server | Feature files |
| Typst | tinymist | Document support |

### Formatters (via conform.nvim)

| Language | Formatter |
|----------|-----------|
| Lua | stylua |
| Python | black, isort |
| JS/TS/CSS/HTML/JSON/YAML/MD | prettierd |
| Svelte | prettierd |
| GraphQL | prettierd |
| Rust | rustfmt |

Format-on-save is enabled by default. Disable with:
- `:FormatDisable` - Disable for current buffer
- `:FormatDisable!` - Disable globally
- `:FormatEnable` - Re-enable

### Treesitter Parsers

40+ language parsers are auto-installed including: bash, c, cpp, css, dockerfile, go, graphql, html, java, javascript, json, lua, markdown, python, rust, sql, svelte, typescript, yaml, and more.

---

## Workflows

### Quick File Navigation with Harpoon

Harpoon lets you bookmark frequently-used files. Four have quick-access keys, but the menu can hold more:

1. Open a file you use often
2. Press `<leader>a` to add it to Harpoon
3. Access it instantly with `<leader>1` through `<leader>4`
4. View/reorder with `<leader>o`

### Debugging a Rust/C/C++ Program

1. Set breakpoints with `<leader>db`
2. Start debugging with `<leader>dc`
3. Step through code with `<leader>di` (into), `<leader>do` (over), `<leader>dO` (out)
4. Inspect variables in the DAP UI (auto-opens)
5. Evaluate expressions with `<leader>de`
6. Terminate with `<leader>dt`

### Running Tests

1. Position cursor on a test
2. Run it with `<leader>Tt`
3. View results with `<leader>To`
4. For continuous testing, enable watch mode with `<leader>Tw`

### Project-Wide Search & Replace

1. Press `<leader>sr` to open Spectre
2. Type your search pattern
3. Type replacement text
4. Preview changes and confirm
5. Or use `<leader>sw` to search the word under cursor

### Git Workflow

1. View changes: `<leader>fgs` (Git status via Telescope)
2. Navigate hunks: `<leader>gn` / `<leader>gp`
3. Full Git UI: `<leader>tg` (lazygit)
4. Blame current line: `<leader>gb`
5. File history: `<leader>gf`

### Session Management

Sessions are auto-saved. To restore:
- `<leader>qs` - Restore session for current directory
- `<leader>ql` - Restore last session
- `<leader>qS` - Select from saved sessions

### Focus Mode

- `<leader>z` - Zen mode (minimal distractions)
- `<leader>Z` - Zoom current window (maximize)

---

## Customization

### Colorscheme

The configuration uses Nordfox (from nightfox.nvim) with a customized darker background:
- Main background: `#141414`
- Secondary background: `#1f1f1f`

To change the colorscheme, modify the nightfox.nvim configuration in `init.lua`.

### Adding Language Servers

1. Add the server name to the Mason ensure_installed list
2. Add server configuration in the lspconfig setup section
3. Restart Neovim and run `:MasonInstallAll`

### Adding Formatters

1. Install via Mason or ensure it's in your PATH
2. Add the formatter to the conform.nvim formatters_by_ft table
3. Restart Neovim

### Custom Keybindings

Add keybindings in the keymaps section of `init.lua`:

```lua
vim.keymap.set("n", "<leader>xx", function()
  -- your function
end, { desc = "Description" })
```

---

## Useful Neovim Features

### Registers

| Register | Purpose |
|----------|---------|
| `"` | Default register (last yank/delete) |
| `0` | Last yank only |
| `+` | System clipboard |
| `_` | Black hole (delete without saving) |
| `/` | Last search pattern |
| `:` | Last command |
| `.` | Last inserted text |

Access with `"<register>` before operation: `"+y` yanks to system clipboard.

**Note:** This config syncs the default register with the system clipboard. Yanking automatically copies to your system clipboard.

### Marks

| Mark | Purpose |
|------|---------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark (across files) |
| `'{mark}` | Jump to mark line |
| `` `{mark} `` | Jump to mark position |
| `:marks` | List all marks |

Special marks:
- `` `. `` - Position of last change
- `` `" `` - Position when last exiting buffer
- `` `[ `` and `` `] `` - Start/end of last change or yank

### Macros

1. `q{register}` - Start recording
2. Perform actions
3. `q` - Stop recording
4. `@{register}` - Play macro
5. `@@` - Repeat last macro
6. `10@{register}` - Play macro 10 times

### Text Objects

Operate on semantic chunks with `{operator}{a|i}{object}`:

| Object | Inner (i) | Around (a) |
|--------|-----------|------------|
| `w` | word | word + space |
| `s` | sentence | sentence + space |
| `p` | paragraph | paragraph + blank |
| `"`, `'`, `` ` `` | quoted content | quotes included |
| `(`, `)`, `b` | parentheses content | parens included |
| `[`, `]` | bracket content | brackets included |
| `{`, `}`, `B` | brace content | braces included |
| `<`, `>` | angle bracket content | angles included |
| `t` | tag content | tags included |

Examples:
- `ciw` - Change inner word
- `da"` - Delete around quotes
- `yi(` - Yank inner parentheses
- `vat` - Select around HTML tag

### Command-Line Mode

| Command | Action |
|---------|--------|
| `:!{cmd}` | Run shell command |
| `:r !{cmd}` | Insert command output |
| `:%!{cmd}` | Filter buffer through command |
| `:norm {keys}` | Execute normal mode keys |
| `:'<,'>norm {keys}` | Execute on visual selection |
| `:g/{pattern}/{cmd}` | Run cmd on matching lines |
| `:v/{pattern}/{cmd}` | Run cmd on non-matching lines |

### Substitution

```vim
:[range]s/{pattern}/{replacement}/[flags]
```

| Flag | Meaning |
|------|---------|
| `g` | All occurrences on line |
| `c` | Confirm each |
| `i` | Case insensitive |
| `I` | Case sensitive |
| `n` | Count only, don't replace |

Special replacements:
- `\0` or `&` - Entire match
- `\1` - `\9` - Capture groups
- `\u`, `\l` - Uppercase/lowercase next char
- `\U`, `\L` - Uppercase/lowercase until `\e`

### Useful Ex Commands

| Command | Action |
|---------|--------|
| `:earlier 5m` | Undo to 5 minutes ago |
| `:later 5m` | Redo to 5 minutes later |
| `:changes` | List change history |
| `:jumps` | List jump history |
| `:registers` | Show register contents |
| `:set spell` | Enable spell check |
| `:set spelllang=en_us` | Set spell language |
| `z=` | Suggest spelling corrections |
| `:sort` | Sort lines |
| `:sort u` | Sort and remove duplicates |
| `:sort n` | Sort numerically |

### Window Commands

| Command | Action |
|---------|--------|
| `<C-w>o` | Close all other windows |
| `<C-w>=` | Equalize window sizes |
| `<C-w>_` | Maximize height |
| `<C-w>|` | Maximize width |
| `<C-w>r` | Rotate windows |
| `<C-w>x` | Exchange with next window |
| `<C-w>T` | Move window to new tab |

### Folding

Folding uses Treesitter for language-aware code folding. Files open with all folds expanded.

| Command | Action |
|---------|--------|
| `za` | Toggle fold |
| `zA` | Toggle all folds recursively |
| `zo` | Open fold |
| `zc` | Close fold |
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zj` / `zk` | Next / previous fold |

---

## Practical Examples

### Filtering Through External Commands

Pipe buffer contents or selections through shell commands with `!`:

```vim
" Sort entire file
:%!sort

" Sort and remove duplicates
:%!sort -u

" Sort selected lines (visual mode, then type :)
:'<,'>!sort

" Reverse line order
:%!tac

" Sort by second column
:%!sort -k2

" Numeric sort by third column, reverse
:%!sort -k3 -n -r
```

### JSON Manipulation with jq

```vim
" Pretty-print entire JSON file
:%!jq .

" Pretty-print with sorted keys
:%!jq -S .

" Extract specific field from JSON array
:%!jq '.[].name'

" Filter JSON array
:%!jq '[.[] | select(.status == "active")]'

" Compact JSON (minify)
:%!jq -c .

" Pretty-print selected JSON object (visual select, then :)
:'<,'>!jq .
```

### Text Transformation

```vim
" Convert to uppercase
:%!tr '[:lower:]' '[:upper:]'

" Remove duplicate lines (preserving order)
:%!awk '!seen[$0]++'

" Number all lines
:%!nl -ba

" Remove blank lines
:g/^$/d

" Remove lines matching pattern
:g/DEBUG/d

" Keep only lines matching pattern
:v/ERROR/d

" Double-space file
:g/^/put _

" Reverse all lines
:g/^/m0
```

### Column Operations with awk/cut

```vim
" Extract second column (space-delimited)
:%!awk '{print $2}'

" Swap first two columns
:%!awk '{print $2, $1}'

" Sum numbers in first column
:%!awk '{sum+=$1} END {print sum}'

" Extract columns 1 and 3 (comma-delimited)
:%!cut -d',' -f1,3

" Add line numbers as first column
:%!awk '{print NR, $0}'

" Filter rows where column 2 > 100
:%!awk '$2 > 100'
```

### Working with CSV/TSV

```vim
" CSV to TSV
:%!sed 's/,/\t/g'

" Sort CSV by second column
:%!sort -t',' -k2

" Extract unique values from column 1
:%!cut -d',' -f1 | sort -u

" Pretty-print CSV as table (requires column)
:%!column -t -s','

" Convert CSV to JSON (requires miller)
:%!mlr --c2j cat
```

### Code Formatting

```vim
" Format XML (requires xmllint)
:%!xmllint --format -

" Format SQL (requires sqlformat from sqlparse)
:%!sqlformat -r -k upper -

" Format HTML (requires tidy)
:%!tidy -i -q --show-errors 0

" Decode base64
:%!base64 -d

" Encode as base64
:%!base64

" URL decode
:%!python3 -c "import sys,urllib.parse;print(urllib.parse.unquote(sys.stdin.read()))"

" Decode JWT payload (middle section)
:%!cut -d. -f2 | base64 -d 2>/dev/null | jq .
```

### Practical Multi-Step Examples

**Extract and sort unique error types from logs:**
```vim
:%!grep ERROR | awk '{print $4}' | sort -u
```

**Convert markdown list to numbered:**
```vim
:'<,'>!awk '{print NR". "substr($0,3)}'
```

**Generate UUID and insert:**
```vim
:r !uuidgen
```

**Insert current date:**
```vim
:r !date +\%Y-\%m-\%d
```

**Insert current timestamp:**
```vim
:r !date -Iseconds
```

**Calculate math expression (select expression, then filter):**
```vim
:'<,'>!bc -l
```

**Wrap lines at 80 characters:**
```vim
:%!fold -w 80 -s
```

**Remove trailing whitespace:**
```vim
:%s/\s\+$//e
```

**Convert spaces to tabs:**
```vim
:%!unexpand -t 4
```

**Convert tabs to spaces:**
```vim
:%!expand -t 4
```

### Advanced Patterns

**Run current line as shell command, replace with output:**
```vim
:.!sh
```

**Execute visual selection as shell script:**
```vim
:'<,'>!sh
```

**Diff two sections within same file:**
1. Yank first section to register a: `"ay`
2. Write register to temp: `:call writefile(split(@a, '\n'), '/tmp/a')`
3. Yank second section to register b: `"by`
4. Compare: `:!diff /tmp/a <(echo '<C-r>b')` or open in diff mode

**Align on equals signs (requires column):**
```vim
:'<,'>!column -t -s'=' -o' = '
```

**Generate sequence of numbers:**
```vim
:r !seq 1 10
```

**Insert Lorem Ipsum (requires lorem):**
```vim
:r !lorem -p 3
```

**Encrypt/decrypt with GPG:**
```vim
" Encrypt buffer
:%!gpg -c --armor

" Decrypt buffer
:%!gpg -d
```

**Query database and insert results:**
```vim
:r !psql -c "SELECT * FROM users LIMIT 5" -h localhost mydb
```

**Curl and insert response:**
```vim
:r !curl -s https://api.example.com/data | jq .
```

### Expression Register

Insert calculated values in insert mode with `<C-r>=`:

```
<C-r>=system('date')       " Insert date
<C-r>=line('.')            " Insert current line number
<C-r>=expand('%:t')        " Insert current filename
<C-r>=expand('%:p')        " Insert full file path
<C-r>=strftime('%Y-%m-%d') " Insert formatted date
<C-r>=33*3                 " Insert calculation result
```

### Useful g and v Command Patterns

```vim
" Delete all lines containing 'debug'
:g/debug/d

" Delete all blank lines
:g/^$/d

" Delete all lines NOT containing 'keep'
:v/keep/d

" Copy all lines containing 'TODO' to end of file
:g/TODO/t$

" Move all lines containing 'import' to top
:g/import/m0

" Execute macro @a on all matching lines
:g/pattern/normal @a

" Indent all lines in functions
:g/^func/+1,/^}/-1>

" Add semicolon to lines ending with letter/number
:g/[a-zA-Z0-9]$/s/$/;/

" Surround all lines containing 'test' with quotes
:g/test/s/.*/"&"/

" Number lines matching pattern
:let i=1 | g/TODO/s/^/\=i.'. '/ | let i+=1
```

---

## Quick Reference Card

```
NAVIGATION                          EDITING
<C-h/j/k/l>  Window navigation      gcc        Toggle line comment
s            Flash jump             gc{motion} Comment motion
<C-d>/<C-u>  Half-page scroll       <leader>rf Format buffer
gd           Go to definition       <leader>rn Rename symbol
gr           Go to references       <leader>la Code action
<leader>ff   Find files             <leader>;  Append semicolon
<leader>fw   Live grep              <leader>d  Delete (no yank)

FILES                               DEBUGGING
<leader>e    File explorer          <leader>db Toggle breakpoint
<leader>a    Harpoon add            <leader>dc Continue/start
<leader>1-4  Harpoon jump           <leader>di Step into
<leader>c    Close buffer           <leader>do Step over
L/H          Cycle buffers          <leader>dt Terminate

GIT                                 TESTING
<leader>tg   Lazygit                <leader>Tt Run nearest test
<leader>gb   Git blame              <leader>Tf Run file tests
<leader>gn/p Next/prev hunk         <leader>Ts Test summary

DIAGNOSTICS                         SESSION
<leader>xx   Workspace diagnostics  <leader>qs Restore session
]d/[d        Next/prev diagnostic   <leader>z  Zen mode
```
