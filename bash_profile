stty -ixon

export PATH="$HOME/bin:$PATH";
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

for file in $HOME/.{bash_prompt, aliases, functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
