#!/bin/bash

dir_shell=/ql/shell
. $dir_shell/share.sh
link_shell

cd $QL_DIR

echo -e "======================1. 检测配置文件======================\n"
make_dir /etc/nginx/conf.d
make_dir /run/nginx
cp -fv $nginx_conf /etc/nginx/nginx.conf
cp -fv $nginx_app_conf /etc/nginx/conf.d/front.>
pm2 l &>/dev/null
echo

echo -e "======================2. 安装依赖======================\n"
update_depend
echo

echo -e "======================3. 启动nginx======================\n"
nginx -s reload 2>/dev/null || nginx -c /etc/nginx/nginx.conf
echo -e "nginx启动成功...\n"

echo -e "======================4. 启动控制面板======================\n"
pm2 delete panel &>/dev/null
pm2 start $dir_root/build/app.js -n panel --source-map-support --time
echo -e "控制面板启动成功...\n"

echo -e "======================5. 启动定时任务======================\n"
pm2 delete schedule &>/dev/null
pm2 start $dir_root/build/schedule.js -n schedule --source-map-support --time
echo -e "定时任务启动成功...\n"

if [[ $AutoStartBot == true ]]; then
  echo -e "======================6. 启动bot======================\n"
  nohup ql bot >>$dir_log/start.log 2>&1 &
  echo -e "bot后台启动中...\n"
fi

if [[ $EnableExtraShell == true ]]; then
  echo -e "======================7. 执行自定义脚本======================\n"
  nohup ql extra >>$dir_log/start.log 2>&1 &
  echo -e "自定义脚本后台执行中...\n"
fi

echo -e "#####################################################\n"
echo -e "容器启动成功..."
echo -e "\n请先访问5700端口，登录成功面板之后再执行添加定时任务..."
echo -e "#####################################################\n"

crond -f >/dev/null

exec "$@"
