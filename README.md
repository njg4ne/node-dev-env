
# Node Development Environment Tooling

The templates in this repository are intended to be modified for support to develop in a constent dev environment accross platforms.

## Usage
- First, use `docker-compose run git-service`, which should not authenticate. Unless you already put some ssh keys in `secrets/`, use `ssh-keygen` with `-C "github-email@site.com"`, `-t ed25519` and `-f secrets/key-name-you-choose`. Then `exit` bash. Modify the keyname in both `command:` sections in `docker-compose.yml`. Also be sure to change your name and email in `gitfile`. Once you add the public key to your GitHub in the browser, the authentication should succeed from now on.
- You should be able to use either of these commands to attach to a container which exits when you are done, saving files in the mapped volumes:
    - `docker-compose run node-service`
    - `docker-compose run git-service`
- For shorthand, dot source a call to the aliasing script by running `. shorthand.sh`. Note that if you restart your original terminal, you will have to run this again.
- Now you should be able to use `dcRun git` or `dcRun node`
git remote set-url origin user@example.com:PATH/REPOSITORY
## File Permissions and Windows

Certain differences may exist based on the permissions you have in your text editor and command prompt. Using the packaged "node" user and their corresponging UID and GID seems to work for most systems. However, if you run into permissions issues, consider the implications of the user id and group id that you are using when you create files in the GUI.

For example, consider the following scenario using VS Code:
- you use the GUI button to create a file
- you open a terminal in your window
- the `ls` command says owner and their group are `root` and `root` respectively
- you will most likley need to use the `root` user rather than the `node` user, which may have security implications

A common reason for this problem is using VS Code in an unintended way with the filesystem.
- For one, try to keep files you are working with inside your WSL distribution (such as Ubuntu) reserved file spaces
    - You can find these in your Windows File Explorer by typing `\\wsl$` in the address bar
    - Make sure if you open a folder to work in within VS Code using a WSL terminal, you use the storage of your chosen distro
- Use the Remote - WSL Microsoft extension to work on code inside WSL. This seems to help file permissions work more elegantly by default.
- Even in a WSL Remote window, never having created a user in your distro can leave you as the root user by default. Google how to do create a user in your distro if you missed the boat when you first started your WSL distro.

## File Permissions Mac and Linux

### The Conflicts

**Scenario A**: You into the container and cannot `touch` files or run a code generator in a docker volume because of a permission issue.

**Scenario B** You can `touch` files in the container fine, but can't edit them from VS Code because that is back on your regular computer. 

**Diagnose** Use `id` to check your uid and gid *outside the container*. Then go inside the container and use `id` again. There should be differences! Where ever you are `0(root)`, you have superpowers and you will be creating permissions issues. If possible, try not to be `root`.

### Mac
Groups seem to be a little different on mac. The default node user seems to work fine, at least for adminisistrator mac accounts. Your uid might be `501` or `505`, without a corresponding gid.

### Linux
Linux seems to be more strict. Basically, you want to be a user inside the container that matches uid and gid with your PC user. 

Let's say my user is `abc` on my linux pc with uid `1000` and gid `1000`. I should be fine to become the `node` user inside the container, because even though I have a different name in that world, file permissions, which are based on *IDs* and not *usernames*, should be equal regardless of where I am doing stuff.

However, even if I am user `node` on my PC, but my uid and gid are `1002`, I cannot edit my files as node (`1000`) inside the container. Instead, in the Dockerfile, I have to run some one time commands to make a new user inside the container with the uid and gid `1002` and then switch to that user so that when I run bash in the container, I will login with *that* user instead of the `node` user.