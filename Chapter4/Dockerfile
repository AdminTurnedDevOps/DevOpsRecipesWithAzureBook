FROM mcr.microsoft.com/windows/servercore:ltsc2019

MAINTAINER Michael Levan

LABEL Type="powershellimage"

RUN powershell -Command Install-WindowsFeature -Name Web-Server
RUN powershell New-Item -Type Directory -Path C:\ -Name PoshCode