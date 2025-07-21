#!/bin/bash
set -eux

# Install elan (Lean toolchain manager)
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y

# Add elan to PATH for all future shell sessions
echo 'export PATH="$HOME/.elan/bin:$PATH"' >> $HOME/.bashrc
echo 'export PATH="$HOME/.elan/bin:$PATH"' >> $HOME/.zshrc

# Activate the current Lean toolchain (Lean 4)
source $HOME/.elan/env
lean --version

# Optionally install Lake (Lean build tool, if not included)
lake --version || true
