@echo off
if NOT exist .venv\ (
  python -m venv .venv
  call .venv\scripts\activate.bat
  pip install -r requirements.txt
)