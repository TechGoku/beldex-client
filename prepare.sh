#!/usr/bin/env bash

set -e # Exit on any error

# Dependencies

## These should be audited!
mymonero_core_cpp_url='https://github.com/Beldex-Coin/beldex-core-cpp.git'
mymonero_core_cpp_hash='f35b6cc267891b253770b17e267a83667bcaa1a8'
monero_core_custom_url='https://github.com/Beldex-Coin/beldex-core-custom.git'
monero_core_custom_hash='63175e7ec8671b5c2c9dbfecbbda6c01d6654659'

if [ "$(basename "$(pwd)")" != "mymonero-monero-client" ]; then
  echo "Should be ran from the repo dir!"
  exit 1
fi

function clonerepo { # source, target, commit
  rm -rf "$2"
  oldpwd="$(pwd)"

  git clone "${1}" "${2}" || exit 1
  cd "$2"
  git reset --hard "$3" || exit 1
  if [ "$(git rev-parse HEAD)" != "$3" ]; then
    echo "Wrong HEAD!"
    exit 1
  fi

  cd "$oldpwd"
}

# Clone dependencies

echo "Cloning dependencies..."
rm -rf 'src/submodules' && mkdir -p 'src/submodules'
clonerepo "${mymonero_core_cpp_url}" 'src/submodules/beldex-core-cpp' "${mymonero_core_cpp_hash}"
clonerepo "${monero_core_custom_url}" 'src/submodules/beldex-core-custom' "${monero_core_custom_hash}"

# Prepare for build

echo "Clearing the build dir..."
rm -rf build && mkdir build

# Finished

echo "All done! We are prepared for the build now."