#!/bin/sh

# make sure everything is executable
chmod +x git/hooks/post-commit
chmod +x setup.sh
chmod +x update.sh

echo "Installing post-commit hook..."
pushd .git/hooks/ > /dev/null
if [ -h post-commit ]; then
    while true; do
        read -p "Do you wish overwrite the existing post-commit symlink? " yn
        case $yn in
            [Yy]* )
                ln -s -f ../../git/hooks/post-commit post-commit
                break
                ;;
            [Nn]* )
                break
                ;;
            * )
                echo "Please answer yes or no."
                ;;
        esac
    done
elif [ -e post-commit ]; then
    while true; do
        echo "WARNING: post-commit hook is an actual file (not symlink)!"
        read -p "Do you wish overwrite the existing post-commit file with a \
symlink? " yn
        case $yn in
            [Yy]* )
                ln -s -f ../../git/hooks/post-commit post-commit
                break
                ;;
            [Nn]* )
                break
                ;;
            * )
                echo "Please answer yes or no."
                ;;
        esac
    done
else
    ln -s ../../git/hooks/post-commit post-commit
fi
popd > /dev/null

./update.sh
