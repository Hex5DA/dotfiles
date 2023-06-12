export GOPATH="$HOME/go"
export RXVT_SOCKET="/tmp-urxvt-socket"
export LD_PRELOAD="/usr/lib/libswmhack.so.0.0"
export TZ=GB-Eire

if test -z "${XDG_RUNTIME_DIR}"; then
  export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
  if ! test -d "${XDG_RUNTIME_DIR}"; then
    mkdir "${XDG_RUNTIME_DIR}"
    chmod 0700 "${XDG_RUNTIME_DIR}"
  fi
fi

path+=("$GOPATH/bin")
path+=("/home/0x5da/bin")
export PATH

. "$HOME/.cargo/env"
