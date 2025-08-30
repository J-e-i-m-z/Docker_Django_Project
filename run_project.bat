@echo off
REM ============================
REM Script: run_project.bat
REM Purpose: Run Django setup and server
REM ============================

echo Running Django migrations...
py manage.py makemigrations
py manage.py migrate

echo Starting Django development server...
py manage.py runserver

pause

