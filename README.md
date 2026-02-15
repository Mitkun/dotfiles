# 🛠 Dotfiles

![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![WezTerm](https://img.shields.io/badge/WezTerm-4EAA25?style=for-the-badge)
![Zsh](https://img.shields.io/badge/Zsh-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)

Personal macOS development environment configuration.

This repository manages my:

- ⚡ Neovim (Lua-based config)
- 🖥 WezTerm
- 🐚 Zsh

All configurations are managed using **GNU Stow** for a clean, reproducible setup.

---

## 📸 Preview

> (Optional) Add screenshots here

Example:

```md
![WezTerm Preview](images/terminal.png)
![Neovim Preview](images/nvim.png)
```

---

## 📁 Repository Structure

```
dotfiles/
├── nvim/
│   └── .config/nvim/
├── wezterm/
│   └── .config/wezterm/
├── zsh/
│   └── .zshrc
└── README.md
```

All configs are symlinked into `$HOME` via `stow`.

---

## 🚀 Setup on a New Machine

### 1️⃣ Clone the repository

```
git clone ssh git@github.com:Mitkun/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2️⃣ Install dependencies

- Neovim
- WezTerm
- Zsh
- GNU Stow
- JetBrainsMono Nerd Font

### 3️⃣ Apply configurations

```
stow nvim
stow wezterm
stow zsh
```

---

## 🎯 Design Philosophy

- Minimal but functional
- Fast startup
- Keyboard-driven workflow
- Clean visuals
- Reproducible environment

No unnecessary plugins. No bloat.

---

## 🖥 WezTerm Notes

Background images are stored in:

```
wezterm/.config/wezterm/backgrounds/
```

Supports:

- Random background
- Auto darken when using Neovim
- Performance tuning for low-power MacBook Air

---

## 🔒 Security

Sensitive files are excluded using `.gitignore`.

Never commit:

- `.env`
- SSH keys
- API keys

---

## 📜 License

MIT (or personal use)
