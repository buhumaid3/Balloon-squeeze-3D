#!/bin/zsh
# Xcode Cloud runs this automatically after cloning the repo, before building.
# This project's web assets (www/) are already static and already baked into
# ios/App/App/public — there's no JS build step to run here. The only thing
# a fresh clone is missing is the CocoaPods dependencies, since Pods/ is never
# committed to git.
set -e -o pipefail

echo "==> Installing CocoaPods"
export HOMEBREW_NO_INSTALL_CLEANUP=1
brew install cocoapods

echo "==> Running pod install"
cd "$(dirname "$0")/.."   # ci_scripts/ -> App/ (where the Podfile lives)
pod install

echo "==> Done"
