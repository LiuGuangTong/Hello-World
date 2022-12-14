@echo off

setlocal enabledelayedexpansion

rem Get a list of all IP addresses and domain names that the system has connected to recently
netstat -ano | findstr "ESTABLISHED" > connections.txt

rem Parse the connections.txt file and extract only the IP addresses and domain names
for /f "tokens=2 delims=:" %%a in (connections.txt) do (
    set IP=%%a
    set IP=!IP:~0,-5!

    rem Check if the IP address or domain name is in the known malicious list
    type known_malicious.txt | find /i "!IP!" > nul
    if !errorlevel!==0 (
        echo !IP! is a known malicious IP or domain name
    )
)

endlocal