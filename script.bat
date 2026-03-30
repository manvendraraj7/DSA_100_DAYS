@echo off
setlocal enabledelayedexpansion

set START=2026-02-01
set END=2026-03-30

:: Correct way to redirect output
powershell -NoProfile -Command "$s=Get-Date '%START%'; $e=Get-Date '%END%'; while($s -le $e){$s.ToString('yyyy-MM-dd'); $s=$s.AddDays(1)}" > dates.txt

for /f %%d in (dates.txt) do (

    set DATE=%%d
    set /a COUNT=!random! %% 5 + 1

    for /l %%i in (1,1,!COUNT!) do (

        set /a HH=!random! %% 24
        set /a MM=!random! %% 60
        set /a SS=!random! %% 60

        set DATETIME=!DATE! !HH!:!MM!:!SS!

        echo Commit !DATETIME! >> dummy.txt

        git add dummy.txt

        set "GIT_AUTHOR_DATE=!DATETIME!"
        set "GIT_COMMITTER_DATE=!DATETIME!"

        git commit -m "Auto commit !DATETIME!"
    )
)

del dates.txt

echo Done
pause