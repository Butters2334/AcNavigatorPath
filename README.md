## 功能介绍
	Xcode并不支持实现显示当前编辑文件在项目中的位置,有时候虽然很容易就找到文件但在查找文件在项目中路径上面需要花费不少时间,简单的写了个插件来实现功能,1.0版本Bug较多,见谅;

## 安装插件
	在Xcode中打开AcNavigatorPath.xcodeproj,编译(Command+B)后重启Xcode即可
	
## 调试
	重启后AcPathDemo/AcPathDemo.xcodeproj项目,找到ViewController.m,使用command+鼠标左键进入class5的文件,按下'F5',看看左边项目路径是否选中了class5
	调试-1 : 打开Demo-ViewController.m
	![image](https://raw.githubusercontent.com/anmac/AcNavigatorPath/master/DemoScreenshot/DemoScreenshot1.jpg)
	调试-2 : command+左键进入Class5,侧边栏正常情况并没有显示Class5的位置
	![image](https://raw.githubusercontent.com/anmac/AcNavigatorPath/master/DemoScreenshot/DemoScreenshot2.jpg)
	调试-3 : 按'F5' ,侧边栏会选中Class5的位置
	![image](https://raw.githubusercontent.com/anmac/AcNavigatorPath/master/DemoScreenshot/DemoScreenshot3.jpg)


## 删除插件
  删除以下路径的文件:

  `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/AcNavigatorPath.xcplugin`