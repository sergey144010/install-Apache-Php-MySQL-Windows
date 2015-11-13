@echo off
cd c:\

set SERVER_DIR=c:\serverTEST

set WEB_DIR=%SERVER_DIR%\web
set DOMAINS_DIR=%SERVER_DIR%\domains

echo Create Dir - %SERVER_DIR%
mkdir %SERVER_DIR%
echo Create Dir - %WEB_DIR%
mkdir %WEB_DIR%
echo Create Dir - %DOMAINS_DIR%
mkdir %DOMAINS_DIR%

echo Create SubDir

mkdir %WEB_DIR%\apache
mkdir %WEB_DIR%\php
mkdir %WEB_DIR%\mysql

mkdir %DOMAINS_DIR%\localhost
mkdir %DOMAINS_DIR%\localhost\public_html
mkdir %DOMAINS_DIR%\localhost\logs

pause