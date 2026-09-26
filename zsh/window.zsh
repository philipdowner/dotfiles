# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}

# Show the current directory in the window/tab title, and the running command
# while one is running.
autoload -Uz add-zsh-hook
_window_title_precmd() { print -Pn "\e]0;%~\a" }
_window_title_preexec() { print -Pn "\e]0;%~: "; print -rn -- "${1%% *}"; print -n "\a" }
add-zsh-hook precmd _window_title_precmd
add-zsh-hook preexec _window_title_preexec

