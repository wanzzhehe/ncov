# 西安电子科技大学晨午晚检自动填报工具

*疫情防控责任重大，请大家如实填报，并根据自己的真实情况修改填报内容，填报内容在data文件夹中进行修改*

1月31日更新说明：
1. 更新了家里的填报信息
2. 原来只有晨午检的信息，现在加入了疫情通的填报，用`-t y`来填报疫情通，`-t c`来填报晨午检。

相比@anadfox233的版本添加了定时自动填报的功能，添加了南校区的位置信息，改了几个小bug

## 注意
本脚本内置了南校区和北校区及我家的经纬度,**默认定位为我家（记得去utils里面进行修改），这一步需要自己进行抓包**

> 其他地区, 请提交Issue
## 项目依赖
* python >= 3
* pip

```shell script
pip install -r requirements.txt
```

## 使用方法

###  到data文件夹中填写上传信息

> python 字典的语法, '#'以后为注释。各个参数与选项皆已列出,每一项都是必填字段

```python
{
    "sfzx": "1", # 是否在校(0->是, 1->否)
    "tw": "1", # 体温 (36℃->0, 36℃到36.5℃->1, 36.5℃到36.9℃->2, 36.9℃到37℃.3->3, 37.3℃到38℃->4, 38℃到38.5℃->5, 38.5℃到39℃->6, 39℃到40℃->7, 40℃以上->8)
    "sfcyglq": "0", # 是否处于隔离期? (0->是, 1->否)
    "sfyzz": "0", # 是否出现乏力、干咳、呼吸困难等症状？ (0->是, 1->否)
    "qtqk": "", # 其他情况 (文本)
    "askforleave": "0" # 是否请假外出? (0->是, 1->否)
}
```
### 上报信息

完整的指令如下：

```shell
# 立刻填报疫情通
python3 upload.py -u xxx -p xxxxx -l home -t y -f data/yiqingtong.json -n
# 立刻填报晨午检
python3 upload.py -u xxx -p xxxxx -l home -t c -f data/chenwujian.json -n
# 定时填报疫情通
python3 upload.py -u xxx -p xxxxx -l home -t y -f data/yiqingtong.json
# 定时填报晨午检
python3 upload.py -u xxx -p xxxxx -l home -t c -f data/chenwujian.json
```


参数详解：

```
usage: upload.py [-h] [-u USERNAME] [-p PASSWORD] [-l LOCATION] [-c COOKIE]
                 [-f MESSAGE_FILE] [-n] [-t TYPE]

optional arguments:
  -h, --help            show this help message and exit
  -u USERNAME, --username USERNAME
                        Student Account Username
  -p PASSWORD, --password PASSWORD
                        Student Account Password
  -l LOCATION, --location LOCATION
                        GPS location, home for home address, s for south
                        school, n for north school, default is home
  -c COOKIE, --cookie COOKIE
                        Path to the Cookie file
  -f MESSAGE_FILE, --message_file MESSAGE_FILE
                        Path to the Upload message file
  -n, --now             Update Yiqingtong Right now
  -t TYPE, --type TYPE  y for yiqingtong, c for chenwujian
```

上报信息有2种方式: 
* 通过学号和密码提交信息, 系统会自动保存cookie到本地，下一次可以通过cookie上传信息 
* 凭借已经登录后的cookie提交信息(cookie的优先级大于学号密码)
> **脚本自身不记录任何学号和密码信息**

>    可使用start.bat按照引导进行操作，**使用疫情通之前请修改utils里home的定位信息**
