# Brief:

fzf-marker: The terminal command
Tweak https://github.com/pindexis/marker.git

[![asciicast](https://asciinema.org/a/122370.png)](https://asciinema.org/a/122370)

# Depends
1.[zsh](http://www.zsh.org/) more powerful then bash  
2.[fzf](https://github.com/junegunn/fzf) A command-line fuzzy finder written in Go

# How to install?

  1.treat it as oh-my-zsh plugin
  ```sh
    $ mkdir .oh-my-zsh/custom/plugins/fzf-marker
    $ mv fzf-marker.plugin.zsh .oh-my-zsh/custom/plugins/fzf-marker
    config .zshrc file in line plugins=(... fzf-marker)
  ```
  2.manual install
  ```sh
    [[ -s "fzf-marker.plugin.zsh" ]] && source "fzf-marker.plugin.zsh"
  ```
# Macos: There is something needed to be done
```sh
  $ brew install grep
  $ ln -s /usr/local/Cellar/grep/3.3/bin/ggrep /usr/local/bin/grep
```

# Keybind:

1.<kbd>ctrl+space</kbd>:  
show markers from fzf tty  
OR  
replace maker into real value if '{{' exists in cmdline  
2.<kbd>ctrl+v</kbd>:  
move to next placeholder and set default val in {{}} 

# Environment:

  ```sh
  # must before: export ZSH=$HOME/.oh-my-zsh if treat it as plugin
  export FZF_MARKER_CONF_DIR=~/.config/marker
  export FZF_MARKER_COMMAND_COLOR='\x1b[38;5;255m'
  export FZF_MARKER_COMMENT_COLOR='\x1b[38;5;8m'
  export FZF_MARKER_MAIN_KEY='\C-@'
  export FZF_MARKER_PLACEHOLDER_KEY='\C-v'
  ```

