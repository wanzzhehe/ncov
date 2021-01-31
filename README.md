# 西安电子科技大学晨午晚检自动填报工具

1月31日更新说明：
1. 更新了家里的填报信息
2. 原来只有晨午检的信息，现在加入了疫情通的填报，用`-t y`来填报疫情通，`-t c`来填报晨午检。

相比@anadfox233的版本添加了定时自动填报的功能，添加了南校区的位置信息，改了几个小bug

## 注意
本脚本内置了南校区和北校区的经纬度,**默认定位为南校区**

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
   
`python3 upload.py -u xxx -p xxxxx -l home -t y  -f data/yiqingtong.json -n 1`
   
参数详解：
   
```
usage: upload.py [-h] [-u USERNAME] [-p PASSWORD] [-l LOCATION] [-c COOKIE] [-f MESSAGE_FILE] [-n NOW]
                 [-t TYPE]

optional arguments:
  -h, --help            show this help message and exit
  -u USERNAME, --username USERNAME
                        Student Account Username
  -p PASSWORD, --password PASSWORD
                        Student Account Password
  -l LOCATION, --location LOCATION 
                        GPS location, 现在内置了三个位置，-l home是填报我家的位置，-l n代表北校区的位置，-l s代表南校区的位置
  -c COOKIE, --cookie COOKIE
                        Path to the Cookie file
  -f MESSAGE_FILE, --message_file MESSAGE_FILE
                        Path to the Upload message file
  -n NOW, --now NOW     -n 1代表立即填报，-n 0代表启动定时任务进行填报
  -t TYPE, --type TYPE  y for 疫情通, c for 晨午检
```

默认情况下进行定时填报，但如果需要立即进行填报，请加入`-n 1`参数，例如：
```shell script
python upload.py -n 1 -c cookie路径 -l n -f 上报信息的文件路径 -t
```

上报信息有2种方式: 
* 通过学号和密码提交信息, 系统会自动保存cookie到本地，下一次可以通过cookie上传信息 
* 凭借已经登录后的cookie提交信息(cookie的优先级大于学号密码)
> **脚本自身不记录任何学号和密码信息**

### 学号密码上报

```shell script
python upload.py -u 学号 -p 密码 -f 上报信息的文件路径
```

在不指定`-l`参数时默认上报南校区的GPS位置。

如需指定北校区，请添加`-l n`(north)，即以下命令

```shell script
python upload.py -u 学号 -p 密码 -l n -f 上报信息的文件路径
```

### cookie上报
```shell script
python upload.py -c cookie路径 -f 上报信息的文件路径
```

在不指定`-l`参数时默认上报南校区的GPS位置。

如需指定北校区，请添加`-l n`(north)，即以下命令

```shell script
python upload.py -c cookie路径 -l n -f 上报信息的文件路径
```

## 示例

### 用户名上报

![用户名上报](https://ning-wang.oss-cn-beijing.aliyuncs.com/blog-imags/用户名上报.gif)

### cookie上报

![cookie上报](https://ning-wang.oss-cn-beijing.aliyuncs.com/blog-imags/cookie上报.gif)
