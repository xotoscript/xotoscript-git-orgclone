### 🔥 clone organization level repos

```bash
# usage:
#  $ ./install --token {TOKEN} --username {USERNAME} --clean {CLEAN} --organization {ORGANIZATION}
#
# * --username: username
# * --token: token
# * --clean: reset git
# * --organization: organization
#
# be careful with clean as it will reset your git commit history with the current default branch 
# more info : https://raw.githubusercontent.com/xotoscript/xotoscript-git-reporeset/development/install.sh


# run simple command :
wget -qO- https://raw.githubusercontent.com/xotoscript/xotoscript-git-orgclone/development/install.sh | bash -s -- --token ghp_xxx --username xotosphere --clean false --organization xotoboil

# on your local : 
bash install.sh --token ghp_xxx --username xotosphere --clean false --organization xotoboil
```


