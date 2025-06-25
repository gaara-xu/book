#!/bin/bash
# 自动化 git 提交脚本，适用于 book 分支

git checkout book || git checkout -b book

git pull origin book
if [ $? -ne 0 ]; then
  echo "拉取远程分支失败，终止提交。"
  exit 1
fi

git add .

# 判断是否有变更
if git diff --cached --quiet; then
  echo "没有需要提交的更改。"
  exit 0
fi

echo "请输入提交注释（直接回车则使用当前时间）："
read msg
if [ -z "$msg" ]; then
  msg="$(date '+%Y-%m-%d %H:%M:%S') 自动提交"
fi

git commit -m "$msg"
git push origin book
