#!/bin/bash

# Check if rbenv is installed
if ! command -v rbenv &> /dev/null; then
    echo "rbenv not found, installing..."

    # Clone rbenv repository
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv

    # Add rbenv to PATH
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    # Reload shell configuration
    source ~/.bashrc

    # Clone ruby-build plugin for rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

    # Verify rbenv installation
    if ! command -v rbenv &> /dev/null; then
        echo "rbenv installation failed. Please install rbenv manually."
        exit 1
    else
        echo "rbenv successfully installed."
    fi
else
    echo "rbenv is already installed."
fi

# Initialize rbenv (if not already initialized)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

gem install pg -- --with-pg-config=/usr/pgsql-13/bin/pg_config
# Install dependencies using bundle install
bundle install
