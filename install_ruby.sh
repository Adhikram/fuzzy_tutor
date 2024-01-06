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

# Install necessary libraries for mysql2 gem
# Check the system package manager and install the required packages
if command -v apt-get &> /dev/null; then
    sudo apt-get install -y libmysqlclient-dev
elif command -v yum &> /dev/null; then
    sudo yum install -y mysql-devel
elif command -v brew &> /dev/null; then
    brew install mysql-client
else
    echo "Package manager not found. Please install libmysqlclient-dev or equivalent manually."
    exit 1
fi

# Install dependencies using bundle install
bundle install
