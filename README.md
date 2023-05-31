这个项目结束于2023May31，基于shell平台。

你需要将这两个文件放在同一个目录，<br>
修改login.sh文件前几行，输入账号和密码，选择中国电信或中国移动（只保留对应运营商并删除另一个），<br>
然后执行以下命令：

```
$ cd $DIR
$ sudo chmod +x login.sh
$ ./login.sh
```

如果这个脚本成功执行，它将输出类似于以下结果：

```
32F08A6E7E93F6B63A33519AA349EFBB.TomcatB 67313298 LT-21537498-hxwl3jKW73t0Rg6HAcCEkZDXW0DJ2I e1s1 7242 9c84897ccefb11b09b74466df39fcdd498f8ca44
Login Success.
```

然后新增两个文件 "NjtechHomeHtml" 和 "captcha.jpg"，你不需要删除它们。

如果认为RainbowNjtechHomeKeys太大，你可以删去一些行。<br>
不会影响成功登陆，可能会增加登陆时间。建议至少保留2000行。<br>
实测3000行登陆时间不到1s。

可以使用以下命令只保留RainbowNjtechHomeKeys的前3000行，<br>
请注意，以下命令会直接修改RainbowNjtechHomeKeys文件，注意备份：

```
sed -i '3000,$d' RainbowNjtechHomeKeys
```

另外，你可以修改默认账号和密码，使用如下命令：

```
$ ./login.sh 0 202221149100 passwd123789
```

如果不能成功执行，请联系我。

----JuTemp 2023May31

