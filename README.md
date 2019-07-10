# flutter_jd
    使用Flutter编写的仿京东商城的部分demo，可参考；

Note：由于是在windows系统上做的开发，所以有些依赖库的IOS配置无法配置，可能会导致在IOS的build中不成功；如遇此情况，请核对相关依赖库并查阅在ios中的配置

#### 工程目录结构介绍
目录|功能说明
---|:-:
./android|Android原生代码工程
ios|IOS原生工程代码
lib|Flutter公共界面/模块代码
lib/page|工程界面代码
lib/route|工程路由配置
lib/util|工程工具类
lib/widget|使用的自定义widget
ppt|存放flutter相关培训PPT
resource|存放项目资源,图片,字体,文件等
test|单元测试代码

#### Dart编码规范
>文件夹和文件命采用小写+下划线连接的方式命名,例如user_login.dart  
>类名采用大写驼峰写法，例如class LoginPage  
>变量命名采用小写驼峰写法，例如userName  
>对于代码层级嵌套，推荐使用模块化开发增加复用，简化代码


#### 另附本人两篇文章以供参考学习
[**Flutter入门-01-工程创建&目录介绍**](https://www.jianshu.com/p/e88c6b2087b3)  
[**Flutter入门-02-Dart语言简讲**](https://www.jianshu.com/p/f700679e2667)