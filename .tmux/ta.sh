#!/bin/sh

if [ $# -gt 0 ] ; then
    session_name=$1
else
    path_name="$(basename "$PWD" | tr . -)"
    session_name=${1-$path_name}
fi


if [ "$session_name" = "jpbrione" ]; then
	session_name="asdf"
fi

not_in_tmux() {
  [ -z "$TMUX" ]
}

session_exists() {
  tmux has-session -t "=$session_name"
}

create_detached_session() {
  (TMUX='' tmux new-session -Ad -s "$session_name")
}

create_if_needed_and_attach() {
  if not_in_tmux; then
    tmux new-session -As "$session_name"
  else
    if ! session_exists; then
      create_detached_session
    fi
    tmux switch-client -t "$session_name"
  fi
}

create_if_needed_and_attach
