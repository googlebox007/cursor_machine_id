# Cursor Device ID Changer

这是一个简单的脚本工具，用于修改 Cursor 编辑器的设备 ID。当因频繁切换账号导致设备被锁定时，可以使用此脚本重置设备 ID。

## 功能特点

- 自动生成新的随机设备 ID
- 自动备份原配置文件
- 支持自定义设备 ID
- 无需额外依赖，使用系统内置工具

## Mac系统使用方法

1. 下载 `change_id.sh` 脚本
2. 给脚本添加执行权限：

```base
chmod +x change_id.sh
```

3. 运行脚本：

```bash
使用随机生成的设备 ID
./change_id.sh
或者使用自定义设备 ID
./change_id.sh your_custom_id
```
## Windows10系统使用方法

1. 下载 `update_cursor_id.ps1` 脚本
2. 给脚本添加执行权限：

```powershell
update_cursor_id.ps1
```

3. 运行脚本：

```bash
使用随机生成的设备 ID
./update_cursor_id.ps1
或者使用自定义设备 ID
./update_cursor_id.ps1 your_custom_id
```

## 注意事项

- 脚本会在修改前自动创建配置文件的备份
- 备份文件保存在原配置文件相同目录下，格式为 `storage.json.backup_时间戳`
- 请确保在运行脚本前关闭 Cursor 编辑器
- 支持 macOS 系统
- 支持 Windows10系统

## 配置文件位置

默认配置文件路径：
```
"~/Library/Application Support/Cursor/User/globalStorage/storage.json"
```


## 免责声明

本脚本仅供学习和研究使用，使用本脚本可能违反 Cursor 的服务条款。请合理使用，风险自负。
