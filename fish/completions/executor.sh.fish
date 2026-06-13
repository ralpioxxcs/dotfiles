set -l commands start down restart status seed
set -l modes all dmpro_infra dmpro_service common_infra common_service
set -l langs en ko
set -l envs local dev

complete -c executor.sh -s c -d "Command" -r -f -a "$commands"
complete -c executor.sh -s m -d "Mode (comma-separated)" -r -f -a "$modes"
complete -c executor.sh -s l -d "Language" -r -f -a "$langs"
complete -c executor.sh -s e -d "Environment" -r -f -a "$envs"
