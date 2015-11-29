@echo off
set INSTALL_DIR=%CD%
:: Директория сервера по умолчанию
set SERVER_DIR=c:\server

cd c:\
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

:begin
set WEB_DIR=%SERVER_DIR%\web
set DOMAINS_DIR=%SERVER_DIR%\domains
set APACHE_DIR=%WEB_DIR%\apache
set PHP_DIR=%WEB_DIR%\php
set MYSQL_DIR=%WEB_DIR%\mysql

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


:: Search Apache for copy
:search_apache
if exist "%INSTALL_DIR%\apache" (
	echo In local directory find APACHE directory, copy this?
	goto copy_apache_yno
) else (
	goto search_php
)
:copy_apache_yno
echo Y - yes, N - No, O - install from other directory
choice /T 10 /C YNO /D y
if ERRORLEVEL 3 ( goto copy_apache_from_other_dir )
if ERRORLEVEL 2 ( goto search_php )
if ERRORLEVEL 1 ( 
	xcopy "%INSTALL_DIR%\apache" "%APACHE_DIR%" /S /E /H
	set APACHE_TO_DIR=%APACHE_DIR%
	goto copy_conf
)
goto next1
:copy_apache_from_other_dir
echo Copy Apache from local directory or not?
choice
if ERRORLEVEL 2 ( set /p APACHE_FROM_DIR="Set full FROM directory: " )
if ERRORLEVEL 1 ( goto apache_set_from_dir )
goto next11
:apache_set_from_dir
set /p APACHE_LOCAL_DIR="Local directory: "
set APACHE_FROM_DIR=%INSTALL_DIR%\%APACHE_LOCAL_DIR%
:next11
echo Copy Apache to default directory or not?
choice /T 10 /C YN /D y
if ERRORLEVEL 2 ( set /p APACHE_TO_DIR="Set full TO directory: " )
if ERRORLEVEL 1 ( set APACHE_TO_DIR=%APACHE_DIR% )
xcopy "%APACHE_FROM_DIR%" "%APACHE_TO_DIR%" /S /E /H
:copy_conf
if exist "%INSTALL_DIR%\conf\httpd.conf" (
	echo In local directory find CONF directory and find httpd.conf file, copy this in %APACHE_TO_DIR%\conf ?
	goto copy_apache_conf
) else (
	goto search_php
)
goto next12
:copy_apache_conf
choice /T 10 /C YN /D y
if ERRORLEVEL 2 ( goto next12 )
if ERRORLEVEL 1 (
	xcopy "%INSTALL_DIR%\conf\httpd.conf" "%APACHE_TO_DIR%\conf" /Y
	xcopy "%INSTALL_DIR%\conf\extra\httpd-autoindex.conf" "%APACHE_TO_DIR%\conf\extra" /Y
	xcopy "%INSTALL_DIR%\conf\extra\httpd-manual.conf" "%APACHE_TO_DIR%\conf\extra" /Y
	xcopy "%INSTALL_DIR%\conf\extra\httpd-mpm.conf" "%APACHE_TO_DIR%\conf\extra" /Y
	xcopy "%INSTALL_DIR%\conf\extra\httpd-vhosts.conf" "%APACHE_TO_DIR%\conf\extra" /Y
)
:next12
:next1

:search_php
:: Search Php for copy
if exist "%INSTALL_DIR%\php" (
	echo In local directory find PHP directory, copy this?
	goto copy_php_yno
) else (
	goto next_step_2
)
:copy_php_yno
echo Y - yes, N - No, O - install from other directory
choice /T 10 /C YNO /D y
if ERRORLEVEL 3 ( goto copy_php_from_other_dir )
if ERRORLEVEL 2 ( goto next_step_2 )
if ERRORLEVEL 1 ( 
	xcopy "%INSTALL_DIR%\php" "%PHP_DIR%" /S /E /H
	set PHP_TO_DIR=%PHP_DIR%
	goto copy_php_conf_begin
)
goto next2
:copy_php_from_other_dir
echo Copy Php from local directory or not?
choice
if ERRORLEVEL 2 ( set /p PHP_FROM_DIR="Set full FROM directory: " )
if ERRORLEVEL 1 ( goto php_set_from_dir )
goto next21
:php_set_from_dir
set /p PHP_LOCAL_DIR="Local directory: "
set PHP_FROM_DIR=%INSTALL_DIR%\%PHP_LOCAL_DIR%
:next21
echo Copy Php to default directory or not?
choice /T 10 /C YN /D y
if ERRORLEVEL 2 ( set /p PHP_TO_DIR="Set full TO directory: " )
if ERRORLEVEL 1 ( set PHP_TO_DIR=%PHP_DIR% )
xcopy "%PHP_FROM_DIR%" "%PHP_TO_DIR%" /S /E /H

:copy_php_conf_begin
if exist "%INSTALL_DIR%\conf\php.ini" (
	echo In local directory find CONF directory and find php.ini file, copy this in %PHP_TO_DIR% ?
	goto copy_php_conf
) else (
	goto next_step_2
)
goto next22
:copy_php_conf
choice /T 10 /C YN /D y
if ERRORLEVEL 2 ( goto next22 )
if ERRORLEVEL 1 ( xcopy "%INSTALL_DIR%\conf\php.ini" "%PHP_TO_DIR%")
:next22
:next2


:next_step_2
echo Install is finished
pause
exit