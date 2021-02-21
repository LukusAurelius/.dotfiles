function __ssh_agent_is_started -d "check if ssh agent is already started"
    if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
        source $SSH_ENV > /dev/null
    end
 
    if test -z "$SSH_AGENT_PID"
        return 1
    end
 
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
    #pgrep ssh-agent
    return $status
end


function __ssh_agent_start -d "start a new ssh agent"
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    chmod 600 $SSH_ENV
    source $SSH_ENV > /dev/null
    true  # suppress errors from setenv, i.e. set -gx
end


function fish_ssh_agent --description "Start ssh-agent if not started yet, or uses already started ssh-agent."
    if test -z "$SSH_ENV"
        set -xg SSH_ENV $HOME/.ssh/environment
    end
 
    set -l key_name lukusaurelius
    
    # Only starts ssh_agent if $key_name exists in ~/.ssh/
    if not __ssh_agent_is_started
        and test -e ~/.ssh/$key_name
        __ssh_agent_start
    end
 
    # Checks if there are keys in ssh-agent; if not, adds the key at ~/.ssh/$key_name
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add ~/.ssh/$key_name
    end
end
