# Neovim + LazyVim + Sidekick + Codex

## Goal

Replace the old custom Packer-based Neovim configuration with a cleaner setup:

```text
Neovim
└── LazyVim
    ├── IDE/navigation features
    ├── LSP/completion/git/search
    └── Sidekick
        └── Codex CLI
```

No tmux or Zellij is required.

---

## 1. Upgrade Neovim

Sidekick requires Neovim >= 0.11.2.

With Homebrew:

```bash
brew update
brew upgrade neovim
```

Verify:

```bash
nvim --version
```

---

## 2. Install LazyVim Separately

To test LazyVim without touching the old configuration:

```bash
git clone https://github.com/LazyVim/starter ~/.config/lazyvim
```

Launch it with:

```bash
NVIM_APPNAME=lazyvim nvim
```

This leaves the existing configuration at:

```text
~/.config/nvim
```

untouched.

---

## 3. Enable Sidekick

Inside LazyVim:

```vim
:LazyExtras
```

Enable:

```text
ai.sidekick
```

Restart Neovim.

Check the installation:

```vim
:checkhealth sidekick
```

Codex should appear as installed under "Sidekick AI CLI Tools."

Warnings for agents such as Aider, Gemini, Qwen, etc. can be ignored if they are not being used.

---

## 4. Disable Unneeded Copilot and Multiplexer Features

Create:

```text
~/.config/lazyvim/lua/plugins/sidekick.lua
```

with:

```lua
return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = false,
      },

      cli = {
        mux = {
          enabled = false,
        },
      },
    },
  },
}
```

This keeps Sidekick focused on CLI agents such as Codex without requiring GitHub Copilot, tmux, or Zellij.

---

## 5. Using Codex

Useful Sidekick commands:

```text
Space a s     select an AI CLI agent
Space a a     toggle the selected agent
Space a f     send current file
Space a v     send visual selection
Space a p     choose an AI prompt
Ctrl-.        focus Sidekick
```

Select `codex` with:

```text
Space a s
```

Then open/toggle it with:

```text
Space a a
```

Codex runs in a Neovim terminal window beside the editor.

---

## 6. Window Navigation

LazyVim normally uses:

```text
Ctrl-h        left
Ctrl-j        down
Ctrl-k        up
Ctrl-l        right
```

To restore the old Space + hjkl navigation, edit:

```text
~/.config/lazyvim/lua/config/keymaps.lua
```

and add:

```lua
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to Right Window" })
```

This makes navigation between the file explorer, editor, and Codex feel similar to the old setup.

---

# Replacing the Old Neovim Setup

Once LazyVim is working correctly, close all Neovim instances.

## 7. Quarantine the Old Configuration

Do not immediately delete it.

```bash
mv ~/.config/nvim ~/.config/nvim-old
```

Also preserve the old Neovim runtime/plugin directories:

```bash
mv ~/.local/share/nvim ~/.local/share/nvim-old 2>/dev/null || true
mv ~/.local/state/nvim ~/.local/state/nvim-old 2>/dev/null || true
mv ~/.cache/nvim ~/.cache/nvim-old 2>/dev/null || true
```

The old setup includes the custom `lua/nathan` configuration, Packer, `packer_compiled.lua`, and the old installed plugins.

---

## 8. Promote LazyVim to the Default Configuration

Move:

```bash
mv ~/.config/lazyvim ~/.config/nvim
```

Now launch normally:

```bash
nvim
```

There is no longer any need for:

```bash
NVIM_APPNAME=lazyvim nvim
```

LazyVim may reinstall its plugins the first time because it now uses the default Neovim data directories.

---

## 9. Verify Everything

Open a real project:

```bash
cd ~/path/to/project
nvim .
```

Check:

```text
Space e       explorer
Space f f     find files
Space /       project search

Space h/j/k/l window navigation

Space a s     choose Codex
Space a a     open Codex
```

Also check:

```vim
:checkhealth
```

---

## 10. Delete the Old Setup

Only after the new environment has been used successfully and nothing is missing:

```bash
rm -rf ~/.config/nvim-old
rm -rf ~/.local/share/nvim-old
rm -rf ~/.local/state/nvim-old
rm -rf ~/.cache/nvim-old
```

This permanently removes the old Packer-based Neovim environment.

If an alias was created while testing LazyVim, such as:

```bash
alias lv='NVIM_APPNAME=lazyvim nvim'
```

remove it from `~/.zshrc`.

The normal workflow is now simply:

```bash
cd my-project
nvim .
```

with LazyVim providing the IDE and Sidekick providing access to Codex.
