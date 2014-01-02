reshell() {
    if [ -n "$BASH" ]; then
        source $HOME/.bashrc
    elif [ -n "$ZSH_NAME" ]; then
        source $HOME/.zshrc
    else
        echo "fatal: Cannot recognize current shell $SHELL" >&2
        return 1
    fi

    return 0
}
