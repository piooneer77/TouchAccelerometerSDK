#!/bin/bash

# Create the hooks directory if it doesn't exist
mkdir -p hooks

# Create the post-commit hook in the hooks directory
cat > hooks/post-commit << 'EOL'
#!/bin/bash

# Get the current branch name
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

# Only run on develop branch
if [ "$CURRENT_BRANCH" = "develop" ]; then
    echo "Commit detected on develop branch - running archive build script"
    
    # Get the directory of the current repository
    REPO_DIR=$(git rev-parse --show-toplevel)
    
    # Run the build script
    bash "${REPO_DIR}/Scripts/build-framework.sh" "hook"
else
    echo "Commit not on develop branch - skipping archive build"
fi
EOL

# Make the hook executable
chmod +x hooks/post-commit

# Create a setup script to install the hooks
cat > setup-hooks.sh << 'EOL'
#!/bin/bash
cp hooks/post-commit .git/hooks/
chmod +x .git/hooks/post-commit
echo "Git hooks installed successfully"
EOL

chmod +x setup-hooks.sh