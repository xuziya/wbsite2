jQuery(function ($)
{
    /*一级菜单*/
    $(document).ready(function ()
    {
        $(".arrow-box").click(function ()
        {
            var left = $(".navbar").offset().left;
            if (left == -60) { $(".navbar").animate({ left: '0' }) }
            else { $(".navbar").animate({ left: '-60px' }) };
        });
        $(".arrow-box").mouseenter(function ()
        {
            $(".navbar").stop().animate({ left: '0' });
            $(".arrow>i").css("transform", "rotate(180deg)");
        });
        $(".navbar").mouseleave(function ()
        {
            $(".navbar").stop().animate({ left: '-60px' });
            $(".arrow>i").css("transform", "rotate(0deg)");
        });
    });

    /*二级菜单*/
    $(".sidebar-dropdown > a").click(function (e)
    {
        // 阻止事件冒泡，防止嵌套菜单触发父级菜单的点击事件
        e.stopPropagation();
        
        // 只关闭同级的下拉菜单，不关闭嵌套的下拉菜单
        $(this).parent().siblings().find(".sidebar-submenu").slideUp(250);
        $(this).parent().siblings().removeClass("active");
        $(this).parent().siblings().find("i").css("transform", "rotate(0deg)");
        
        if ($(this).parent().hasClass("active"))
        {
            $(this).parent().removeClass("active");
            $(this).parent().find("i").css("transform", "rotate(0deg)");
            $(this).next(".sidebar-submenu").slideUp(250);
        }
        else
        {
            $(this).parent().addClass("active");
            $(this).parent().find("i").css("transform", "rotate(90deg)");
            $(this).next(".sidebar-submenu").slideDown(250);
        }
    });
    $(".sidebar-dropdown").first().addClass("active");
    $(".sidebar-submenu").first().css("display", "block");
    $(".sidebar-dropdown i").first().css("transform", "rotate(90deg)");

    /**** 弹窗页 ****/
    /*左侧tab*/
    $(".tab-left .nav>li").click(function ()
    {
        $(".tab-left .nav>li").removeClass("active");
        $(this).addClass("active");
        $(".tab-left .tab-pane").removeClass("active");
        $(".tab-left .tab-pane").eq($(".tab-left .nav>li").index(this)).addClass("active");
    });
    $(".tab-left .nav>li").eq(0).addClass("active");
    $(".tab-left .tab-pane").eq(0).addClass("active");
    /*右侧tab*/
    $(".tab-right .nav>li").click(function ()
    {
        $(".tab-right .nav>li").removeClass("active");
        $(this).addClass("active");
        $(".tab-right .tab-pane").removeClass("active");
        $(".tab-right .tab-pane").eq($(".tab-right .nav>li").index(this)).addClass("active");
    });
    $(".tab-right .nav>li").eq(0).addClass("active");
    $(".tab-right .tab-pane").eq(0).addClass("active");

    /*点击按钮标签页显示隐藏*/
    $("#tab-left").click(function ()
    {
        var left = $(".tab-left").offset().left;
        if (left == -220)
        {
            $(".tab-left").stop().animate({ left: '0' });
            $("#tab-left>i").css("transform", "rotate(180deg)");
        }
        else if (left == 0)
        {
            $(".tab-left").animate({ left: '-220px' });
            $("#tab-left>i").css("transform", "rotate(0deg)");
        };
    });

    $("#tab-right").click(function ()
    {
        var right = $(".tab-right").offset().left;
        if (right == 1200 || right == 1400)
        {
            $(".tab-right").stop().animate({ right: '0' });
            $("#tab-right>i").css("transform", "rotate(180deg)");
        }
        else
        {
            $(".tab-right").animate({ right: '-220px' });
            $("#tab-right>i").css("transform", "rotate(0deg)");
        };
    });
    /*弹窗页标签内容页可以收缩*/   
    $(".tab-pane-dropdown > a").click(function ()
    {
        $(this).next($(".tab-pane-1")).slideToggle(250);
        $(this).find("i").toggleClass("rorate");
    });
});