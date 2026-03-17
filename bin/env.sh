export HARDWARE_HACKING_ROOT=$(git rev-parse --show-toplevel)
OS="$(uname -s)"

case ${OS} in
  Darwin)
    echo Mac
    ;;
  Linux)
    echo Linux
    ;;
  *)
    echo "Operating system not recognized: \"${OS}\""
    ;;
esac

# Add local bin to path
echo "Prepending ${HARDWARE_HACKING_ROOT}/bin to PATH"
export PATH="${HARDWARE_HACKING_ROOT}/bin:${PATH}"

# Make screen check the local dir for .screenrc
export SCREENRC=".screenrc"
