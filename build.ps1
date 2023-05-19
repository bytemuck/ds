mkdir build
7z a build.zip *.lua -r
7z a build.zip "assets\"
cmd /c copy /b "$env:LOVE\love.exe+build.zip" "build\ds.exe"
Copy-Item "$env:LOVE\*.dll" "build/"
Copy-Item "$env:LOVE\license.txt" "build/"
rm build.zip
