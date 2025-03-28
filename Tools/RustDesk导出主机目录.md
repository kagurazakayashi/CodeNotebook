# RustDesk导出主机目录 RustDesk导出设备列表

RustDesk 的设备列表保存在本地配置文件中，可以手动备份这些文件以导出设备列表。

- **Windows：** 设备列表存储在 `%APPDATA%\RustDesk\config\peers` 目录下。可以将该目录下的 `.toml` 文件复制并保存，以备份设备列表。

- **macOS：** 设备列表位于 `/Users/你的用户名/Library/Preferences/com.carriez.RustDesk/peers/` 目录下。将此目录中的 `.toml` 文件复制并保存即可。

- **Linux：** 设备列表存储在 `~/.config/rustdesk/peers/` 目录下。同样，复制并保存其中的 `.toml` 文件即可备份设备列表。

要在另一台设备上恢复设备列表，只需将备份的 `.toml` 文件复制到对应的目录中即可。
