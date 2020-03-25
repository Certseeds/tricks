<!--
 * @Github: https://github.com/Certseeds/tricks
 * @Organization: SUSTech
 * @Author: nanoseeds
 * @Date: 2020-03-25 10:01:18
 * @LastEditors: nanoseeds
 * @LastEditTime: 2020-03-25 10:14:44
 -->'
## windows
1. 使用Github desktop 自带的git.exe,  
    地址在`~\AppData\Local\GitHubDesktop\${version}\resources\app\git\cmd\git.exe`,加入环境变量中.
2. 生成公钥私钥的时候,命名特殊一些.比如`id_rsa_GitHub_laptop`等
``` SSH congfig
Host github.com
    User git
    HostName github.com
    port 22
    IdentityFile ~/.ssh/${file_name}
    
Host ssh.github.com
    User git
    Port 443
    Hostname ssh.github.com
    IdentityFile ~/.ssh/${file_name}
    TCPKeepAlive yes
    ProxyCommand connect socks5://127.0.0.1:1080 %h %p
```
3. 配置好ssh config文件后,不需要管理ssh-add,建议重启一下,开机后直接使用即可.
4. Update 1:似乎上述ssh代理没用,还是得开全局.