cmake -G "Visual Studio 16 2019" -A x64 -S . -Bbuild/windows
cmake --build build/windows --config Release
cd .\build\windows 
# cpack
#cmake --build . --config Release
cpack -C Release