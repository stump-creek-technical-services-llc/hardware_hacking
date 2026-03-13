export HARDWARE_HACKING_ROOT=$(git rev-parse --show-toplevel)
OS="$(uname -s)"

case ${OS} in
  Darwin)
    echo Mac

    # Add GNU utils to path
    COREUTILS_PATH="$(brew --prefix --installed coreutils)/libexec/gnubin"
    echo "Prepending coreutils to PATH: ${COREUTILS_PATH}"

    # Add other GNU package to path
    for PACKAGE in awk file
    do
      PACKAGE_PATH="$(brew --prefix --installed ${PACKAGE})/bin"
      echo "Prepending ${PACKAGE} to PATH: ${PACKAGE_PATH}"
      export PATH="${PACKAGE_PATH}:${PATH}"
    done

    export PATH="${COREUTILS_PATH}:${PATH}"
    ;;
  Linux)
    echo linux
    ;;
  *)
    echo "Operating system not recognized: \"${OS}\""
    ;;
esac

# Add local bin to path
echo "Prepending ${HARDWARE_HACKING_ROOT}/bin to PATH"
export PATH="${HARDWARE_HACKING_ROOT}/bin:${PATH}"
