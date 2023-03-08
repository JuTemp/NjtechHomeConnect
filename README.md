这个项目结束于2023Mar08，基于bash平台。

你需要将这两个文件放在同一个目录，<br>
修改login.bash文件前几行，输入账号和密码，选择中国电信或中国移动（只保留对应运营商并删除另一个），<br>
然后执行以下命令：

```
$ cd $DIR
$ bash login.bash
```

如果这个脚本成功执行，它将输出类似于以下结果：

```
F28D34EA658A1607295773FFC3D62146.TomcatB 67313298 LT-2084105-CAIhK5iXslhnkqzgD3qBrNStfp0BtM e1s1 6296 ea0335137fc3c281aaa639a970678571b4224e7e
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

如果不能成功执行，请联系我。

----JuTemp 2023Feb16

