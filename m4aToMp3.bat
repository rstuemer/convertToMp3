@echo off


if not exist %CD%\output mkdir %CD%\output

setlocal enableextensions enabledelayedexpansion
set /a fileNum = 1
for  %%i in (.\*)DO @(
	::echo !fileNum!
	set /a fileNum += 1
	
)

echo !fileNum!
Set "Pattern= (192kbit_AAC)"
Set "Replace="


set /a count = 0
for  %%i in (.\*)DO @(
	echo !count!/ !fileNum!
	SET filenameWithoutExt= %%~ni
	SET "clearFilename=!filenameWithoutExt:%Pattern%=%Replace%!"
	SET outputFile="output\\!clearFilename!.mp3" 
	echo !outputFile! .
	@ffmpeg -i "%%i" -loglevel 16  -id3v2_version 3 -write_id3v1 1 -acodec libmp3lame -ab 256k  !outputFile!
	
	::
	set /a count += 1
)

endlocal
	::forfiles /P %CD% /C "cmd /c ffmpeg -i "@file" -acodec libmp3lame -ab 256k  output\\@fname.mp3"