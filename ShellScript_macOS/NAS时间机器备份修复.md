第一步，你要确保自己按照群晖官网的 说明，正确地完成 NAS 端的配置。如果没有，请根据文中的步骤，一步一步做下去，等到在 NAS 后台中的配置完成，停住，然后可以跳过第二步。

第二步，如果你已经在电脑上进行了 Time Machine 备份尝试并收到了报错提醒，那么你可以在 NAS 相应的文件夹里看到一个 `sparsebundle` 文件，不管它叫什么名字，删除掉，确保这个文件夹里除了回收站没有其它文件 / 子文件夹。

第三步，打开「系统偏好设置-共享」，点击「编辑」按钮，然后复制你的本地主机名（不需要 `.local` 字符）。

第四步，打开终端 app，输入命令 `ifconfig en0 | grep ether | awk '{print $2}' | sed 's/://g'` ，敲击回车键，你就可以得到电脑的 MAC 地址，记下来。

第五步，继续在终端 app 中输入命令 `sudo hdiutil create -size 320g -type SPARSEBUNDLE -nospotlight -volname "Backup of <computer_name>" -fs "Case-sensitive Journaled HFS+" -verbose ~/Desktop/<computer_name>_<mac address>.sparsebundle` ，其中 `<computer_name>` 替换为第三步中获得的本地主机名， `<mac address>` 替换为第四步中获得的 MAC 地址，敲击回车键，输入密码，稍等一下，你的桌面上就会生成一个正确的 sparsebundle 文件。

第六步，打开访达 app，使用快捷键 ⌘Command+K 来连接到服务器，填入 NAS 对应的 SMB 地址，并输入 Time Machine 专属账户的用户名和密码。等待成功挂载 Time Machine 共享文件夹后，将桌面上的 sparsebundle 文件复制到这个文件夹中。在这一步中，千万要记住要通过访达 app 来上传文件，而不能在 NAS 后台上传。

第七步，等待上传完毕后，重新打开「系统偏好设置-时间机器」来进行接下去正常的流程操作。

https://sspai.com/post/58100