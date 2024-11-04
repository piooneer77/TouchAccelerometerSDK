#!/bin/bash
cp hooks/post-commit .git/hooks/
chmod +x .git/hooks/post-commit
echo "Git hooks installed successfully"
