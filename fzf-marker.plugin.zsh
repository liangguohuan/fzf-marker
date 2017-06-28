# vim: fdm=marker ts=2 sw=2 sts=2 expandtab
#===================================================================================================
# fzf-marker: The terminal command
# Tweak https://github.com/pindexis/marker.git
#
# Author: hanson <liangguohaun@gmail.com>
# Github: https://github.com/liangguohaun
# Last Modified: 2017-05-26 10:10
# 
# How to install?
#   1.treat it as oh-my-zsh plugin
#     $ mkdir .oh-my-zsh/custom/plugins/fzf-marker
#     $ mv fzf-marker.plugin.zsh .oh-my-zsh/custom/plugins/fzf-marker
#     config .zshrc file in line plugins=(... fzf-marker)
#   2.manual install
#     [[ -s "fzf-marker.plugin.zsh" ]] && source "fzf-marker.plugin.zsh"
#
# Keybind:
#   1.ctrl+space: 
#     show markers from fzf tty
#     OR
#     replace maker into real value if '{{' exists in cmdline
#   2.ctrl+v:     move to next placeholder and set default val in {{}}
#
# Environment:
#   # must before: export ZSH=$HOME/.oh-my-zsh if treat it as plugin
#   export FZF_MARKER_CONF_DIR=~/.config/marker
#   export FZF_MARKER_COMMAND_COLOR='\x1b[38;5;255m'
#   export FZF_MARKER_COMMENT_COLOR='\x1b[38;5;8m'
#   export FZF_MARKER_MAIN_KEY='\C-@'
#   export FZF_MARKER_PLACEHOLDER_KEY='\C-v'
#
#===================================================================================================

# marker templete select
_fzf_marker_main_widget() {
  if echo "$BUFFER" | grep -q -P "{{"; then
    _fzf_marker_placeholder
  else
    local selected
    if selected=$(cat ${FZF_MARKER_CONF_DIR:-~/.config/marker}/*.txt | 
      sed -e "s/\(^[a-zA-Z0-9_-]\+\)\s/${FZF_MARKER_COMMAND_COLOR:-\x1b[38;5;255m}\1\x1b[0m /" \
          -e "s/\s*\(#\+\)\(.*\)/${FZF_MARKER_COMMENT_COLOR:-\x1b[38;5;8m}  \1\2\x1b[0m/" |
      fzf --bind 'tab:down,btab:up' --height=80% --ansi -q "$LBUFFER"); then
      LBUFFER=$(echo $selected | sed 's/\s*#.*//')
    fi
    zle redisplay
  fi
}

_fzf_marker_placeholder() {
  local strp pos placeholder
  strp=$(echo $BUFFER | grep -Z -P -b -o "\{\{[^\{\}]+\}\}")
  strp=$(echo "$strp" | head -1)
  pos=$(echo $strp | cut -d ":" -f1)
  placeholder=$(echo $strp | cut -d ":" -f2)
  if [[ -n "$1" ]]; then  
    BUFFER=$(echo $BUFFER | sed -e "s/{{//" -e "s/}}//")
    CURSOR=$(($pos + ${#placeholder} - 4))
  else
    BUFFER=$(echo $BUFFER | sed "s/$placeholder//")
    CURSOR=pos
  fi
}

_fzf_marker_placeholder_widget() { _fzf_marker_placeholder "defval" }

zle -N _fzf_marker_main_widget
zle -N _fzf_marker_placeholder_widget
bindkey "${FZF_MARKER_MAIN_KEY:-\C-@}" _fzf_marker_main_widget
bindkey "${FZF_MARKER_PLACEHOLDER_KEY:-\C-v}" _fzf_marker_placeholder_widget

