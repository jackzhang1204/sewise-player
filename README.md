# [Sewise Player](http://player.sewise.com/) : HTML5 Video Player

![Screenshot](https://github.com/jackzhang1204/sewise-player/raw/master/player.png)

Support for [jQuery](http://jquery.com/) HTML player skins. 

Demos: [Vod点播](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_videourl_mp4.html) | [Live直播](http://jackzhang1204.github.io/sewise/sewise_player/demos/live_pid.html) | [Flowplayer皮肤](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_skin_flowplayer.html) | [Fallback地址](http://jackzhang1204.github.io/sewise/sewise_player/demos/fallback_url.html) | [Bootstrap支持](http://jackzhang1204.github.io/sewise/sewise_player/demos/bootstrap.html) | [M3u8跨平台](http://jackzhang1204.github.io/sewise/sewise_player/demos/m3u8_cross_platform.html) | [More更多](http://jackzhang1204.github.io/sewise/sewise_player/demos/index.html)

QQ交流群：237432172


####招聘：
####帮现在公司高薪招H5高手要求掌握原生js、bootstratp、angularjs开发，熟悉移动端动态页面布局。如果合适请联系我QQ:1324999535（加Q时说明下来意）希望有幸能和您一起共事。我们开发中的angularjs项目http://m.tp-bihaohuo.cn


## What is Sewise Player?


### Sewise Player是一款专业的免费网页HTML5视频、流播放器，它功能强大，体积小，跨平台，兼容性好，使用方便简洁。
* 播放器是主要以HTML5技术为平台开发，同时兼容Flash技术，实现了跨平台各浏览器兼容的视频播放。使用Sewise Player您可以在Windows, MacOS, Linux，Windows Phone, Android, IOS等任意平台上，通过对应的浏览器或者[APP中基于WebView](https://github.com/jackzhang1204/webview-embed-sewise-player "WebView Embed Sewise Player")播放视频。
* Sewise Player使用非常简单，只要在页面对应的DIV内嵌入一个JS文件即可，播放器将通过自动识别浏览器的功能来启用HTML5或Flash模式播放视频。您不需要掌握任何JavaScript或ActionScript编码技术就可以制作出专业的网页视频播放器。
* Sewise Player即可以做为单一的前台播放器来在页面上播放视频和流，也可以结合Sewise Server后台技术实现专业的可交互的点播、直播视频播放。


### 功能列表：
* 支持HTML5，Flash视频播放技术。
* 支持多平台，PC包括Windows, MacOS, Linux等。Mobile包括Android, IOS, Windows Phone等。
* 支持多浏览器兼容，如IE6/7/8/9/10、Google Chrome、Firefox、safari、Opera等。
* 支持多种视频格式，如mp4、m3u8、oga、webm、theora、flv、f4v等。
* 支持多种协议直播流，如rtmp、hls、http等。
* 支持Flash播放m3u8文件，以及AES-128解码播放。
* 支持PC与Mobile平台播放器自动识别功能。
* 支持浏览器HTML5与Flash特性检测。
* 支持HTML5不同视频格式地址Fallback兼容播放功能。
* 支持Flash Fallback到HTML5视频播放功能。
* 支持播放地址AMF, AJAX, JOSNP类型请求。
* 支持自定义HTML5与Flash皮肤，让您无需了解专业的编码技术也可以制作出超烗风格的皮肤。
* 支持前置广告（swf, 图片, 视频）。
* 支持字幕。
* 支持多种播放参数设定，并支持启动参数设置。
* 支持丰富的api接口，以此可以快速打造功能强大的插件。


### 文件介绍：
* sewise.player.min.js主播放器文件。
* html，HTML5皮肤目录。
* html\skins\vodWhite, HTML5点播白色皮肤目录。
* html\skins\vodWhite\skin.html, HTML5点播白色皮肤Dom元素。
* html\skins\vodWhite\skin.html.js, HTML5点播白色皮肤Dom元素对象，用于兼容跨域加载。
* html\skins\vodWhite\skin.css, HTML5点播白色皮肤CSS样式。
* html\skins\vodWhite\skin.js, HTML5点播白色皮肤JS逻辑代码。
* flash, Flash播放器目录。
* flash\SewisePlayer.swf， Flash播放器主文件。
* flash\skins, Flash皮肤目录。
* flash\skins\vodWhite.swf, Flash点播白色皮肤。
* flash\skins\liveWhite.swf, Flash直播白色皮肤。
* flash\skins\vodOrange.swf, Flash点播橙色皮肤。
* flash\skins\liveOrange.swf, Flash直播橙色皮肤。


### 页面播放器嵌入方式：
* 点播，实际地址播放。
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=mp4&videourl=http://www.w3schools.com/html/mov_bbb.mp4&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=VodVideo&buffer=5&skin=vodWhite"></script>
</div>
```

* 点播，节目ID播放。
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://219.232.161.202/libs/swfplayer/player/sewise.player.min.js?server=vod&sourceid=eQgPHj4N&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&buffer=5&skin=vodWhite"></script>
</div>
```

* 直播，实际地址播放。
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=live&type=rtmp&streamurl=rtmp://219.232.161.204/livestream/mtzysunq&autostart=true&pid=&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=LiveVideo&skin=liveWhite"></script>
</div>
```

* 直播，节目ID播放。
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://219.232.161.204/libs/swfplayer/player/sewise.player.min.js?server=live&autostart=true&pid=vk5nx2cj&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&skin=liveWhite"></script>
</div>
```

* setup方式嵌入播放器。
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js"></script>
		<script type="text/javascript">
			SewisePlayer.setup({
				server: "vod",
				type: "mp4",
				videourl: "http://jackzhang1204.github.io/materials/mov_bbb.mp4",
		        skin: "vodWhite",
		        title: "Tile 标题",
		        lang: 'zh_CN',
		        fallbackurls:{
					ogg: "http://jackzhang1204.github.io/materials/mov_bbb.ogg",
					webm: "http://jackzhang1204.github.io/materials/mov_bbb.webm"
				}
			});
		</script>
</div>
```


### 播放器运行原理:
* 第一步：页面加载sewise.player.min.js文件后，该脚本会将相应的参数解析出来，并检查出当前的设备平台、浏览器特性，同时还会根据JS文件的路径取出host地址，用于播放地址请求。
* 第二步：通过分析出来的vod与type参数与及浏览器特性，来确定播放器是启用HTML5还是Flash模块。对于不同平台和浏览器同时支持的视频格式或流协议，将优先启用HTML5播放模块。
* 第三步：加载对应的皮肤文件与库文件。
* 第四步：在皮肤加载完成后将根据给定的参数来初始化播放器。播放器初始化完成后，开始播放视频、流同时会在当前页面中回调playerReady()（HTML5或Flash播放器都会回调playerReady方法，表示播放器API接口已可用）等相应的播放器回调方法。


### 播放器参数：
* Sewise Player播放器提供了灵活的参数设置功能，通过设置不同的参数值可以让播放器具有不同的播放特性。
* 详细参数说明，见：[参数说明.md](docs/参数说明.md)文件。


### 播放器皮肤：
* Sewise Player播放器皮肤分为两部分，即HTML5与Flash皮肤。
* HTML5皮肤由HTML、CSS、JS文件构成，一个文件目录对应一个皮肤。
* Flash皮肤由SWF文件构成，一个SWF文件对应一个皮肤。
* HTML5与Flash皮肤设置方法相同，只要将参数skin设置为对应的皮肤名，如skin=vodWhite表示白色点播皮肤。
* HTML5与Flash皮肤的源代码已开放，见[source](source)目录。


### API接口调用：
* Sewise Player播放器对外提供了丰富的API接口，通过API接口调用可以轻松控制播放器播放。
* 详细接口说明，见：[接口说明.md](docs/接口说明.md)文件。
* 点播接口
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=mp4&videourl=http://www.w3schools.com/html/mov_bbb.mp4&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=VodVideo 点播标题&buffer=5&skin=vodWhite&fallbackurls=%7B%0A%09%22ogg%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.ogg%22%2C%0A%09%22webm%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.webm%22%0A%7D"></script>
</div>
<script>
	//点播接口调用方法
	function startPlay(){
		SewisePlayer.doPlay();
	}
	function playPause(){
		SewisePlayer.doPause();
	}
	function seekTo(){
		SewisePlayer.doSeek(5);
	}
	function playStop(){
		SewisePlayer.doStop();
	}
	function changeVolume(){
		SewisePlayer.setVolume(0.1);
	}
	function getDuration(){
		alert(SewisePlayer.duration());
	}
	function getPlayTime(){
		alert(SewisePlayer.playTime());
	}
	// function switchProgram(){
	// 	SewisePlayer.playProgram("xqfa3cZn", 0, true);
	// }
	function switchVideo(){
		SewisePlayer.toPlay("http://media.w3.org/2010/05/sintel/trailer.mp4", "Sintel", 0, true);
	}

	//播放器回调方法
	function playerReady(name){
		console.log("Sewise Player On Ready 1");
		//SewisePlayer.toPlay("http://www.w3school.com.cn/i/movie.mp4", "title", 0, false);
	}
	SewisePlayer.playerReady(function(name){
		console.log("Sewise Player On Ready 2");
	});
	function onStart(name){
        console.log("onStart 1");
	}
	SewisePlayer.onStart(function(name){
		 console.log("onStart 2");
	});
	function onStop(name){
		 console.log("onStop 1");
	}
	SewisePlayer.onStop(function(name){
		 console.log("onStop 2");
	});
	function onMetadata(meta, name){
		console.log("onMetadata 1");
	}
	SewisePlayer.onMetadata(function(meta, name){
		 console.log("onMetadata 2");
	});
	function onClarity(clarity, name){
		console.log("onClarity 1");
	}
	SewisePlayer.onClarity(function(clarity, name){
		 console.log("onClarity 2");
	});
	function onPause(name){
		console.log("onPause 1");
	}
	SewisePlayer.onPause(function(name){
		 console.log("onPause 2");
	});
	function onSeek(time, name){
		console.log("onSeek 1: " + time);
	}
	SewisePlayer.onSeek(function(time, name){
		console.log("onSeek 2: " + time);
	});
	function onPlayTime(time, name){
		console.log("onPlayTime 1: " + time);
	}
	SewisePlayer.onPlayTime(function(time, name){
		console.log("onPlayTime 2: " + time);
	});
	function onBuffer(pt, name){
		console.log("onBuffer 1: " + pt);
	}
	SewisePlayer.onBuffer(function(pt, name){
		console.log("onBuffer 2: " + pt);
	});
</script>
<div style="padding-top: 20px;">
	<div style="padding-right: 20px;float: left;">[点播接口]</div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:startPlay();">播放</a></div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:playPause();">暂停</a></div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:seekTo();">跳转</a></div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:playStop();">停止</a></div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:changeVolume();">更改音量</a></div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:getDuration();">获取总时长</a></div>
	<div style="padding-right: 20px;float: left;"><a href="javascript:getPlayTime();">获取当前时间</a></div>
	<!-- <div style="padding-right: 20px;float: left;"><a href="javascript:switchProgram();">切换节目</a></div> -->
	<div style="padding-right: 20px;float: left;"><a href="javascript:switchVideo();">切换视频</a></div>
	<br clear="all"/>
</div>
```
例子：[demos/vod_api.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_api.html)

* 直播接口
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://219.232.161.204/libs/swfplayer/player/sewise.player.min.js?server=live&autostart=true&pid=vk5nx2cj
&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&skin=liveWhite"></script>
</div>
<script>
	//直播接口调用方法
	function startPlay(){
		SewisePlayer.doPlay();
	}
	function playPause(){
		SewisePlayer.doPause();
	}
	function seekTo(){
		SewisePlayer.doSeek("20140224160520");
	}
	function playStop(){
		SewisePlayer.doStop();
	}
	function livePlay(){
		SewisePlayer.doLive();
	}
	function changeVolume(){
		SewisePlayer.setVolume(0.3);
	}
	function getLiveTime(){
		alert(SewisePlayer.liveTime());
	}
	function getPlayTime() {
		alert(SewisePlayer.playTime());
	}
	function switchChannel(){
		SewisePlayer.playChannel("br9anah3", "", true);
	}
	function switchStream(){
		SewisePlayer.toPlay("rtmp://192.168.1.219/livestream/7gw3yt3h", "title", "", true);
	}
	
	//播放器回调方法
	function playerReady(name){
		console.log("Sewise Player On Ready 1");
		//SewisePlayer.toPlay("http://www.w3school.com.cn/i/movie.mp4", "title", 0, false);
	}
	SewisePlayer.playerReady(function(name){
		console.log("Sewise Player On Ready 2");
	});
	function onStart(name){
        console.log("onStart 1");
	}
	SewisePlayer.onStart(function(name){
		 console.log("onStart 2");
	});
	function onStop(name){
		 console.log("onStop 1");
	}
	SewisePlayer.onStop(function(name){
		 console.log("onStop 2");
	});
	function onMetadata(meta, name){
		console.log("onMetadata 1");
	}
	SewisePlayer.onMetadata(function(meta, name){
		 console.log("onMetadata 2");
	});
	function onClarity(clarity, name){
		console.log("onClarity 1");
	}
	SewisePlayer.onClarity(function(clarity, name){
		 console.log("onClarity 2");
	});
	function onPause(name){
		console.log("onPause 1");
	}
	SewisePlayer.onPause(function(name){
		 console.log("onPause 2");
	});
	function onSeek(time, name){
		console.log("onSeek 1: " + time);
	}
	SewisePlayer.onSeek(function(time, name){
		console.log("onSeek 2: " + time);
	});
	function onPlayTime(time, name){
		console.log("onPlayTime 1: " + time);
	}
	SewisePlayer.onPlayTime(function(time, name){
		console.log("onPlayTime 2: " + time);
	});
	function onBuffer(pt, name){
		console.log("onBuffer 1: " + pt);
	}
	SewisePlayer.onBuffer(function(pt, name){
		console.log("onBuffer 2: " + pt);
	});
</script>
<div style="padding-top: 20px;">
	<div style="padding-right: 15px;float: left;">[直播接口]</div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:startPlay();">播放</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:playPause();">暂停</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:seekTo();">跳转</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:playStop();">停止</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:livePlay();">直播</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:changeVolume();">更改音量</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:getLiveTime();">直播时间</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:getPlayTime();">播放时间</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:switchChannel();">切换频道</a></div>
	<div style="padding-right: 15px;float: left;"><a href="javascript:switchStream();">切换流</a></div>
	<br clear="all"/>
</div>
```
例子：[demos/live_api.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/live_api.html)

###[更多例子](demos/例子说明.md)


## Who is using Sewise Player?
* [Foream](http://www.foream.cn/trending.html)
* [Autotiming](http://hiho.autotiming.com/search?keywords=CNN)
* [中南大学视频](http://tv.csu.edu.cn/)
* [深圳蛇口电视台](http://www.sktv.com.cn/)
* [深圳天威-威视网](http://www.topway.cn/)
* [海南网络广播电视台](http://www.hnntv.cn/zhibo/ly.html)
* [习网](http://haohaizi.ciwong.com/)
* [热点电视IOS](https://itunes.apple.com/us/app/re-dian-dian-shi/id862286172)
* [热点电视Android](http://apk.hiapk.com/appinfo/com.pa.sztv)


## License
[Sewise Player](http://player.sewise.com/) is licensed under the [MIT license](http://opensource.org/licenses/MIT).


## More information:
* [sewise.com](http://www.sewise.com/)
* [player.sewise.com](http://player.sewise.com/)
* QQ群：237432172

## Author:
* Sewise Ltd 		[http://www.sewise.com](http://www.sewise.com)
* Jack's GitHub 	[https://github.com/jackzhang1204](https://github.com/jackzhang1204)
* Jack's Twitter 	[https://twitter.com/jackzhang1204](https://twitter.com/jackzhang1204)
* Jack's Facebook 	[https://www.facebook.com/jackzhang1204](https://www.facebook.com/jackzhang1204)
* Jack's Google+ 	[https://plus.google.com/+JackZhang1204](https://plus.google.com/+JackZhang1204)
* Jack's Gmail 		[jackzhang1204@gmail.com](http://www.gmail.com)

