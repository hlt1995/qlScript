### 安装依赖

第一步、Alpine下执行`npm install -g npm@6` 安装完成后Zerotermux退出后台重新打开

第二步、打开科学上网，进入Alpine安装依赖
```
npm install axios moment ds jsdom sharp@0.32.0 --prefix /ql

```

第三步、安装完成后恢复mpn版本，在Alpine下执行
```
rm -f /usr/local/bin/npm
rm -f /usr/local/bin/npx

```

---

### 定期重启

第一步、手机设定定时开关机，每周六 关机`3：31` - 开机`3：36`

第二步、通过MacroDroid设置开机启动ZeroTermux

第三步、Alpine下执行`nano ~/.profile`,在文件中添加

```
cd ~

# 判断青龙面板是否已经启动 
if ! pm2 list | grep -qE 'panel|schedule'; then
  ./ql.sh
fi
```

---

### 面板配置

第一步、拉qlScript库

第二步、配置文件关闭`自动删除失效的脚本与定时任务`和`自动增加新的本地定时任务`

第三步、拉jdpro库，完整拉一次

第四步、打开自动增加新的本地定时任务,用推荐拉库指令再拉一次jdpro

第五步、新建脚本`新农场幸运转盘_2`、`jd_CheckCK1.js`、`jd_bean_change1.js`
