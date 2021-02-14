## Запуск приложения

Для установки всех нужных пакетов

```
git clone https://github.com/Microsoft/vcpkg
cd vcpkg
powershell -exec bypass scripts\bootstrap.ps1
vcpkg integrate install
vcpkg install glfw:x86-windows-static glfw:x64-windows-static glad:x86-windows-static glad:x64-windows-static opengl:x86-windows-static opengl:x64-windows-static
```