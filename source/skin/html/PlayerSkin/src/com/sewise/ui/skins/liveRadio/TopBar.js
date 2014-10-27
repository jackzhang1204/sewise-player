(function($){
	/**
	 * Constructor.
	 * @name TopBar : 皮肤标题层对象.
	 * 
	 */
	var TopBar = SewisePlayerSkin.TopBar = function(elementObject){
		var $topbar = elementObject.$topbar;
		var $programTip = elementObject.$programTip;
		var $programTitle = elementObject.$programTitle;
		var $topbarClock = elementObject.$topbarClock;

		/////////////////////////////
		this.setClock = function(date){
			var timeString = SewisePlayerSkin.Utils.stringer.dateToTimeString(date);
			$topbarClock.text(timeString);

			//console.log(timeString);
		}
		this.setTitle = function(title){
			$programTitle.text(title);
		}
		this.show = function(){
			$topbar.css("visibility", "visible");
		}
		this.hide = function(){
			$topbar.css("visibility", "hidden");
		}
		this.hide2 = function(){
			$topbar.hide();
		}
		this.initLanguage = function(){
			var titleTip = SewisePlayerSkin.Utils.language.getString("titleTip");
			$programTip.text(titleTip);
		}
		
		
	};
	
})(window.jQuery)