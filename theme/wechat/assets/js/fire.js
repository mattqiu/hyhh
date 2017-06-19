String.prototype.snakeFormat = function(args) {
    var result = this;
    if (arguments.length > 0) {
        for (var i = 0; i < arguments.length; i++) {
            if (arguments[i] != undefined) {
                var reg = new RegExp("({[" + i + "]})", "g");
                result = result.replace(reg, arguments[i]);
            }
        }
    }
    return result;
};
var firepassToggle = false;
var firepass = function(color) {
    
    var width  = window.innerWidth,
        height = window.innerHeight;

    var timer  = 0;
    
    //爆炸点数据
    var booms = [];
    
    var canvas  = document.getElementById("fireworks2"),
        context = document.getElementById("fireworks2").getContext("2d");
    
    canvas.width = width;
    canvas.height = height;
    
    //创建烟火
    function createFire(x, y, c, bx) {
        return {
           x:x,
           y:y,
           c:c,
           life: 36 + rnd(50),
           pos: [],
           dx: 16,
           dy: 16,
           ag: bx*30*Math.PI/180,
           move: function() {
                this.dx *= .95;
                this.dy *= .95;
                this.x += this.dx * Math.sin(this.ag);
                this.y += this.dy * Math.cos(this.ag);
                this.pos.push([this.x, this.y]);
                if (this.pos.length > 8) {
                    this.pos.shift();
                }
                this.life--;
            }
        };
    }
    
    //创建爆炸点
    function createBoom(x, y) {
        canvas.style.visibility = "visible";
        var tmp = [];
        for (var i = 0; i < 12; i++) {
            tmp.push(createFire(x, y, color, i));
        }
        booms.push(tmp);
    }
    
    //随机数
    function rnd(n) {
        return (n || 1) * Math.random();
    }
    
    //绘制烟火
    function drawGuide(pos, a, c) {
        context.save();
        for (var i = 0; i < pos.length; i++) {
            context.beginPath();
            /*
            context.strokeStyle = c.snakeFormat(a/4);
            context.lineWidth = Math.min(i+0.5, 3);
            context.lineCap = "square";
            context.moveTo(pos[i][0], pos[i][1]);
            for (var j = i + 1; j < pos.length; j++) {
                context.lineTo(pos[j][0], pos[j][1]);
            }
            context.stroke();
            */
            context.fillStyle = c.snakeFormat(a/4);
            for (var j = i + 1; j < pos.length; j++) {
                context.fillRect(pos[i][0], pos[i][1], Math.min(i/2+.8, 8), Math.min(i/2+.8, 8));
            }
        }
        context.restore();
    }
    
    var interval = setInterval(function() {
        context.clearRect(0, 0, width, height);
        for (var n = 0; n < booms.length; n++) {
            for (var i = 0; i < booms[n].length; i++) {
                var fire = booms[n][i];
                fire.move();
                drawGuide(fire.pos, fire.life/30, fire.c);
                if (fire.life <= 0) {
                    booms[n].splice(i, 1);
                }
            }
            if (!booms[n].length) {
                booms.splice(n, 1);
            }
        }
        if (!booms.length && firepassToggle) {
            canvas.style.visibility = "hidden";
            clearInterval(interval);
        }
        timer += 20;
        if (timer > 1000 && !firepassToggle) {
            createBoom(rnd(width/2)+width/4, rnd(height/2)+height/4);
            timer = 0;
        }
    }, 40);

}

$(function() {new firepass('#d13d73');});
