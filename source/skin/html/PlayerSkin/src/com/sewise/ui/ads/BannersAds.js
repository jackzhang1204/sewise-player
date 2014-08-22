(function($){
	/**
	 * Constructor.
	 * @name BannersAds : 侧栏广告.
	 * 
	 */
	
	var BannersAds = SewisePlayerSkin.BannersAds = function(adsBox, adsData){
		var leftBannerBox = $(' <div style="position:absolute; display:table; width:100%; height:100%;">' + 
									'<div style="display:table-cell; text-align:left; vertical-align:middle;">' + 
										'<img style="pointer-events:auto; cursor:pointer; width: auto; height: auto;">' + 
									'</div>' + 
								'</div> ');
		leftBannerBox.appendTo(adsBox);
		var leftImg = leftBannerBox.find("img");
		//////////////////////////////
		var rightBannerBox = $(' <div style="position:absolute; display:table; width:100%; height:100%;">' + 
									'<div style="display:table-cell; text-align:right; vertical-align:middle;">' + 
										'<img style="pointer-events:auto; cursor:pointer; width: auto; height: auto;">' + 
									'</div>' + 
								'</div> ');
		rightBannerBox.appendTo(adsBox);
		var rightImg = rightBannerBox.find("img");
		/////////////////////////////////////////////////////////////
		var leftImgURL;
		var rightImgURL;
		var ymdDate;
		var currentDateAdsData;
		var currentAdsIndexOfDate;
		var pieceTimeLen;
		var delayTime = 10000;
		//////////////////////////////
		initCurrentDateAdsData();
		//当条件不适合时，跳出广告播放。
		if(currentDateAdsData == undefined) return;
		if (pieceTimeLen == 1 && currentDateAdsData[0]["time"] == ""){
			//当天只有一条广告且time=""时，表示只播放这一条广告。
			setBannerURL(0);
		}else{
			initCurrentAdsData();
			//间隔检查当前时间有没有进入下一个广告时间片。
			setInterval(checkTiming, delayTime);
		}
		//////////////////////////////////////////////////////////////
		leftImg.click(function(e){
			e.originalEvent.stopPropagation();
			var leftLink = currentDateAdsData[currentAdsIndexOfDate]["ads"][0]["link_url"];
			//如果链接回调函数存在执行回调函数，否则直接打开链接。
			if(window.openAdsLink && typeof(window.openAdsLink) == "function"){
				window.openAdsLink(leftLink);
			}else{
				window.open(leftLink, "_blank");
			}
		})
		rightImg.click(function(e){
			e.originalEvent.stopPropagation();
			var rightLink = currentDateAdsData[currentAdsIndexOfDate]["ads"][1]["link_url"];
			//如果链接回调函数存在执行回调函数，否则直接打开链接。
			if(window.openAdsLink && typeof(window.openAdsLink) == "function"){
				window.openAdsLink(rightLink);
			}else{
				window.open(rightLink, "_blank");
			}
		})
		function initCurrentDateAdsData(){
			ymdDate = SewisePlayerSkin.Utils.stringer.dateToYMD(new Date());
			//当key值为0000-00-00时，表示不按天排广告。
			currentDateAdsData = adsData[ymdDate] || adsData["0000-00-00"];
			currentAdsIndexOfDate = 0;
			if(currentDateAdsData != undefined){
				pieceTimeLen = currentDateAdsData.length;
			}
		}
		function initCurrentAdsData(){
			var currentTime = new Date().getTime();
			for(var i = 0; i < pieceTimeLen; i ++){
				var currentPieceTime = SewisePlayerSkin.Utils.stringer.hmsToDate(currentDateAdsData[i]["time"]).getTime();
				if(i < pieceTimeLen - 1){
					var nextPieceTime = SewisePlayerSkin.Utils.stringer.hmsToDate(currentDateAdsData[i + 1]["time"]).getTime();
					if(currentTime > currentPieceTime && currentTime < nextPieceTime){
						currentAdsIndexOfDate = i;
						setBannerURL(currentAdsIndexOfDate);
						break;
					}
				}else{
					if(currentTime > currentPieceTime){
						currentAdsIndexOfDate = i;
						setBannerURL(currentAdsIndexOfDate);
						break;
					}
				}
			}
			//console.log("currentAdsIndexOfDate: " + currentAdsIndexOfDate);
		}
		function checkTiming(){
			var currentTime = new Date().getTime();
			if(currentAdsIndexOfDate < pieceTimeLen - 1){
				//未跨天，仍在当天内播放。
				var nextPieceTime = SewisePlayerSkin.Utils.stringer.hmsToDate(currentDateAdsData[currentAdsIndexOfDate + 1]["time"]).getTime();
				if(currentTime > nextPieceTime){
					currentAdsIndexOfDate ++;
					setBannerURL(currentAdsIndexOfDate);
				}
				//console.log("未跨天，仍在当天内播放。");
			}else{
				var currentYMDDate = SewisePlayerSkin.Utils.stringer.dateToYMD(new Date());
				//console.log("currentYMDDate: " + currentYMDDate);
				if(currentYMDDate != ymdDate){
					//已经跨天，重新初始化当天广告数据。
					initCurrentDateAdsData();
					initCurrentAdsData();
					//console.log("已经跨天，重新初始化当天广告数据。");
				}else{
					//未跨天，仍然在显示当天的最后一条广告。
					//console.log("未跨天，但在播放当天最后一条广告。");
				}
			}
		}
		function setBannerURL(adsIndexOfDate){
			leftImgURL = currentDateAdsData[adsIndexOfDate]["ads"][0]["picurl"];
			rightImgURL = currentDateAdsData[adsIndexOfDate]["ads"][1]["picurl"];
			if(leftImgURL == "" && rightImgURL == ""){
				return;
			}else if(leftImgURL == "" && rightImgURL != ""){
				leftImgURL = rightImgURL;
			}else if(leftImgURL != "" && rightImgURL == ""){
				rightImgURL = leftImgURL;
			}
			leftImg.attr("src", leftImgURL);
			rightImg.attr("src", rightImgURL);
		}
		
	};
	
})(window.jQuery)



