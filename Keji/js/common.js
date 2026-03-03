(function(){
	$(".bottom-btn li").click(function(){
		$(this).addClass('active').siblings().removeClass('active')
	});
	
	$(".rightbtn li").click(function(){
		var x = $(this).index();
		$(this).addClass('active').siblings().removeClass('active');
		var url =$(this).attr('data-src');
		$(".myVideo").attr("src",url);
		$(".imgbox").hide().eq(x).show();
	})
	$(".imgbox").hide().eq(0).show();
	
	$(".button-panel div").click(function(){
	   var x = $(this).index();
		$(".img-panel").css("transform", "scale(0)").eq(x).css("transform", "scale(1)");	
	
		
	})
	$(".img-panel .guanbi").click(function(){
		$(".img-panel").css("transform", "scale(0)");	
	})

})()