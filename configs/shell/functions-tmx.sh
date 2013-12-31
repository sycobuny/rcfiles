tmx() {
    if [ -n "$TMUX" ]; then
        echo 'Will not run inside of existing tmux session' >&2
        return
    fi

    if [ -z "$1" ]; then
        echo 'Specify session name as the first argument' >&2
        return
    fi

    # Special case: `tmx ls` behaves just like `tmux ls`
    if [ $1 = 'ls' ]; then
        tmux ls
        return
    fi

    # if the requested session doesn't exist, launch and immediately return
    if [ $(tmux ls | grep "^$1: " | wc -l) -eq 0 ]; then
        echo "Launching tmux base session $1 ..."
        tmux new-session -s $1
        return
    fi

    # kill defunct old sessions before starting new ones
    local old_session_id
    local old_sessions=$(tmux ls 2>/dev/null | egrep '^[0-9]{14}.*[0-9]+\)$' \
                         | cut -d: -f1)

    for old_session_id in $old_sessions; do
        tmux kill-session -t $old_session_id
    done

    # check if the requested session (now assumed to exist) is attached. if
    # not, then attach and return
    if [ $(tmux ls | grep "^$1: " | grep -v attached | wc -l) -ne 0 ]; then
        echo "Attaching to unattached base session $1 ..."
        tmux attach -t $1
        return
    fi

    local session_num

    # find out the highest session clone number that exists for our base
    session_num=$(tmux ls | grep "^$1-" | cut -d- -f2 | sort -rn | head -n1)

    # if we haven't cloned it yet, default to 0, and increment that by one to
    # get a new session id
    session_num=$((${session_num:-0} + 1))

    # create new session (without attaching) and link to base to share windows
    echo "Launching copy of base session $1 ..."
    tmux new-session -d -t $1 -s "$1-$session_num"

    # Attach to the new session
    tmux attach-session -t "$1-$session_num"

    # When we detach from it, kill the new session
    tmux kill-session -t "$1-$session_num"
}

# Modified TMUX start script from:
#     http://forums.gentoo.org/viewtopic-t-836006-start-0.html
