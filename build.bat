@echo off

rem Add path to MSBuild Binaries
set MSBUILD=()
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe" (
    set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe" (
    set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe" (
    set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe" (
    set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe" (
	set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe" (
	set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Preview\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Preview\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%DevSoftwareHome%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%DevSoftwareHome%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%DevSoftwareHome%\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%DevSoftwareHome%\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%DevSoftwareHome%\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" (
    set MSBUILD="%DevSoftwareHome%\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\MSBuild\14.0\bin" (
    set MSBUILD="%ProgramFiles(x86)%\MSBuild\14.0\bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\MSBuild\14.0\bin" (
    set MSBUILD="%ProgramFiles%\MSBuild\14.0\bin\msbuild.exe"
    goto :FOUND_MSBUILD
)

if %MSBUILD%==() (
    echo "I couldn't find MSBuild on your PC. Make sure it's installed somewhere, and if it's not in the above if statements (in build.bat), add it."
    goto :EXIT
) 
:FOUND_MSBUILD
set _MSBUILD_TARGET=Build
set _MSBUILD_CONFIG=Debug
set _MSBUILD_PLATFORM=x64

:ARGS_LOOP
if (%1) == () goto :POST_ARGS_LOOP
if (%1) == (clean) (
    set _MSBUILD_TARGET=Clean,Build
)
if (%1) == (clear) (
    set _MSBUILD_TARGET=Clean

)
if (%1) == (rel) (
    set _MSBUILD_CONFIG=Release
)
if (%1) == (ARM64) (
    set _MSBUILD_PLATFORM=ARM64
)
shift
goto :ARGS_LOOP

:POST_ARGS_LOOP
%MSBUILD% %~dp0\BlackArchWSL.sln /t:%_MSBUILD_TARGET% /m /nr:true /p:Configuration=%_MSBUILD_CONFIG%;Platform=%_MSBUILD_PLATFORM%

@REM %MSBUILD% %~dp0\BlackArchWSL.sln /t:%_MSBUILD_TARGET% /m /nr:false /p:Configuration=%_MSBUILD_CONFIG% /p:AppxBundlePlatforms="x64|ARM64" -verbosity:normal /p:UapAppxPackageBuildMode="StoreUpload" /p:UseSubFolderForOutputDirDuringMultiPlatformBuild=false


if (%ERRORLEVEL%) == (0) (
    echo.
    echo Created appx in %~dp0x64\%_MSBUILD_CONFIG%\DistroLauncher-Appx\
    echo.
)

:EXIT
