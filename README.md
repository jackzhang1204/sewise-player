# [Sewise Player](http://player.sewise.com/) : HTML5 Video Player

Support for [jQuery](http://jquery.com/) HTML player skins.

## What is Sewise Player?

### Sewise Player是一款专业的免费网页视频、流播放器，它功能强大，体积小，跨平台，使用方便简洁、随心所欲。
* 播放器是主要以HTML5技术为平台开发，同时兼容flash技术，实现了跨平台各浏览器兼容的视频播放。使用Sewise Player您可以在Windows, MacOS, Linux，Windows Phone, Android, IOS等任意平台上，通过对应的浏览器播放视频。
* Sewise Player使用非常简单，只要在页面对应的DIV内嵌入一个JS文件即可，播放器将通过自动识别浏览器的功能来启用HTML5或flash模式播放视频。你不需要掌握任何专业的JavaScript或ActionScript技术就可以制作出专业的网页视频播放器。
* Sewise Player即可以做为单一的前台播放器来在页面上播放视频，也可以结合Sewise Server后台技术实现专业的可交互的点播、直播视频播放。

### 功能列表：
* 支持HTML5, Flash视频播放技术。
* 支持多平台，PC包括Windows, MacOS, Linux等。Mobile包括Android, IOS, Windows Phone等。
* 支持多浏览器兼容，IE6/7/8/9/10、Google Chrome、Firefox、safari、Opera等。
* 支持多种视频格式，mp4、m3u8、oga、webm、theora、flv、f4v等。
* 支持多种协议直播流，rtmp、udp、http ts、rtsp的直播和回放。
* 支持Flash播放m3u8文件，以及AES-128解码播放。
* 支持PC与Mobile平台播放器自动识别功能。
* 支持浏览器HTML5与Flash特性检测。
* 支持播放地址AMF, AJAX, JOSNP类型请求。
* 支持自定义HTML5与Flash皮肤，无需了解程序，即可自己制作出超烗风格皮肤。
* 支持前置广告（swf, 图片, 视频）。
* 支持字幕。
* 支持多种播放参数设定。
* 支持丰富的api接口，快速打造功能强大的插件。


### 文件介绍：
* sewise.player.min.js主播放器文件
* html，HTML5皮肤目录。
* html\skins\vodWhite, HTML5皮肤vodWhite目录。
* html\skins\vodWhite\skin.html, HTML5皮肤vodWhite Dom元素。
* html\skins\vodWhite\skin.html.js, HTML5皮肤vodWhite Dom元素对象，用于兼容跨域加载。
* html\skins\vodWhite\skin.css, HTML5皮肤vodWhite CSS样式。
* html\skins\vodWhite\skin.js, HTML5皮肤vodWhite JS逻辑代码。

* flash, flash播放器目录
* flash\SewisePlayer.swf， Flash播放器主文件。
* flash\skins, Flash皮肤目录
* flash\skins\vodWhite.swf, Flash点播白色皮肤。
* flash\skins\liveWhite.swf, Flash直播白色皮肤。
* flash\skins\vodOrange.swf, Flash点播橙色皮肤。
* flash\skins\liveOrange.swf, Flash直播橙色皮肤。


### 页面播放器嵌入方式：
* 点播地址sourceid请求播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://192.168.1.24/libs/swfplayer/player/sewise.player.min.js?server=vod&sourceid=ZIM6n32R&autostart=true&starttime=2&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&buffer=5&skin=vodWhite"></script>
</div>
```
例子：[demos/vod_sourceid.html](demos/vod_sourceid.html)

* 点播地址videourl直接播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="player/sewise.player.min.js?server=vod&type=mp4&videourl=http://www.w3schools.com/html/mov_bbb.mp4&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=VodVideo&buffer=5&skin=vodWhite"></script>
</div>
```
例子：[demos/vod_videourl_mp4.html](demos/vod_videourl_mp4.html)

* 直播地址pid请求播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://192.168.1.21/libs/swfplayer/player/sewise.player.min.js?server=live&autostart=true&pid=e4f9i5sk&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&skin=liveWhite"></script>
</div>
```
例子：[demos/live_pid.html](demos/live_pid.html)

* 直播地址streamurl直接播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="player/sewise.player.min.js?server=live&type=rtmp&streamurl=rtmp://192.168.1.21/livestream/ijzj7292&autostart=true&pid=&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=LiveVideo&skin=liveWhite"></script>
</div>
```
例子：[demos/live_streamurl_rtmp.html](demos/live_streamurl_rtmp.html)


### 播放器运行原理:
* 第一步：页面加载sewise.player.min.js文件后，该脚本会将相应的参数解析出来，并检查出当前的设备平台、浏览器特性，同时还会根据JS文件的路径取出host地址，用于播放地址请求。
* 第二步：通过分析出来的vod与type参数与及浏览器特性，来确定播放器是启用HTML5还是Flash模块。对于不同平台和浏览器同时支持的视频格式或流协议，将优先启用HTML5播放模块。
* 第三步：加载对应的皮肤文件与库文件。
* 第四步：在皮肤加载完成后将根据给定的参数来初始化播放器。播放器初始化完成后，会在当前页面中回调playerReady()方法（HTML5或Flash播放器都会回调该方法），表示播放器API接口已可用。


### 播放器参数：
* Sewise Player播放器提供了灵活的参数设置功能，通过设置不同的参数值可以让播放器具有不同的播放特性。
* 详细参数说明，见："参数说明.md"文件。


### API接口调用：
* Sewise Player播放器对外提供了丰富的API接口，通过API接口调用可以轻松控制播放器播放。
* 详细接口说明，见："接口说明.md"文件。
* 点播接口例子：[demos/vod_api.html](demos/vod_api.html)
* 直播接口例子：[demos/live_api.html](demos/live_api.html)


### 播放器皮肤：
* Sewise Player播放器皮肤分为两部分，即HTML5与Flash皮肤。
* HTML5皮肤由HTML、CSS、JS文件构成，一个文件目录对应一个皮肤。
* Flash皮肤由SWF文件构成，一个SWF文件对应一个皮肤。
* HTML5与Flash皮肤设置方法相同，只要将参数skin设置为对应的皮肤名，如skin=vodWhite表示白色点播皮肤。
* HTML5与Flash皮肤的源代码已开放，见[source目录](source)。


## License
[Sewise Player](http://player.sewise.com/) is licensed under the [MIT license](http://opensource.org/licenses/MIT).


## More information:
* [sewise.com](http://www.sewise.com/)
* [player.sewise.com](http://player.sewise.com/)


## Author:
Jack Zhang [jackzhang1204@gmail.com](http://www.gmail.com)
[sewise.com](http://www.sewise.com/)







