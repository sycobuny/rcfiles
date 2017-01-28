# macports is something we've only got in macOS
export MACPORTS_HOME="${HOME}/.macports"

# macports binaries should take priority over system binaries
export PATH="${MACPORTS_HOME}/bin:${PATH}"
