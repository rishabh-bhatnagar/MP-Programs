rem this file will only build the exe

rem %1 = filename, only filename, no extension
rem eg: 4A, 3A_SQUARE

rem %2 = flags for tasm
rem eg: /z for line-by-line debug

rem %3 = flags for tlink
rem eg: /v for line-by-line debug

cls
echo off
tasm %1 %2
if errorlevel 1 goto end
tlink %1 %3
:end
