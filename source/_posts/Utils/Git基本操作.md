---
title: Git基本操作
author: KawYang
top: false
cover: false
toc: true
mathjax: false
categories: Utils
tags:
  - Git
  - Utils
abbrlink: 235b27fb
date: 2021-09-01 21:34:08
img:
coverImg:
---

# Git 基本操作笔记

## 切换分支[^1]
```shell 
$ git checkout -b test 	# 创建并切换
$ git switch master  		# git 2.23 之后
$ git switch -c dev  		# 创建并切换
```

### checkout 

> -b <new_branch>
>         Create a new branch named <new_branch> and start it at <start_point>; see git-branch(1) for details.
>
> -B <new_branch>
>         Creates the branch <new_branch> and start it at <start_point>; if it already exists, then reset it to <start_point>. This is equivalent to running "git branch" with "-f"; see git-branch(1) for details.


### switch

> -c <new-branch>, --create <new-branch>
>    Create a new branch named <new-branch> starting at <start-point> before switching to the branch. This is a convenient shortcut for:

`$ git branch <new-branch>  `
`$ git switch <new-branch>`

## 暂存内容 `git stash`

> 在 dev 分支未开发完成,不必要commit 时,如果需要切换分支，需要将当前内容暂时存起来。

stash 文档内容如下：

```shell
SYNOPSIS
       git stash list [<options>]
       git stash show [<options>] [<stash>]
       git stash drop [-q|--quiet] [<stash>]
       git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
       git stash branch <branchname> [<stash>]
       git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
                    [-u|--include-untracked] [-a|--all] [-m|--message <message>]
                    [--pathspec-from-file=<file> [--pathspec-file-nul]]
                    [--] [<pathspec>...]]
       git stash clear
       git stash create [<message>]
       git stash store [-m|--message <message>] [-q|--quiet] <commit>
```

```shell
$ git stash [push]
 Save your local modifications to a new stash entry and roll them back to HEAD (in the working tree and in the index). The <message>
           part is optional and gives the description along with the stashed state.
 For quickly making a snapshot, you can omit "push". In this mode, non-option arguments are not allowed to prevent a misspelled
           subcommand from making an unwanted stash entry. The two exceptions to this are stash -p which acts as alias for stash push -p and
           pathspec elements, which are allowed after a double hyphen -- for disambiguation.
           
$ git stash list 
list [<options>]
           List the stash entries that you currently have.
           
$ git stash pop
pop [--index] [-q|--quiet] [<stash>]
           Remove a single stashed state from the stash list and apply it on top of the current working tree state, i.e., do the inverse
           operation of git stash push. The working directory must match the index.

           Applying the state can fail with conflicts; in this case, it is not removed from the stash list. You need to resolve the conflicts by
           hand and call git stash drop manually afterwards.
           
$ git stash apply
 apply [--index] [-q|--quiet] [<stash>]
           Like pop, but do not remove the state from the stash list. Unlike pop, <stash> may be any commit that looks like a commit created by
           stash push or stash create.
```



## 合并分支[^2]

git merge --ff / --no-ff / --ff-only

```shell
--ff, --no-ff, --ff-only
    Specifies how a merge is handled when the merged-in history is already a descendant of the current history. --ff is the default unless merging an annotated (and possibly signed) tag that is not stored in its natural place in the refs/tags/ hierarchy, in which case --no-ff is assumed.

    With --ff, when possible resolve the merge as a fast-forward (only update the branch pointer to match the merged branch; do not create a merge commit). When not possible (when the merged-in history is not a descendant of the current history), create a merge commit.

    With --no-ff, create a merge commit in all cases, even when the merge could instead be resolved as a fast-forward.
    
    With --ff-only, resolve the merge as a fast-forward when possible. When not possible, refuse to merge and exit with a non-zero status.
```



## 修复Bug过程

> 当前在 dev 开发， 需要在 master 上 修复Bug
>
> 1. 保存当前修改内容
> 2. 切换master分子
> 3. 创建修复Bug分支
> 4. 修复Bug
> 5. 切换主分支
> 6. 合并
> 7. 切换dev 分支
> 8. 恢复暂存的内容

```shell
1. git stash 
2. git checkout master 
3. git checkout -b issue-101  
4. # 修复Bug...
5. git switch master
6. git merge --no-ff -m "merged bug fix 101" issue-101
7. git switch dev
8. git stash list
9. git stash pop
## Bug 修复完成
```

## 添加新功能过程

> 为了防止把主分支内容搞乱，每添加一个新功能，最好新建一个`feature`分支  
>
> 1. 创建新功能分支
>
> 2. 开发内容 
>  3.1  合并到 开发分支
>     3.2  删除新开发内容

```shell
# 当前 master 分支
1. git switch -c feature-xx
2. # 开发...
3. git merge --no-ff -m "merged feature" dev
4. git branch -d[-D] feature-xx # 在未合并的情况下，使用 D 强制删除分支
```

# 参考内容

<h5 id = "fn_1"> [ ^ 1 ]: <a href = "https://blog.csdn.net/qq756684177/article/details/104454371">工具系列 | git checkout 可替换命令 git switch 和 git restore</a></h5>

<h5 id = "fn_3"> [ ^ 2 ]: <a href ='https://www.jianshu.com/p/418323ed2b03'>git merge和git merge --no-ff的区别</a></h5>



[^2]: [adssds](http://wwww.baidu.com)