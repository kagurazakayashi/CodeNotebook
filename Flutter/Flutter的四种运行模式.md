Flutter有四种运行模式：Debug、Release、Profile和test，这四种模式在build的时候是完全独立的。

# Debug
Debug模式可以在真机和模拟器上同时运行：会打开所有的断言，包括debugging信息、debugger aids（比如observatory）和服务扩展。优化了快速develop/run循环，但是没有优化执行速度、二进制大小和部署。命令`flutter run`就是以这种模式运行的，通过`sky/tools/gn --android`或者`sky/tools/gn --ios`来build。有时候也被叫做“checked模式”或者“slow模式”。

# Release
Release模式只能在真机上运行，不能在模拟器上运行：会关闭所有断言和debugging信息，关闭所有debugger工具。优化了快速启动、快速执行和减小包体积。禁用所有的debugging aids和服务扩展。这个模式是为了部署给最终的用户使用。命令`flutter run --release`就是以这种模式运行的，通过`sky/tools/gn --android --runtime-mode=release`或者`sky/tools/gn --ios --runtime-mode=release`来build。

# Profile
Profile模式只能在真机上运行，不能在模拟器上运行：基本和Release模式一致，除了启用了服务扩展和tracing，以及一些为了最低限度支持tracing运行的东西（比如可以连接observatory到进程）。命令`flutter run --profile`就是以这种模式运行的，通过`sky/tools/gn --android --runtime-mode=profile`或者`sky/tools/gn --ios --runtime-mode=profile`来build。因为模拟器不能代表真实场景，所以不能在模拟器上运行。

# test
headless test模式只能在桌面上运行：基本和Debug模式一致，除了是headless的而且你能在桌面运行。命令`flutter test`就是以这种模式运行的，通过`sky/tools/gn`来build。

在我们实际开发中，应该用到上面所说的四种模式又各自分为两种：一种是未优化的模式，供开发人员调试使用；一种是优化过的模式，供最终的开发人员使用。默认情况下是未优化模式，如果要开启优化模式，build的时候在命令行后面添加--unoptimized参数。

https://www.jianshu.com/p/4db65478aaa3