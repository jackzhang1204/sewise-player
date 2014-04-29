(function(win){
	/**
	 * @name SewisePlayerSkin : Sewise Player Skin
	 * @sewise皮肤框架的全局对象, 也是皮肤框架内部所有类的命名空间.
	 */
	
	/**
	 * 创建SewisePlayerSkin对象，并强制覆盖原来存在的该对象，
	 * 以此确保主播放器中存在该对象时，用皮肤层中的该对象进行覆盖。
	 */
	var SewisePlayerSkin = win.SewisePlayerSkin =  
	{
		version: "1.0.0"
		
	};

	/**
	 * 检查性创建SewisePlayer对象，如果该对象已经在主播放器中存在
	 * 就保留原有对象。如果该对象不存在就创建该对象（主要用于在单独
	 * 皮肤框架中消错）
	 */
	var SewisePlayer = win.SewisePlayer = win.SewisePlayer || {};


})(window);