# Brief:
fzf-marker: The terminal command
Tweak https://github.com/pindexis/marker.git

[![asciicast](https://asciinema.org/a/122370.png)](https://asciinema.org/a/122370)

# How to install?
  ```
  1.treat it as oh-my-zsh plugin
    $ mkdir .oh-my-zsh/custom/plugins/fzf-marker
    $ mv fzf-marker.plugin.zsh .oh-my-zsh/custom/plugins/fzf-marker
    config .zshrc file in line plugins=(... fzf-marker)
  2.manual install
    [[ -s "fzf-marker.plugin.zsh" ]] && source "fzf-marker.plugin.zsh"
  ```

# Keybind:
  ```
  1.ctrl+space: marker select from fzf tty
  2.ctrl+v:     replace maker into real value
  ```

# Environment:
  ```
  # must before: export ZSH=$HOME/.oh-my-zsh if treat it as plugin
  export FZF_MARKER_CONF_DIR=~/.config/marker
  export FZF_MARKER_DISPLAY_KEY='\C-@'
  export FZF_MARKER_NEXT_PLACEHOLDER_KEY='\C-v'
  ```

