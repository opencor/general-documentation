@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION

IF "%1" == "libOpenCOR" (
    SET Mode=%1
) ELSE IF "%1" == "OpenCOR" (
    SET Mode=%1
) ELSE IF NOT "%1" == "" (
    ECHO Usage: %0 [libOpenCOR^|OpenCOR]

    EXIT /B 1
)

FOR %%X IN (ninja.exe) DO (
    SET NinjaFound=%%~$PATH:X
)

IF DEFINED NinjaFound (
    SET Generator=Ninja
) ELSE (
    SET Generator=JOM
)

TITLE Making the general documentation for [lib]OpenCOR (using !Generator!)...

IF NOT DEFINED NinjaFound (
    IF EXIST "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat" (
        CALL "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
    ) ELSE (
        CALL "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
    )
)

CD build

IF DEFINED NinjaFound (
    SET CMakeGenerator=Ninja
) ELSE (
    SET CMakeGenerator=NMake Makefiles
)

cmake -G "!CMakeGenerator!" -DMODE=!Mode! ..

SET ExitCode=!ERRORLEVEL!

IF !ExitCode! EQU 0 (
    FOR /F "TOKENS=1,* DELIMS= " %%X IN ("%*") DO (
        SET Args=%%Y
    )

    IF DEFINED NinjaFound (
        ninja !Args!

        SET ExitCode=!ERRORLEVEL!
    ) ELSE (
        nmake /f Makefile !Args!

        SET ExitCode=!ERRORLEVEL!
    )
)

CD ..

EXIT /B !ExitCode!
