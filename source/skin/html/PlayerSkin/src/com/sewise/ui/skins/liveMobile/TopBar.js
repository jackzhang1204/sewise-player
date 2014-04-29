(function(){
	/**
	 * Constructor.
	 * @name TopBar : 皮肤标题层对象.
	 * 
	 */
	var TopBar = SewisePlayerSkin.TopBar = function(elementObject){
		var $programTitle = elementObject.$programTitle;
		var $topbarClock = elementObject.$topbarClock;

		/////////////////////////////
		var interval = setInterval(setClock, 1000);
		function setClock(){
			var timeString = SewisePlayerSkin.Utils.stringer.dateToTimeString();
			$topbarClock.text(timeString);

			//console.log(timeString);
		}

		this.setTitle = function(title){
			$programTitle.text(title);
		}

	};
	
})()