#!/bin/bash
# 自动化构建脚本，适用于 book 分支
set -e

# 清理旧的构建目录
rm -rf dist
rm -rf node_modules
rm -rf /gaara/Code/staticPage/dist
rm -rf /gaara/Code/staticPage/node_modules

# 更新代码
git pull origin book

# 根据传入的参数决定是否执行 npm install
echo "==> 执行 npm install"
docker exec node npm install

# 执行构建
echo "==> 执行 npm run build"
docker exec node npm run build

# 重载 Nginx
echo "==> 重载 Nginx 配置"
nginx -s reload

# 构建完成后将 /gaara/Code/staticPage/dist 移动到当前目录
if [ -d /gaara/Code/staticPage/dist ]; then
  
  mv /gaara/Code/staticPage/dist ./
  echo "==> 已将 /gaara/Code/staticPage/dist 移动到本地目录"
fi

echo "==> 构建完成"
