# adb 基础命令

```bash
$ adb version
Android Debug Bridge version 1.0.40
Version 9.0.0_r18
Installed as /usr/bin/adb
$ adb shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]
$ adb push [--sync] LOCAL... REMOTE
$ adb reboot [bootloader|recovery|sideload|sideload-auto-reboot]
```

```bash
$ adb shell pm list packages -f # See their associated file.
$ adb shell pm list packages --user <USER_ID> # The user space to query.
$ adb install [-lrtsdg] [--instant] PACKAGE
$ adb install-multiple [-lrtsdpg] [--instant] PACKAGE...
$ adb uninstall  [-k] [--user <USER_ID>] PACKAGE
$ adb shell pm uninstall [-k] [--user <USER_ID>] PACKAGE
```

# 华为 EMUI 8.0 【开发人员选项】

* 开启: 点击【设置】进入设置界面打开【系统】>【关于手机】, 在这里点7次版本号
* 【系统】>【开发人员选项】
  + 自动系统更新 off
  + USB调试 on
  + 连接USB时总是弹出提示 on
  + 监控ADB安装应用 off
  + “仅充电”模式下允许ADB调试 off
  + 通过USB验证应用 on

# 应用管理

## 删除系统应用

```bash
USER_ID=0
APPS=(
    com.huawei.android.hwouc #系统更新
    com.huawei.himovie #华为视频
    com.android.mediacenter #华为音乐
    com.huawei.appmarket #应用市场
    com.huawei.wallet #华为钱包
    com.huawei.android.hwpay #华为钱包安全支付
    #com.android.keyguard #华为杂志锁屏
    com.huawei.skytone #天际通
    com.huawei.parentcontrol #学生模式
)
for app in ${APPS[@]}; do
    echo 'Uninstall $app for user $USER_ID ..."
    adb shell pm uninstall --user $USER_ID $app
done
```

## 删除非系统应用

```bash
APPS=(
    com.vmall.client #华为商城
    com.huawei.hnreader  #荣耀阅读
    com.huawei.lives #生活服务
    com.huawei.livewallpaper.simple #主题 简约S
    com.huawei.livewallpaper.geometry #主题 几何
    com.huawei.livewallpaper.honor #主题 流光
    com.huawei.gamebox #游戏中心
    com.huawei.smarthome #智能家居
    com.huawei.bone #华为穿戴
    com.huawei.fans #花粉俱乐部
    com.huawei.hwvplayer.youku #视频.优酷版
    com.huawei.gameassistant #游戏助手
    com.stupeflix.replay #Quik
    com.huawei.hifolder #精品推荐
    com.ss.android.article.news #今日头条
    com.ss.android.article.video #西瓜视频
    #com.sankuai.meituan #美团
    com.dianping.v1 #大众点评
    #com.taobao.taobao #手机淘宝
    com.jingdong.app.mall #京东
    com.ximalaya.ting.android #喜马拉雅FM
    #com.zhihu.android #知乎
    com.smile.gifmaker #快手
    com.sohu.newsclient #搜狐新闻
    com.sina.weibo #新浪微博
    com.achievo.vipshop #唯品会
    com.baidu.searchbox #手机百度
    com.suning.mobile.ebuy #苏宁易购
)

for app in ${APPS[@]}; do
    echo 'Uninstall $app ..."
    adb uninstall $app
done
```

## 安装常见应用

* [铁路12306](https://www.12306.cn/)
* [支付宝](https://mobile.alipay.com/index.htm)
* [百词斩](https://www.baicizhan.com/download.html)
* [百度地图](https://map.baidu.com/)
* [巴士管家](http://www.chebada.com/)
* [中国移动](http://www.10086.cn/)
* [网易云音乐](https://music.163.com/#/download)
* [携程旅行](http://app.ctrip.com/)
* [Firefox](https://wiki.mozilla.org/Mobile/Platforms/Android). addons: Adblock Plus, Network Preferences.
* [哔哩哔哩](https://www.bilibili.com/)
* [QQ国际版](https://im.qq.com/download/)
* [微信](https://weixin.qq.com/)
* [WPS Office](http://mo.wps.cn/pc-app/office-android.html)

```bash
UAPPDIR='常见应用'
find $UAPPDIR -type f -name '*.apk' -print -exec adb install -r {} \;
```

## 安装搜集应用

* [AndSMB-v3.2.apk](http://www.lysesoft.com/products/andsmb/index.html)
* [BubbleUPnP-v2.6.1.apk](http://bbs.zhiyoo.com/thread-12442204-1-1.html) DLNA server and client, cooperates with XBMC on PC.
* DoodleJump-v1.6.6.apk
* [ezPDF-Reader-v2.6.9.12-paid.apk](https://www.apkhere.com/app/udk.android.reader)
* [GoldenDict-1.6.5-Android-4.4+-free.apk](http://goldendict.mobi/downloads/android/free/)
* [kiwix-v2.2.apk](https://wiki.kiwix.org/wiki/Software)
* [Moon+Reader-Pro-v4.2.1-Offline.apk](https://club.huawei.com/thread-12779851-1-1.html)
* [MX-Player-Pro-v1.10.23.apk](https://club.huawei.com/thread-17573027-1-1.html)
* [RealCalc-Plus-v2.3.1-Patched.apk](https://apkhome.net/realcalc-plus-2-3-1/)
* [smart-tools-v2.0.8-paid.apk](https://www.apkhere.com/app/kr.aboy.tools)
* [TerminalEmulator-v1.0.70.apk](https://github.com/jackpal/Android-Terminal-Emulator)

```bash
MYAPPDIR='搜集应用'
find $MYAPPDIR -type f -name '*.apk' -print -exec adb install {} \;
```

## 添加桌面窗口小工具

* 一键优化
* 一键锁屏

# 添加 audio

```bash
adb shell mkdir -pv /storage/sdcard0/{Alarms,Notifications,Ringtones}
adb shell ls /storage/sdcard0/{Alarms,Notifications,Ringtones}
adb push --sync ./audio/Alarms /storage/sdcard0/
adb push --sync ./audio/Notifications /storage/sdcard0/
adb push --sync ./audio/Ringtones /storage/sdcard0/
adb shell ls /storage/sdcard0/{Alarms,Notifications,Ringtones}
```

# 设置记录

*
*
*

# 备份

* 实用工具 > 备份 > sd卡
