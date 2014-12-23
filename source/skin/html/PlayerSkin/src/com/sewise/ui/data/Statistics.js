(function($){
	/**
	 * Constructor.
	 * @name Statistics : 数据统计.
	 * 
	 */
	
	var Statistics = SewisePlayerSkin.Statistics = function(data){
		var playCountData = data["playCount"];
		if(playCountData){
			runPlayCount(playCountData);
		}
		
		//////////////////////////////////////////////////////////////
		function runPlayCount(data){
			var requestURL = data["request-url"];
			var requestData = data["request-data"];
			var countDelayTime = data["request-data"]["intervallen"] ? data["request-data"]["intervallen"] : 10000;
			
			//console.log(countDelayTime);
			setInterval(function(){
				$.ajax({
			        type: "post",
			        async: false,
			        dataType: "json",
			        url: requestURL,
			        data:requestData,
			        success :function(data){
			            //console.log(data);
			        },
			        error:function(){
			            console.log('play count ajax request fail!');
			        }
			    });
			}, countDelayTime);

		}


	};
	
})(window.jQuery)