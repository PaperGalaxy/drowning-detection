@echo off
title 澜盾智援 - 本地服务器
echo ========================================
echo   澜盾智援 水域防溺水预警系统
echo ========================================
echo.
echo 正在启动本地HTTP服务器 (端口 8080)...
echo.

:: 后台启动 Python HTTP 服务器
start /b python -m http.server 8080

:: 等待2秒确保服务器启动
timeout /t 2 /nobreak >nul

:: 打开默认浏览器
start http://localhost:8080

echo.
echo 服务器已启动，浏览器将打开 http://localhost:8080
echo 请确保已允许摄像头权限。
echo.
echo 按任意键停止服务器并退出...
pause >nul

:: 关闭 Python 进程
taskkill /f /im python.exe >nul 2>&1
echo 服务器已停止。
exit