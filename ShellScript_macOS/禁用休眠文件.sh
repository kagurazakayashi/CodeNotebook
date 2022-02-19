# 禁止休眠 sleepimage 文件
sudo pmset -a hibernatemode 0  
sudo pmset -a autopoweroff 0  
sudo pmset -a standby 0  
sudo rm /var/vm/sleepimage
# 不会再生成内存镜像文件了，当然你的电脑就无法再进入深度睡眠模式，Apple 官方说电池待机能力可能会稍稍降低

# 查询所有电源参数
pmset -g custom
# lidwake: 当屏幕掀开的时候唤醒Mac，1是开启  0是关闭
# autopoweroff: 如果Mac处于睡眠状态经过指定的时间后，自动把内存数据写入硬盘，并切断所有部件的电源，进入休眠状态，1是开启  0是关闭。但是LZ发现就算是处于开启状态，这个功能也并没有起作用，你可以不管它，也可以关掉
# autopoweroffdelay:启用autopoweroff功能的时间，也就是上面说的那个“指定的时间”，单位是秒
# standby:功能跟autopoweroff一样，不过仅在hibernatemode为3的时候起作用，1是开启 0是关闭。不过LZ一直没搞明白autopoweroff跟standby有什么不一样，按理说应该是不一样的
# standbydelay:启用standby功能的时间，单位也是秒
# ttyskeepawake:远程用户正在活动时防止Mac进入睡眠，1是开启  0是关闭
# hibernatemode:睡眠模式
# darkwakes:这个就是Power Nap，你可以在系统偏好设置里选择开或关，跟在这里设置是一样的，1是开启  0是关闭
# hibernatefile:内存镜像存放的地址，这个也可以更改，不过路径必需是root下的路径
# displaysleep:Mac闲置多长时间后进入显示器睡眠，2013款Air的系统偏好设置里已经没有这个选项了，Pro是有的，不过其实你可以通过pmset来修改。单位是分钟，这个时间不能长于sleep下设置的时间
# sleep:Mac闲置多长时间后进入睡眠，这个系统偏好设置里也有，单位是分钟
# acwake:电源改变时唤醒，也就是插上或者拔掉外置电源时唤醒Mac，1是开启  0是关闭
# halfdim:显示器睡眠时使显示器亮度改变为当前亮度的一半，1是开启  0是关闭。如果关闭这个功能的话，显示器睡眠会直接关掉显示器。
# lessbright:使用电池时使显示器亮度暗一点，系统偏好设置里也有这个，1是开启  0是关闭
# disksleep:Mac闲置多长时间后关闭硬盘。这个系统偏好里也有，只不过换了一个字眼—如果可能，使硬盘进入睡眠—勾上这个的话系统就会自动根据sleep的时间设一个合适的时间。单位是秒，这个时间不能长于sleep下设置的时间
# sleepservice:LZ还没搞清楚这个是干嘛的，请知道的锋友解释下。
# womp:网络远程唤醒，1是开启  0是关闭
# networksleep:这个设置影响Mac在睡眠的过程中如何提供网络共享服务，LZ也不太清楚是什么，最好就不要动。


# https://www.cnblogs.com/motoyang/p/6075609.html