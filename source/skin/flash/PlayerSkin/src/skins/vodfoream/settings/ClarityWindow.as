/********************************************************************************
 * File        : ClarityWindow.as
 * Description : 清晰度设置窗口
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 17, 2013 10:33:07 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vodfoream.settings {
	//import com.demonsters.debugger.MonsterDebugger;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import interfaces.player.IClarity;
	
	import skins.PlayerEvent;
	import skins.vodfoream.RadioCircle;
	import skins.vodfoream.SettingWindow;
	
	import utils.LanguageManager;
	
	public class ClarityWindow extends SettingWindow{
		
		//从播放器传来的数据
		private var _clarities:Array = [];
		//清晰度选择元件数组
		private var _clarityList:Array = [];
		//当前正在播放的清晰度
		private var _clarity:IClarity;
		//被选中的项
		private var _selectedRadio:SelectRadio;
		//正在播放的项
		private var _playingRadio:SelectRadio;
		//选择项的Y位置
		private var _radioY:Number = 55;
		
		//jack 2014.6.9///////////////////
		public static var currentClarityName:String = "";
		/////////////////////////////////
		
		//jack fix/////
		public function initLanguage():void
		{
			this.okText.mouseEnabled = false;
			this.cancelText.mouseEnabled = false;
			
			this.title.text = LanguageManager.getInstance().getString("claritySetting");
			this.okText.text = LanguageManager.getInstance().getString("clarityOk");
			this.cancelText.text = LanguageManager.getInstance().getString("clarityCancel");
		}
		//jack fix/////
		
		public function get clarity():IClarity{
			return _clarity;
		}
		
		public function ClarityWindow(){
			super();
			
			this.title.text = "清晰度设置";
			this.visible = false;
		}
		
		/**
		 * 初始化清晰度显示
		 */
		public function initialClarities(levels:Array):void{
			//如果有数据则先清除数据及SelectRadio元件
			var srArr:Array = [];
			for(var n:int=0;n<this.numChildren;n++){
				if(this.getChildAt(n) is SelectRadio) srArr.push(this.getChildAt(n));
			}
			for(var m:int=0;m<srArr.length;m++){
				this.removeChild(srArr[m]);
			}
			
			//获得新的清晰度数据
			_clarities = levels;
			
			//重新生成SelectRadio
			for(var i:int=0;i<_clarities.length;i++){
				var clarityData:IClarity = _clarities[i] as IClarity;
				
				var clarityUI:SelectRadio = new SelectRadio();
				clarityUI.id = clarityData.id;
				clarityUI.setName(clarityData.name);
				clarityUI.radioCircle.selected = clarityData.selected;
				clarityUI.addEventListener(RadioCircle.SELECTED, selectHandler);
				this.addChild(clarityUI);
				
				if(clarityData.selected){
					_clarity = clarityData;
					_playingRadio = _selectedRadio = clarityUI;
					
					//jack 2014.6.9///////////////////
					currentClarityName =  _selectedRadio.labelName.text;
					this.stage.dispatchEvent(new Event("selected_radio_label_change"));
					/////////////////////////////////
					
				}
				
				var startX:Number = (this.width - clarityUI.width * _clarities.length)/2;
				clarityUI.x = startX + i * clarityUI.width;
				clarityUI.y = _radioY;
				
				_clarityList.push(clarityUI);
			}
		}
		
		/**
		 * 选择某个清晰度时响应方法
		 */
		private function selectHandler(e:Event):void{
			for(var i:int=0;i<_clarityList.length;i++){
				(_clarityList[i] as SelectRadio).radioCircle.selected = false;
			}
			_selectedRadio = e.target as SelectRadio;
			_selectedRadio.radioCircle.selected = true;
			
			//jack 2014.6.9///////////////////
			currentClarityName =  _selectedRadio.labelName.text;
			this.stage.dispatchEvent(new Event("selected_radio_label_change"));
			/////////////////////////////////
		}
		
		/**
		 * 点击确认按钮响应方法
		 */
		override protected function submitHandler(e:MouseEvent):void{
			super.submitHandler(e);
			
			//如果选择没有改变则不执行切换流播放
			if(_playingRadio.id == _selectedRadio.id){
				this.visible = false;
				return;
			}
			
			//找这个id对应的clarityLevel
			for(var j:int=0;j<_clarities.length;j++){
				var clarityData:IClarity = _clarities[j] as IClarity;
				clarityData.selected = false;
				
				if(_selectedRadio.id == clarityData.id){
					clarityData.selected = true;
					_playingRadio = _selectedRadio;
					
					_clarity = clarityData;
					this.dispatchEvent(new Event(PlayerEvent.CLARITY_CHANGE));
					this.visible = false;
				}
			}
		}
		
		/**
		 * 取消或是关闭本窗口时响应方法
		 */
		override protected function closeHandler(e:MouseEvent):void{
			super.closeHandler(e);
			
			//找这个id对应的clarityLevel
			var cid:String;
			for(var j:int=0;j<_clarities.length;j++){
				var clarityLevel:IClarity = _clarities[j] as IClarity;
				if(clarityLevel.selected == true){
					cid = clarityLevel.id;
				}
			}
			
			//恢复成之前的选择状态
			for(var i:int=0;i<_clarityList.length;i++){
				(_clarityList[i] as SelectRadio).radioCircle.selected = false;
				
				if(cid == (_clarityList[i] as SelectRadio).id){
					(_clarityList[i] as SelectRadio).radioCircle.selected = true;
				}
			}
		}
		
		
	}
}
