@echo off
cd c:\

goto comment1
-----------------
:: Внимательно Устанавливаем SERVER_DIR
:: Правильно - SERVER_DIR=c:\serverTEST
:: Не правильно - SERVER_DIR = c:\serverTEST
-----------------
:comment1

set SERVER_DIR=c:\server
:exist_server_dir
if exist "%SERVER_DIR%" (
    goto end
) else (
    goto begin
)

:end
echo Already exists %SERVER_DIR%. Set the other value variable SERVER_DIR.
echo Example SERVER_DIR 1. c:\server (or simple) 2. server
set /p SERVER_DIR="SERVER_DIR: "
goto exist_server_dir
exit

:begin
set WEB_DIR=%SERVER_DIR%\web
set DOMAINS_DIR=%SERVER_DIR%\domains

mkdir %SERVER_DIR%
mkdir %WEB_DIR%
mkdir %DOMAINS_DIR%
echo Create Dir - %SERVER_DIR%
echo Create Dir - %WEB_DIR%
echo Create Dir - %DOMAINS_DIR%

mkdir %WEB_DIR%\apache
mkdir %WEB_DIR%\php
mkdir %WEB_DIR%\php\tmp
mkdir %WEB_DIR%\php\upload
mkdir %WEB_DIR%\mysql
echo Create Dir - %WEB_DIR%\apache
echo Create Dir - %WEB_DIR%\php
echo Create Dir - %WEB_DIR%\php\tmp
echo Create Dir - %WEB_DIR%\php\upload
echo Create Dir - %WEB_DIR%\mysql

mkdir %DOMAINS_DIR%\localhost
mkdir %DOMAINS_DIR%\localhost\public_html
mkdir %DOMAINS_DIR%\localhost\logs
echo Create Dir - %DOMAINS_DIR%\localhost
echo Create Dir - %DOMAINS_DIR%\localhost\public_html
echo Create Dir - %DOMAINS_DIR%\localhost\logs

mkdir %DOMAINS_DIR%\phpmyadmin
mkdir %DOMAINS_DIR%\phpmyadmin\public_html
mkdir %DOMAINS_DIR%\phpmyadmin\logs
echo Create Dir - %DOMAINS_DIR%\phpmyadmin
echo Create Dir - %DOMAINS_DIR%\phpmyadmin\public_html
echo Create Dir - %DOMAINS_DIR%\phpmyadmin\logs

pause
exit