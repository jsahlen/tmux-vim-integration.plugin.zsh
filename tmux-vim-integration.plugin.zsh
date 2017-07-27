# Finds the first pane which has vim running, in the same window
__tmux_get_vim_pane() {
  local vim_pane

  tmux list-panes -F '#I #P [command:#{pane_current_command}] #{?pane_active,(active),}' | while read -r pane; do
    if [[ "${pane#*(active)}" = "${pane}" ]] && [[ "${pane}" =~ "\[command:n?vim\]" ]]; then
      vim_pane=$(echo "${pane}" | awk '{print $2}')
    fi
  done

  echo $vim_pane
}

# Open a file in adjacent vim
# $1 is the vim command to use (tabedit, split, vsplit)
# $2 is the path of the file to open
__tmux_vim_open() {
  local vim_command="$1"
  local filepath=$(realpath "$2")
  local vim_pane=$(__tmux_get_vim_pane)

  if [ -z $vim_pane ]; then
    echo "error: Vim pane not found"
    return
  fi

  tmux send-keys -t $vim_pane Escape ":${vim_command} $(printf "%q" "${filepath}")" Enter
  tmux select-pane -t $vim_pane
}

# Make available if inside a Tmux session
if [ -n "${TMUX}" ]; then
  tmux-vim-tabedit() {
    __tmux_vim_open "tabedit" "$1"
  }

  tmux-vim-split() {
    __tmux_vim_open "split" "$1"
  }

  tmux-vim-vsplit() {
    __tmux_vim_open "vsplit" "$1"
  }
fi
