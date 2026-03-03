function createSwiper(panel,delay,speed,loop)
{
    return new Swiper(panel,
    {
		autoplay:{delay: (delay || 20000),stopOnLastSlide:false,disableOnInteraction:false},	
		spaceBetween: 50,
		touchAngle: 90,
		  // effect : 'fade',
//  slidesPerView: 3,
    	centeredSlides: true,
		centeredSlides: true,
		speed: (speed || 800),
		loop: (loop || false),
		direction: "horizontal",
		runCallbacksOnInit: false,
		preloadImages: false,
		navigation: {nextEl: '.swiper-button-next',prevEl: '.swiper-button-prev',},
		on:
        {
            init: function(){var now = this.activeIndex;var now_video = this.slides[now].getElementsByTagName("video");if(now_video.length != 0) {now_video[0].volume = 1;now_video[0].play();}},
			slideChangeTransitionEnd: function()
            {
				//停止播放视频ֹ
				for(var i=0;i<this.slides.length;i++){
					var videos=this.slides[i].getElementsByTagName("video");
					for(var j=0;j<videos.length;j++){
						videos[j].currentTime=0;videos[j].pause();
					}
				}
				//播放当前slide的视频
				var now_video = this.slides[this.activeIndex].getElementsByTagName("video");
				if(now_video.length != 0){now_video[0].volume = 1;now_video[0].play();}
			}
		}
	});
}
