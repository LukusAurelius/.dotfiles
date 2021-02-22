function fish_ssh_agent -d "starts ssh_agent if it's not already started"
    if not pgrep -f ssh-agent > /dev/null
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
end

function __ssh_agent_is_started -d "check if ssh agent is already started"
    if not pgrep -f ssh-agent > /dev/null
        return 1
    else
        return 0
    end
end

#function __ssh_agent_is_started -d "check if ssh agent is already started"
#   if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
#      source $SSH_ENV > /dev/null
#   end
#
#   if test -z "$SSH_AGENT_PID"
#      return 1
#   end
#
#   ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
#   #pgrep ssh-agent
#   return $status
#end
