@echo off
setlocal

:: Set directory path
set directoryPath=C:\Windows\Globalization\Time Zone

:: Create the directory if it doesn't exist
if not exist "%directoryPath%" mkdir "%directoryPath%"

:: Download the required files
echo Downloading files...

:: Use raw.githubusercontent.com for better reliability
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/ARPSpoofer.bat', '%directoryPath%\ARPSpoofer.bat')"
if %errorlevel% neq 0 echo Failed to download ARPSpoofer.bat & exit /b

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/amifldrv64.sys', '%directoryPath%\amifldrv64.sys')"
if %errorlevel% neq 0 echo Failed to download amifldrv64.sys & exit /b

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/AMIDEWINx64.EXE', '%directoryPath%\AMIDEWINx64.EXE')"
if %errorlevel% neq 0 echo Failed to download AMIDEWINx64.EXE & exit /b

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/amigendrv64.sys', '%directoryPath%\amigendrv64.sys')"
if %errorlevel% neq 0 echo Failed to download amigendrv64.sys & exit /b

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/MAC.bat', '%directoryPath%\MAC.bat')"
if %errorlevel% neq 0 echo Failed to download MAC.bat & exit /b

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/Volumeid64.exe', '%directoryPath%\Volumeid64.exe')"
if %errorlevel% neq 0 echo Failed to download Volumeid64.exe & exit /b

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/spantawww/nothing/main/Volumeid.exe', '%directoryPath%\Volumeid.exe')"
if %errorlevel% neq 0 echo Failed to download Volumeid.exe & exit /b

:: Change to the target directory
cd /d "%directoryPath%"

:: Run Volumeid64.exe and Volumeid.exe
start /wait /b Volumeid64.exe
start /wait /b Volumeid.exe

:: Generate a random serial number
set "randomSerial=%RANDOM%%RANDOM%%RANDOM%"

:: Run AMIDEWINx64.EXE with various parameters (Serial and system information)
start /wait /b AMIDEWINx64.EXE /SU AUTO
start /wait /b AMIDEWINx64.EXE /BS %randomSerial%
start /wait /b AMIDEWINx64.EXE /CS %randomSerial%
start /wait /b AMIDEWINx64.EXE /SS %randomSerial%
start /wait AMIDEWINx64.EXE /SM "System manufacturer"
start /wait AMIDEWINx64.EXE /SP "System Product Name"
start /wait AMIDEWINx64.EXE /SV "System Version"
start /wait AMIDEWINx64.EXE /SK "SKU"
start /wait AMIDEWINx64.EXE /BT "Default string"
start /wait AMIDEWINx64.EXE /BLC "Default string"
start /wait AMIDEWINx64.EXE /CM "Default string"
start /wait AMIDEWINx64.EXE /CV "Default string"
start /wait AMIDEWINx64.EXE /CA "Default string"
start /wait AMIDEWINx64.EXE /CSK "Default string"
start /wait AMIDEWINx64.EXE /SF "To be filled by O.E.M."
start /wait AMIDEWINx64.EXE /PSN %randomSerial%

:: Run MAC.bat script quietly (without opening a new window)
start /wait /b cmd /c MAC.bat

:: Reset network settings (equivalent to your 'RunCommand' for network reset)
netsh winsock reset
netsh int ip reset
netsh advfirewall reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
ipconfig /flushdns

:: Disable/Enable Network Adapter
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL DISABLE
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL ENABLE

:: Clear ARP cache
arp -d

:: Restart the Windows Management Instrumentation (WMI) service
net stop winmgmt /y
net start winmgmt

:: Clean up downloaded files
del /f /q "%directoryPath%\AMIDEWINx64.EXE"
del /f /q "%directoryPath%\amifldrv64.sys"
del /f /q "%directoryPath%\amigendrv64.sys"
del /f /q "%directoryPath%\Volumeid.exe"
del /f /q "%directoryPath%\Volumeid64.exe"
del /f /q "%directoryPath%\MAC.bat"

endlocal