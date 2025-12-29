#!/bin/bash
set -e

echo "Setting up development environment with uv..."

# Check if uv is already installed
if command -v uv &> /dev/null; then
    echo "uv is already installed."
else
    echo "Installing uv..."
    # Install uv using the official installer
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    # Add uv to the current shell session
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Create a virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    uv venv
else
    echo "Virtual environment already exists."
fi

# Install dependencies using uv
echo "Installing dependencies with uv..."
uv pip install -r requirements.txt

echo "Setup complete! Activate the virtual environment with:"
echo "source .venv/bin/activate"