# [Sewise Player](http://player.sewise.com/) : HTML5 Video Player

![Screenshot](https://github.com/jackzhang1204/sewise-player/raw/master/player.png)

Support for [jQuery](http://jquery.com/) HTML player skins. 

Demos: [Vod点播](http://219.232.161.204/libs/swfplayer/player/vod.html) | [Live直播](http://219.232.161.204/libs/swfplayer/player/live.html) | [Flowplayer皮肤](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_skin_flowplayer.html) | [Fallback地址](http://jackzhang1204.github.io/sewise/sewise_player/demos/fallback_url.html) | [Bootstrap支持](http://jackzhang1204.github.io/sewise/sewise_player/demos/bootstrap.html) | [M3u8跨平台](http://jackzhang1204.github.io/sewise/sewise_player/demos/m3u8_cross_platform.html) | [More更多](http://jackzhang1204.github.io/sewise/sewise_player/demos/index.html)


## What is Sewise Player?


### Sewise Player是一款专业的免费网页HTML5视频、流播放器，它功能强大，体积小，跨平台，兼容性好，使用方便简洁。
* 播放器是主要以HTML5技术为平台开发，同时兼容Flash技术，实现了跨平台各浏览器兼容的视频播放。使用Sewise Player您可以在Windows, MacOS, Linux，Windows Phone, Android, IOS等任意平台上，通过对应的浏览器播放视频。
* Sewise Player使用非常简单，只要在页面对应的DIV内嵌入一个JS文件即可，播放器将通过自动识别浏览器的功能来启用HTML5或Flash模式播放视频。您不需要掌握任何JavaScript或ActionScript编码技术就可以制作出专业的网页视频播放器。
* Sewise Player即可以做为单一的前台播放器来在页面上播放视频和流，也可以结合Sewise Server后台技术实现专业的可交互的点播、直播视频播放。


### 功能列表：
* 支持HTML5，Flash视频播放技术。
* 支持多平台，PC包括Windows, MacOS, Linux等。Mobile包括Android, IOS, Windows Phone等。
* 支持多浏览器兼容，如IE6/7/8/9/10、Google Chrome、Firefox、safari、Opera等。
* 支持多种视频格式，如mp4、m3u8、oga、webm、theora、flv、f4v等。
* 支持多种协议直播流，如rtmp、udp、http ts、rtsp等。
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
		console.log("Sewise Player On Ready");
		//SewisePlayer.toPlay("http://www.w3school.com.cn/i/movie.mp4", "title", 0, false);
	}
	function onStart(name){
        console.log("onStart");
	}
	function onStop(name){
		 console.log("onStop");
	}
	function onMetadata(meta, name){
		console.log("onMetadata");
	}
	function onClarity(clarity, name){
		console.log("onClarity");
	}
	function onPause(name){
		console.log("onPause");
	}
	function onSeek(time, name){
		console.log("onSeek: " + time);
	}
	function onPlayTime(time, name){
		console.log("onPlayTime: " + time);
	}
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
		console.log("Sewise Player On Ready");
		//SewisePlayer.toPlay("http://www.w3school.com.cn/i/movie.mp4", "title", 0, false);
	}
	function onStart(name){
        console.log("onStart");
	}
	function onStop(name){
		 console.log("onStop");
	}
	function onMetadata(meta, name){
		console.log("onMetadata");
	}
	function onClarity(clarity, name){
		console.log("onClarity");
	}
	function onPause(name){
		console.log("onPause");
	}
	function onSeek(time, name){
		console.log("onSeek: " + time);
	}
	function onPlayTime(time, name){
		console.log("onPlayTime: " + time);
	}
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


### Example：
* 点播MP4视频播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=mp4&videourl=http://www.w3schools.com/html/mov_bbb.mp4&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=VodVideo&buffer=5&skin=vodWhite&fallbackurls=%7B%0A%09%22ogg%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.ogg%22%2C%0A%09%22webm%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.webm%22%0A%7D"></script>
</div>
```
例子：[demos/vod_videourl_mp4.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_videourl_mp4.html)

* 点播FLV视频播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=flv&videourl=http://219.232.161.202:5080/flvseek/data/userdata/vod/resource/201402/OVNNwRk1.flv&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&poster=http://www.sewise.com/data/attachment/portal/201402/10/120117q992dwsgns5cxzoz.png&title=Vod-FLV&buffer=5&skin=vodOrange"></script>
</div>
```
例子：[demos/vod_videourl_flv.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_videourl_flv.html)

* 点播节目ID视频播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://219.232.161.202/libs/swfplayer/player/sewise.player.min.js?server=vod&sourceid=eQgPHj4N&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&buffer=5&skin=vodWhite"></script>
</div>
```
例子：[demos/vod_sourceid.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/vod_sourceid.html)

* 直播RTMP流播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=live&type=rtmp&streamurl=rtmp://219.232.161.204/livestream/mtzysunq&autostart=true&pid=&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&poster=http://www.sewise.com/data/attachment/portal/201402/10/120117q992dwsgns5cxzoz.png&title=LiveVideo&skin=liveWhite"></script>
</div>
```
例子：[demos/live_streamurl_rtmp.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/live_streamurl_rtmp.html)

* 直播HTTP流播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=live&type=http&streamurl=http://219.232.161.204:5080/livestream/mtzysunq.flv&autostart=true&pid=&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=LiveVideo&skin=liveOrange"></script>
</div>
```
例子：[demos/live_streamurl_http.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/live_streamurl_http.html)

* 直播节目ID播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="http://219.232.161.204/libs/swfplayer/player/sewise.player.min.js?server=live&autostart=true&pid=vk5nx2cj&shifttime=&buffer=5&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&skin=liveWhite"></script>
</div>
```
例子：[demos/live_pid.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/live_pid.html)

* Flash m3u8播放
```html
<div style="width: 600px;height: 400px;">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=m3u8&videourl=http://www.codecomposer.net/hls/playlist.m3u8&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=Play-M3u8&buffer=5&claritybutton=disable&skin=vodWhite"></script>
</div>
```
例子：[demos/flash_m3u8.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/flash_m3u8.html)

* Flash m3u8 AES-128解码播放
```html
<div style="width: 600px;height: 400px;">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=m3u8&videourl=http://playertest.longtailvideo.com/adaptive/customIV/prog_index.m3u8&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=Play-AES-M3u8&buffer=5&claritybutton=disable&skin=vodWhite"></script>
</div>
```
例子：[demos/flash_m3u8_aes_128.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/flash_m3u8_aes_128.html)

* 启动参数设置模式
```html
<div style="width: 640px; height: 360px; ">
	<!-- 1.根据给定视频地址播放 -->
	<script type="text/javascript" src="../player/sewise.player.min.js"></script>
	<script type="text/javascript">
		SewisePlayer.setup({
			server: "vod",
			type: "mp4",
			title:"Tile 标题",
			videourl: "http://www.w3schools.com/html/mov_bbb.mp4",
		       skin: "vodWhite"
		});
	</script>

	<!-- 2.根据给定视频节目ID播放 -->
	<!-- <script type="text/javascript" src="http://192.168.1.24/player/sewise.player.min.js"></script>
	<script type="text/javascript">
		SewisePlayer.setup({
			sourceid: "uWHj4JDB",
			server: "vod",
		    skin: "vodWhite",
		    fallbackurls:{
				ogg: "http://www.w3schools.com/html/mov_bbb.ogg",
				webm: "http://www.w3schools.com/html/mov_bbb.webm"
			}
		});
	</script> -->
</div>
```
例子：[demos/setup_parameters.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/setup_parameters.html)

* HTML5播放回退兼容地址
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js"></script>
	<script type="text/javascript">
		SewisePlayer.setup({
			server: "vod",
			type: "mp4",
			videourl: "http://www.w3schools.com/html/mov_bbb.mp4",
		    skin: "vodWhite",
		    fallbackurls:{
			ogg: "http://www.w3schools.com/html/mov_bbb.ogg",
			webm: "http://www.w3schools.com/html/mov_bbb.webm"
			}
		});
	</script>
</div>
```
例子：[demos/fallback_url.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/fallback_url.html)

* Flash回退HTML5兼容地址播放
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js"></script>
	<script type="text/javascript">
		SewisePlayer.setup({
			server: "vod",
			type: "flv",
			videourl: "http://219.232.161.202:5080/flvseek/data/userdata/vod/resource/201402/OVNNwRk1.flv",
	        skin: "vodWhite",
	        claritybutton: "false",
			title: "flash fallback html5 兼容地址播放",
	        fallbackurls:{
				mp4: "http://www.w3schools.com/html/mov_bbb.mp4",
        		ogg: "http://www.w3schools.com/html/mov_bbb.ogg",
				webm: "http://www.w3schools.com/html/mov_bbb.webm"
			}
		});
	</script>
</div>
```
例子：[demos/flash_fallback_html5.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/flash_fallback_html5.html)

* 音频播放
```html
<div style="width: 250px; height: 30px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js"></script>
	<script type="text/javascript">
		SewisePlayer.setup({
			server: "vod",
			type: "mp3",
			videourl: "http://www.html5rocks.com/en/tutorials/audio/quick/test.mp3",
	        fallbackurls:{
        		ogg: "http://www.html5rocks.com/en/tutorials/audio/quick/test.ogg"
			}
		});
	</script>
</div>
```
例子：[demos/audio.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/audio.html)

* 时间片断播放
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>Sewise Player</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
</head>
<body>
	<div>
		<div id="container" style="width: 650px; height: 360px; border: solid 1px #DDD"></div>
			<script type="text/javascript">
				var srcPath = "../player/sewise.player.min.js?server=vod&type=flv&autostart=true&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=VodVideo&buffer=5&skin=vodWhite";
				var videoUrl = "http://219.232.161.206:5080/flvseek/data/userdata/vismam/downfile/201307/02005220p.flv?starttime=100&endtime=150";
				var script = document.createElement('script');
				script.type = "text/javascript";
				script.src = srcPath + "&videourl=" + encodeURIComponent(videoUrl);
				$("#container").append(script);
			</script>
		<div>
		<div style="padding: 20px;float: left;">注：请在Web环境下预览该文件。</div>
	</div>
</body>
</html>
```
例子：[demos/play_piece_time.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/play_piece_time.html)

* 添加删除播放器
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>Sewise Player</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript">
	var srcPath = "../player/sewise.player.min.js?server=vod&type=mp4&videourl=http://www.w3schools.com/html/mov_bbb.mp4&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=VodVideo&buffer=5&skin=vodWhite";
	var fallbackurls = {
		ogg: "http://www.w3schools.com/html/mov_bbb.ogg",
		webm: "http://www.w3schools.com/html/mov_bbb.webm"
	}
	var state = "removed";
	function addPlayer(){
		if(state == "removed"){
			var script = document.createElement('script');
			script.type = "text/javascript";
			script.src = srcPath + "&fallbackurls=" + encodeURIComponent(JSON.stringify(fallbackurls, "", "\t"));
			$("#container").append(script);
			state = "added";
		}
	}
	function removePlayer(){
		if(state == "added"){
			$("#container").empty();
			state = "removed";
		}
	}
</script>
</head>
<body>
	<div>
		<div id="container" style="width: 650px; height: 360px; border: solid 1px #DDD"></div>
		<div>
		<ul>
			<button onclick="addPlayer()">Add Player</button>
			<button onclick="removePlayer()">Remove Player</button>
		</ul>
		</div>
		<div style="padding: 20px;float: left;">注：请在Web环境下预览该文件。</div>
	</div>
</body>
</html>
```
例子：[demos/add_remove_player.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/add_remove_player.html)

* 海报预览
```html
<div style="width: 640px; height: 360px; ">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=mp4&videourl=http://www.w3schools.com/html/mov_bbb.mp4&sourceid=&autostart=false&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=Vod Video 视频&buffer=5&poster=http://www.sewise.com/data/attachment/portal/201402/10/120117q992dwsgns5cxzoz.png&skin=vodWhite&fallbackurls=%7B%0A%09%22ogg%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.ogg%22%2C%0A%09%22webm%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.webm%22%0A%7D"></script>
</div>
```
例子：[demos/poster.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/poster.html)

* 换色皮肤
```html
<div style="width: 640px;height: 362px;">
	<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=flv&videourl=http://219.232.161.202:5080/flvseek/data/userdata/vod/resource/201402/OVNNwRk1.flv&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=Color-Skin&buffer=5&claritybutton=disable&skin=vodVspaas"></script>
	<script type="text/javascript">
		var player;
		function playerReady() {
			player = document.getElementById("sewise_player");
		}
		function setUiColor()
	    {
	        var uiColorArray = [0x333333, 0x56be8e, 0x3ea9f5, 0xf27398, 0xffff00, 0xff0000];
	        var randomIndex = Math.floor(Math.random() * uiColorArray.length);
	        player.setUiColor(uiColorArray[randomIndex]);
	    }
		</script>
        <div style="padding-top: 20px;">
        	<div style="padding-right: 20px;float: right;"><a href="javascript:setUiColor();">Switch UI Color</a></div>
        </div>
</div>
```
例子：[demos/color_skin.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/color_skin.html)

* 多重播放
```html
<div>
	<div style="padding-right: 20px;float: left;">HTML5 播放</div><br>
	<div style="width: 640px; height: 360px; ">
		<script type="text/javascript" src="../player/sewise.player.min.js?server=vod&type=mp4&videourl=http://media.w3.org/2010/05/sintel/trailer.mp4&sourceid=&autostart=true&starttime=0&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&title=HTML5 播放&buffer=5&skin=vodWhite&fallbackurls=%7B%0A%09%22ogg%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.ogg%22%2C%0A%09%22webm%22%3A%20%22http%3A%2F%2Fwww.w3schools.com%2Fhtml%2Fmov_bbb.webm%22%0A%7D"></script>
	</div>
	<br>
	<div style="padding-right: 20px;float: left;">Flash 播放</div><br>
	<div style="width: 640px; height: 360px; ">
		<object type="application/x-shockwave-flash" id="sewise_player" name="sewise_player" data="../player/flash/SewisePlayer.swf" width="100%" height="100%">
		<param name="allowfullscreen" value="true">
		<param name="wmode" value="transparent">
		<param name="allowscriptaccess" value="always">
		<param name="flashvars" value="autoStart=true&programId=&lang=en_US&logo=http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png&buffer=5&type=flv&serverPath=&serverApi=ServerApi.execute&skin=../player/flash/skins/vodWhite.swf&title=Flash播放&draggable=true&published=0&videoUrl=http://219.232.161.202:5080/flvseek/data/userdata/vod/resource/201402/OVNNwRk1.flv&startTime=0&playerName=Sewise Player&copyright=(C) All right reserved the SEWISE inc 2011-2013&clarityButton=disable&timeDisplay=enable&controlBarDisplay=enable&topBarDisplay=enable&customStrings="></object>
	</div>
</div>
```
例子：[demos/multiplay.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/multiplay.html)

* 字幕
```html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Sewise Player-Subtitles</title>
		<script charset="utf-8" type="text/javascript" language="JavaScript" src="../player/js/swfobject.js"></script>
		<script language="JavaScript" charset="utf-8" type="text/javascript">
			var player;
            var host = "http://219.232.161.206/";
            var video_url = "http://219.232.161.206:5080/flvseek/data/userdata/vismam/downfile/201307/02005220p.flv";
            var subtitles_id = "2UtWdAUZ";
            var subtitles_lang = "en";    //显示字幕语言, 英文: en, 中文: zh_CN
            
			var flashvars = {
                serverPath       : host + 'flashservice/gateway.php',
				serverApi        : 'ServerApi.execute',
				autoStart        : 'true',
				logo             : 'http://onvod.sewise.com/libs/swfplayer/skin/images/logo.png',
                title            : 'Subtitles Test',
                clarityButton	 : 'disable',
                lang             : 'en_US',
				skin             : '../player/flash/skins/vodWhite.swf',
                type             : 'flv',
				videoUrl         : video_url,
                
                subtitlesPlayer  : '../player/flash/plugins/SubtitlesPlayer.swf',
                subtitlesId      : subtitles_id,
                subtitlesLang    : subtitles_lang
			};
			var params = {
				allowfullscreen   : true,
				wmode             : "transparent",
				allowscriptaccess : 'always'
			};
			var attributes = {
				id : 'sewise_x_player',
				name : 'sewise_x_player'
			};
			window.onload = function() {
				swfobject.embedSWF("../player/flash/SewisePlayer.swf", "swf-container", "100%", "100%", "9.0.115", false, flashvars, params, attributes);
			}
			function playerReady() {
				player = document.getElementById("sewise_x_player");
			}
            function switchVideo(){
                player.toPlay("http://219.232.161.206:5080/flvseek/data/userdata/vismam/downfile/201307/020058352.flv", 'test toPlay', 0, true, '', 'xMRgJgIP', 'en');
			}
		</script>
	</head>
	<body>
		<div style="width: 600px;height: 400px;">
			<div id="swf-container">
				加载播放器......
			</div>
            <div style="padding-top: 20px;">
                <div style="padding-right: 20px;float: left;"><a href="javascript:switchVideo();">Switch Video</a></div>
            </div>
		</div>
	</body>
</html>
```
例子：[demos/subtitles.html](http://jackzhang1204.github.io/sewise/sewise_player/demos/subtitles.html)


## Who is using Sewise Player?
* [foream.cn](http://www.foream.cn/trending.html)
* [autotiming.com](http://hiho.autotiming.com/search?keywords=CNN)
* [csu.edu.cn](http://tv.csu.edu.cn/)
* [hnntv.cn](http://www.hnntv.cn/zhibo/ly.html)
* [ltetv](http://www.wandoujia.com/apps/com.sewise.ltetv)


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

