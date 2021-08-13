@echo off

rem @auther wanzzhehe
rem @date 2021-08-12
rem @email wanzzmicro@outlook.com

chcp 65001
cls

set CHENWUJIAN=1
set YIQINGTONG=2

set WORKDIR=%~dp0
cd /d %WORKDIR%

:START
echo 1. 晨午晚检
echo 2. 疫情通

set /p MOD="请输入填报项目[1,2]: "

if not "%MOD%" == "1" (
    if not "%MOD%" == "2" (
        cls
        goto START
    )
)

if not exist data\cookie.txt (
    goto WITHPW
) else (
    goto WITHCO
)

:WITHPW

echo 未检测到Cookie文件，将使用用户名密码登

echo 用户名密码为统一身份认证的学号和密码

set /p uname="用户名: "
set /p upass="密码: "
if "%MOD%" == "%CHENWUJIAN%" set /p location="现在所在校区[南校区填s/北校区填n]: "
set /p now="是否立即填报[y/N]: "

if "%now%" == "y" set now=Y
if not "%now%" == "Y" set now=N

if "%now%" == "Y" (
    if "%MOD%" == "%CHENWUJIAN%" python .\upload.py -u %uname% -p %upass% -f .\data\chenwujian.json -t c -n -l %location%
    if "%MOD%" == "%YIQINGTONG%" python .\upload.py -u %uname% -p %upass% -f .\data\yiqingtong.json -t y -n
) else (
    if "%MOD%" == "%CHENWUJIAN%" python .\upload.py -u %uname% -p %upass% -f .\data\chenwujian.json -t c -l %location%
    if "%MOD%" == "%YIQINGTONG%" python .\upload.py -u %uname% -p %upass% -f .\data\yiqingtong.json -t y
)

pause
exit

:WITHCO

echo 检测到Cookie文件，将使用Cookie进行登录

if "%MOD%" == "%CHENWUJIAN%" set /p location="现在所在校区[南校区填s/北校区填n]: "
set /p now="是否立即填报[y/N]: "

if "%now%" == "y" set now=Y
if not "%now%" == "Y" set now=N

if "%now%" == "Y" (
    if "%MOD%" == "%CHENWUJIAN%" python .\upload.py -c .\data\cookie.txt -f .\data\chenwujian.json -t c -n -l %location%
    if "%MOD%" == "%YIQINGTONG%" python .\upload.py -c .\data\cookie.txt -f .\data\yiqingtong.json -t y -n
) else (
    if "%MOD%" == "%CHENWUJIAN%" python .\upload.py -c .\data\cookie.txt -f .\data\chenwujian.json -t c -l %location%
    if "%MOD%" == "%YIQINGTONG%" python .\upload.py -c .\data\cookie.txt -f .\data\yiqingtong.json -t y
)

pause
exit
