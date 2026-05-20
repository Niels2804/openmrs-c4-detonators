@echo off

cd /d %~dp0

echo Building module...
call mvn clean install

echo Checking .omod...

if not exist "messagebridge\omod\target\messagebridge-default.omod" (
    echo ERROR: .omod not found!
    exit /b 1
)

echo Copying .omod...

docker cp messagebridge/omod/target/messagebridge-default.omod openmrs-c4-detonators-backend:/openmrs/modules/

echo Restarting backend...
docker compose restart backend

echo Done 🚀