var fps = 15
var fpsInterval = 1000 / fps
var last = new Date().getTime() //上次执行的时刻

function animate()
{
    requestAnimationFrame(animate);

    // 执行时的时间
    var now = new Date().getTime()
    var elapsed = now - last;
    // 经过了足够的时间
    if (elapsed > fpsInterval)
    {
        last = now - (elapsed % fpsInterval); //校正当前时间

        // 循环的代码
        // drawSomething()
    }
}

function Harry()
{
    this.animate = function ()
    {
        
    };
}
var harry = new Harry();