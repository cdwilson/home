#!/bin/sh

echo "Installing post-commit hook..."
cp git/hooks/post-commit .git/hooks/
chmod +x .git/hooks/post-commit

./update.sh