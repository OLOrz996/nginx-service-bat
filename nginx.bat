@echo off
rem �ṩWindows��nginx���������������رչ���
 
echo ==================begin========================
 
cls 
::ngxin ���ڵ��̷�
set NGINX_PATH=D:
 
::nginx ����Ŀ¼
set NGINX_DIR=D:\Programs\nginx-1.14.2\
color 0a 
TITLE Nginx �������

CLS 
 
echo. 
echo. ** Nginx ��������  *** 
echo. 
 
:MENU 
 
echo. ***** nginx ����list ****** 
::tasklist|findstr /i "nginx.exe"
tasklist /fi "imagename eq nginx.exe"
 
echo. 
 
    if ERRORLEVEL 1 (
        echo nginx.exe������
    ) else (
        echo nginx.exe����
    )
 
echo. 
::*************************************************************************************************************
echo. 
	echo.  [1] ����Nginx  
	echo.  [2] �ر�Nginx  
	echo.  [3] ����Nginx 
	echo.  [4] ˢ�¿���̨  
	echo.  [5] ���¼���Nginx�����ļ�
	echo.  [6] ������nginx�����ļ�
	echo.  [7] �鿴nginx version
	echo.  [8] �򿪴�����־
	echo.  [9] ɾ��������־
	echo.  [0] �� �� 
echo. 
 
echo.������ѡ������:
set /p ID=
	IF "%id%"=="1" GOTO start 
	IF "%id%"=="2" GOTO stop 
	IF "%id%"=="3" GOTO restart 
	IF "%id%"=="4" GOTO MENU
	IF "%id%"=="5" GOTO reloadConf 
	IF "%id%"=="6" GOTO checkConf 
	IF "%id%"=="7" GOTO showVersion 
	IF "%id%"=="8" GOTO openErrorLog
	IF "%id%"=="9" GOTO delErrorLog
	IF "%id%"=="0" EXIT
PAUSE 
 
::*************************************************************************************************************
::����
:start 
	call :startNginx
	GOTO MENU
 
::ֹͣ
:stop 
	call :shutdownNginx
	GOTO MENU
 
::����
:restart 
	call :shutdownNginx
	call :startNginx
	GOTO MENU
 
::�����������ļ�
:checkConf 
	call :checkConfNginx
	GOTO MENU
 
::���¼���Nginx�����ļ�
:reloadConf 
    call :checkConfNginx
	call :reloadConfNginx
	GOTO MENU
	
::��ʾnginx�汾
:showVersion 
    call :showVersionNginx
	GOTO MENU	

::�򿪴�����־
:openErrorLog 
    call :openErrorLogNginx
	GOTO MENU	

::ɾ��������־
:delErrorLog 
    call :delErrorLogNginx
	GOTO MENU
	
::*************************************************************************************
::�ײ�
::*************************************************************************************
:shutdownNginx
	echo. 
	echo.�ر�Nginx...... 
	taskkill /F /IM nginx.exe > nul
	echo.OK,�ر�����nginx ����
	goto :eof
 
:startNginx
	echo. 
	echo.����Nginx...... 
	IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"������
        goto :eof
     )
 
	%NGINX_PATH% 
	cd "%NGINX_DIR%" 
 
	IF EXIST "%NGINX_DIR%nginx.exe" (
		echo "start '' nginx.exe"
		start "" nginx.exe
	)
	echo.OK
	goto :eof
	
 
:checkConfNginx
	echo. 
	echo.������ nginx �����ļ�...... 
	IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"������
        goto :eof
     )
 
	%NGINX_PATH% 
	cd "%NGINX_DIR%" 
	nginx -t -c conf/nginx.conf
 
	goto :eof
	
::���¼��� nginx �����ļ�
:reloadConfNginx
	echo. 
	echo.���¼��� nginx �����ļ�...... 
	IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"������
        goto :eof
     )
 
	%NGINX_PATH% 
	cd "%NGINX_DIR%" 
	nginx -s reload
 
	goto :eof
	
::��ʾnginx�汾
:showVersionNginx
	echo. 
	%NGINX_PATH% 
	cd "%NGINX_DIR%" 
	nginx -V
 	goto :eof

::�򿪴�����־
:openErrorLogNginx
	echo. 
	echo.�򿪴�����־...... 
	%NGINX_PATH% 
	cd "%NGINX_DIR%"  
	start logs/error.log
	goto :eof

::ɾ��������־
:delErrorLogNginx
	echo. 
	echo.ɾ��������־...... 
	%NGINX_PATH% 
	cd "%NGINX_DIR%"  
	del logs\error.log
	goto :eof