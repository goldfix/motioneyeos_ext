@echo off

c:\Python3\python.exe -m venv --copies --clear ./py-env 
call .\py-env\Scripts\activate
pip install -r requirements.txt
