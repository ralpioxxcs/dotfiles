if status is-interactive
# Commands to run in interactive sessions can go here
end
starship init fish | source
zoxide init fish | source
export PATH="$HOME/.local/bin:$PATH"

source ~/.config/fish/completions/executor.sh.fish

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
