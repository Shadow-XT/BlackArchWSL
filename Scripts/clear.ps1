$directories = @(
    "${PWD}\x64\Debug",
    "${PWD}\x64\Release",
    "${PWD}\ARM64\Debug",
    "${PWD}\ARM64\Release",
    "${PWD}\DistroLauncher\x64\Debug",
    "${PWD}\DistroLauncher\x64\Release",
    "${PWD}\DistroLauncher\ARM64\Debug",
    "${PWD}\DistroLauncher\ARM64\Release",
    "${PWD}\DistroLauncher-Appx\x64\Debug",
    "${PWD}\DistroLauncher-Appx\x64\Release",
    "${PWD}\DistroLauncher-Appx\ARM64\Debug",
    "${PWD}\DistroLauncher-Appx\ARM64\Release"
)

foreach ($dir in $directories) {
    if (Test-Path $dir) {
        Remove-Item -Path $dir -Recurse -Force
    }
}