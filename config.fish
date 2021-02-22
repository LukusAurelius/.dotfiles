#cd ~

starship init fish | source
fish_ssh_agent

set -l key_location ~/.ssh/lukusaurelius
if __ssh_agent_is_started
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        and test -e $key_location
        ssh-add $key_location
    end
end

#ssh-add $HOME/.ssh/lukusaurelius
