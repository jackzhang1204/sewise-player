(function($){
	/**
	 * Constructor.
	 * @name ClarityWindow : 多分辨率切换面板.
	 * 
	 */
	
	var ClarityWindow = SewisePlayerSkin.ClarityWindow = function(elementObject){
		var $container = elementObject.$container;
		//////////////////
		var that = this;
		var mainPlayer;
		var controlBar;
		var clarityWindow;
        var radiosDom = "";
		var clarityPanelDom = "";
		var clarityArray;
		var clarityLen;
		var currentCheckIndex = 0;
		var radioCheckIndex = 0;

		///////////////////////////
		this.setPlayer = function(mPlayer){
			mainPlayer = mPlayer;
		}
		this.setControlBar = function(controlBarObj){
			controlBar = controlBarObj;
		}
		this.initialClarities = function(levels){
			var claritySettingStr = SewisePlayerSkin.Utils.language.getString("claritySetting");
			var clarityOkStr = SewisePlayerSkin.Utils.language.getString("clarityOk");
			var clarityCancelStr = SewisePlayerSkin.Utils.language.getString("clarityCancel");

			//初始化多码率, name, videoUrl, id, selected.
			//console.log("vod clarityArray: " + clarityArray[0].name);
			clarityArray = levels;
			clarityLen = clarityArray.length;
			for(var i = 0; i < clarityLen; i ++){
				var checked;
				if(clarityArray[i].selected){
					checked = ' checked = "checked" ';
					currentCheckIndex = i;
					controlBar.updateClarityBtnText(clarityArray[i].name);
				}else{
					checked = " ";
				}
				radiosDom += '<input style="width: 20px; height: 18px; " type="radio" name="radio_clarity"' + checked + '"value="' + clarityArray[i].name + '">' + clarityArray[i].name + "\n";
			}
			clarityPanelDom = 
				'<div style="position:absolute; width: 300px; height: 140px; color: #FFF; border: 2px solid #FF9501; padding: 10px; background: rgba(255, 149, 1, 0.3); ">' + 
					'<div>' + 
				      '<div style="float: left; ">' + claritySettingStr + '</div>' + 
				      '<div style="float: right; ">' + 
				        '<a href="javascript:;" name="cancel_clarity" style="color: #FFF; font-weight:bold; text-decoration: none; padding: 4px 6px; ">X</a>' + 
				      '</div>' + 
				    '</div>' + 
				      '<div style="width: 100%; height: 40px; padding: 30px 0px 10px 0px; text-align: center; clear: both;">' + 
				    	radiosDom + 
				      '</div>' + 
				    '<div style="padding: 10px; text-align: center; ">' + 
				      '<a href="javascript:;" name="confirm_clarity" style="color: #FFF; text-decoration: none; background-color: #FF9501; padding: 5px 10px; margin-right: 20px; ">' + clarityOkStr + '</a>' + 
				      '<a href="javascript:;" name="cancel_clarity" style="color: #FFF; text-decoration: none; background-color: #FF9501; padding: 5px 10px; margin-left: 20px; ">' + clarityCancelStr + '</a>' + 
				    '</div>' + 
				'<div>';
			////////////////////
			clarityWindow = $("<div></div>");
			clarityWindow.html(clarityPanelDom);
			clarityWindow.css({ "position":"absolute", "left":"50%", "top":"50%", "margin-left":"-162px", "margin-top":"-82px" });
			clarityWindow.hide();
			clarityWindow.appendTo($container);
			clarityWindow.click(function(e){
				e.originalEvent.stopPropagation();
			});	
			clarityWindow.find("[name = confirm_clarity]").click(function(e){
				e.originalEvent.stopPropagation();
				clarityWindow.hide();
				if(currentCheckIndex == radioCheckIndex) return;
				currentCheckIndex = radioCheckIndex;
				controlBar.updateClarityBtnText(clarityArray[currentCheckIndex].name);
            	mainPlayer.changeClarity({ 
            								name: clarityArray[currentCheckIndex].name,
            	  						   	videoUrl: clarityArray[currentCheckIndex].videoUrl,
            	  						   	id: clarityArray[currentCheckIndex].id,
            	  							selected: true
            	  						});

            	/**
            	 * 通知页面保存当前用户选取的视频清晰度
            	 */
            	if(window.saveClarityName && typeof(window.saveClarityName) == "function"){
					window.saveClarityName(clarityArray[currentCheckIndex].name);
				}else{
					console.log("Not found the saveClarityName function of window");
				}
				
            });
            clarityWindow.find("[name = cancel_clarity]").click(function(e){
            	e.originalEvent.stopPropagation();
            	clarityWindow.hide();
            	radioCheckIndex = currentCheckIndex;
            	
            });
            clarityWindow.find("[name = radio_clarity]").click(function(e){
            	e.originalEvent.stopPropagation();
            	radioCheckIndex = $(e.target).index();
            });

		}
		this.toggle = function(){
			clarityWindow.toggle();
			clarityWindow.find("[name = radio_clarity]").get(currentCheckIndex).checked = true;
			radioCheckIndex = currentCheckIndex;
		}

		
	};
	
})(window.jQuery)