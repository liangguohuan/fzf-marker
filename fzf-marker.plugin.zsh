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
#   1.ctrl+space: marker select from fzf tty
#   2.ctrl+v:     replace maker into real value
#
# Environment:
#   # must before: export ZSH=$HOME/.oh-my-zsh if treat it as plugin
#   export FZF_MARKER_CONF_DIR=~/.config/marker
#   export FZF_MARKER_DISPLAY_KEY='\C-@'
#   export FZF_MARKER_NEXT_PLACEHOLDER_KEY='\C-v'
#
#===================================================================================================
#
# marker templete select
_fzf_marker_display() {
  local selected
  if selected=$(cat ${FZF_MARKER_CONF_DIR:-~/.config/marker}/*.txt | 
      sed -e 's/\(^[a-zA-Z0-9_-]\+\)\s/\x1b[38;5;255m\1\x1b[0m /' -e 's/\s*\(#\+\)\(.*\)/\x1b[38;5;8m  \1\2\x1b[0m/' |
      fzf --bind 'tab:down,btab:up' --height=80% --ansi -q "$LBUFFER"); then
      LBUFFER=$(echo $selected | sed 's/\s*#.*//')
  fi
  zle redisplay
}

# move the cursor the next placeholder 
function _fzf_move_cursor_to_next_placeholder {
    match=$(echo "$BUFFER" | perl -nle 'print $& if m{\{\{.+?\}\}}' | head -n 1)
    if [[ ! -z "$match" ]]; then
        len=${#match}
        match=$(echo "$match" | sed 's/"/\\"/g')
        placeholder_offset=$(echo "$BUFFER" | python -c 'import sys;keyboard_input = raw_input if sys.version_info[0] == 2 else input; print(keyboard_input().index("'$match'"))')
        CURSOR="$placeholder_offset"
        BUFFER="${BUFFER[1,$placeholder_offset]}${BUFFER[$placeholder_offset+1+$len,-1]}"
    fi        
}

zle -N _fzf_marker_display
zle -N _fzf_move_cursor_to_next_placeholder
bindkey "${FZF_MARKER_DISPLAY_KEY:-\C-@}" _fzf_marker_display
bindkey "${FZF_MARKER_NEXT_PLACEHOLDER_KEY:-\C-v}" _fzf_move_cursor_to_next_placeholder

