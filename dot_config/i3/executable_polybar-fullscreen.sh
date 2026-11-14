#!/usr/bin/env bash
# Hide polybar while a visible workspace shows a fullscreen window, show it otherwise.
#
# The state is re-checked on every focus, close, move and fullscreen change, not
# only on fullscreen toggles: windows like the flameshot capture overlay open in
# fullscreen and then just close, which never emits a "leave fullscreen" event.

# The visible workspace of an output is the first entry in its content
# container's focus stack. Workspaces report fullscreen_mode 1 themselves, so
# only the windows inside them count.
readonly FULLSCREEN_ON_VISIBLE_WORKSPACE='
  [ .nodes[] | select(.type == "output" and .name != "__i3")
    | .nodes[] | select(.type == "con" and .name == "content")
    | .focus[0] as $visible | .nodes[] | select(.id == $visible)
    | (.nodes + .floating_nodes)[] | .. | objects | .fullscreen_mode // 0 ]
  | any(. > 0)
'

# Title, mark and urgency changes fire often and never affect fullscreen state.
readonly RELEVANT_CHANGES='["focus", "close", "move", "fullscreen_mode"]'

sync_bar() {
  if [ "$(i3-msg -t get_tree | jq "$FULLSCREEN_ON_VISIBLE_WORKSPACE")" = "true" ]; then
    polybar-msg cmd hide
  else
    polybar-msg cmd show
  fi >/dev/null 2>&1
}

sync_bar
i3-msg -t subscribe -m '["window", "workspace"]' \
  | jq --unbuffered -c --argjson changes "$RELEVANT_CHANGES" 'select(.change | IN($changes[]))' \
  | while read -r _; do sync_bar; done
