@echo off
REM ============================
REM Script: setup_project.bat
REM Purpose: Install Python, pip, and Django dependencies
REM ============================

echo Checking if Python is installed...
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python not found. Installing Python...
    REM You may need to adjust Python installer path if not in Downloads
    REM Download installer first: https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe
    start /wait "" "%USERPROFILE%\Downloads\python-3.10.11-amd64.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_pip=1
) ELSE (
    echo Python is already installed.
)

echo Checking pip...
pip --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Pip not found. Installing pip...
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
)

echo Installing project dependencies...
pip install --upgrade pip
pip install django==3.0.5
pip install django-widget-tweaks
pip install xhtml2pdf

echo Setup complete!
pause

