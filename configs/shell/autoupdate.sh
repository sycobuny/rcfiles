if needs-update autoupdate; then
    reset-updated autoupdate
    eval "$(autoupdate-config autoupdate.command)"
fi
