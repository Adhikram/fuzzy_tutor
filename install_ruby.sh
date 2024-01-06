#!/bin/bash

# Check if Ruby 3.0.6 is installed
if ! command -v ruby &>/dev/null || [[ "$(ruby --version)" != *"ruby 3.0.6"* ]]; then
    echo "Ruby 3.0.6 not found, installing..."
    # Install Ruby 3.0.6 using your preferred method (e.g., rbenv, rvm, or other installation method)
    # For example, using rbenv:
    rbenv install 3.0.6
    rbenv global 3.0.6
else
    echo "Ruby 3.0.6 is already installed."
fi

# Install dependencies using bundle install
bundle install
