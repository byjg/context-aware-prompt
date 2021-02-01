# Context Aware Prompt

```tip
This project is a fork from https://github.com/jimeh/git-aware-prompt/ 
initialy focused only in the Git context. 
```

There are several command line tools that uses some context and for many times can lead us to errors if
we don't pay attention for the context we are executing those commands. 

For example, constantly switching git branches can be confusing though as you have to
run `git status` to see which branch you're currently on. The same for the current kubernetes
context we are using. If we are working with multiples cluster and namespaces we can apply or delete 
a configuration in the wrong cluster and you have to run `kubectl config current-context` to see the context you are.  

The solution to this is to have your terminal prompt display the current
branch. There's a [number][1] [of][2] [articles][3] [available][4] online
about how to achieve this. This project is an attempt to make an easy to
install/configure solution.

[1]: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
[2]: http://railstips.org/2009/2/2/bedazzle-your-bash-prompt-with-git-info
[3]: http://techblog.floorplanner.com/2008/12/14/working-with-git-branches/
[4]: http://www.intridea.com/2009/2/2/git-status-in-your-prompt

## Contexts Available

- Current Git Branch
- Current Working Directory has changes or is ahead or behind the server
- Cluster name and branch of the active Kubernetes config 

## Overview

If you `cd` to a Git working directory, you will see the current Git branch
name displayed in your terminal prompt. When you're not in a Git working
directory, your prompt works like normal.

The same if you have a KUBECONFIG environment variable set or a file `~/.kube/config`/

![Git Branch in Prompt](https://raw.github.com/byjg/git-aware-prompt/master/preview.png)

## Installation

### TL;DR

```bash
bash <(wget -qO- https://raw.githubusercontent.com/byjg/git-aware-prompt/master/install.sh)
```

### Detailed instructions

Clone the project to a `.bash` folder in your home directory:

```bash
mkdir ~/.bash
cd ~/.bash
git clone git://github.com/byjg/git-aware-prompt.git
```

Edit your `~/.bash_profile` or `~/.profile` and add the following to the top:

```bash
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
```

#### Configuring

Once installed, there will be new `$git_branch`, `$git_dirty` and `k8s_config` variables
available to use in the `PS1` environment variable, along with a number of
color helper variables which you can see a list of in [colors.sh][].

[colors.sh]: https://github.com/byjg/git-aware-prompt/blob/master/colors.sh

If you want to know more about how to customize your prompt, I recommend
this article: [How to: Change / Setup bash custom prompt (PS1)][how-to]

[how-to]: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html


#### Suggested Prompts

Below are a few suggested prompt configurations. Simply paste the code at the
end of the same file you pasted the installation code into earlier.


#### Mac OS X

```bash
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
```

Optionally, if you want a nice pretty prompt when using `sudo -s`, also add
this line:

```bash
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
```


#### Ubuntu

Standard:

```bash
export PS1="\${debian_chroot:+(\$debian_chroot)}\u@\h:\w \[$txtylw\]\$k8s_config\[$txtrst\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
```

Colorized:

```bash
export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtylw\]\$k8s_config\[$txtrst\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
```


## Updating

Assuming you followed the default installation instructions and cloned this
repo to `~/.bash/git-aware-prompt`:

```bash
cd ~/.bash/git-aware-prompt
git pull
```

## License

[CC0 1.0 Universal](http://creativecommons.org/publicdomain/zero/1.0/)

