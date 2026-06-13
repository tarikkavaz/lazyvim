# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.



- Make a backup of your current Neovim files:
  ```sh
  # required
  mv ~/.config/nvim{,.bak}

  # optional but recommended
  mv ~/.local/share/nvim{,.bak}
  mv ~/.local/state/nvim{,.bak}
  mv ~/.cache/nvim{,.bak}
  ```
- Clone the starter
  ```sh
  git clone https://github.com/tarikkavaz/lazyvim ~/.config/nvim
  ```
- Remove the `.git` folder, so you can add it to your own repo later
  ```sh
  rm -rf ~/.config/nvim/.git
  ```
- Start Neovim!
  ```sh
  nvim
  ```

