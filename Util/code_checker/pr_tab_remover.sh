#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}

# Add rsa keys to the ssh agent to push to GitHub
gpg --output ../id_rsa_travis --batch --passphrase $DECRYPT_GITHUB_AUTH --decrypt $TRAVIS_BUILD_DIR/id_rsa_travis.enc
chmod 600 ../id_rsa_travis
eval `ssh-agent -s`
ssh-add ../id_rsa_travis
#ls ../id_rsa_travis

echo "Running tab exterminator script"

cd $TRAVIS_BUILD_DIR/Util/code_checker
./tab_exterminator.sh

# Now let's go have some fun with the cloned repo
cd $TRAVIS_BUILD_DIR
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

echo "doing git add/commit/push"

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
git add --all

# Exit if there are no docs changes
if git diff --staged --quiet; then
   echo "exiting with no changes"
   exit 0
fi

# Otherwise, commit and push
git commit -m "Tabs have been converted to spaces by tab_exterminator.sh"
git push $SSH_REPO $TRAVIS_PULL_REQUEST_BRANCH
cd 

# Kill the ssh-agent
ssh-agent -k