#!/bin/bash

# Ensure .git/hooks directory exists
mkdir -p .git/hooks

# Copy the post-commit hook to .git/hooks
cp hooks/post-commit .git/hooks/

# Make it executable
chmod +x .git/hooks/post-commit

echo "Git hooks installed successfully"