
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

var snakeGame = function() {

    //容器
    this.canvas = {
        canvas:  document.getElementById("canvas"),
        context: document.getElementById("canvas").getContext("2d"),
        grid: 20,  //格子大小
        gapX: 0,   //左右空隙
        gapY: 0,   //上下空隙
        /*
            //这些是运行中生成的变量
            width:   500, //容器宽度
            height:  500, //容器高度
            cwidth: 500,  //内容宽度
            cheight: 500, //内容高度
            rows: 0,      //行数
            cols: 0,      //列数
            marginX: 0,   //左边距
            marginY: 0    //上边距
        */
    };
    
    //设置
    this.options = {
        bgColor: '#F3F3F3',  //背景颜色
        bgLine: '#FFFFFF',   //背景网格
        styleHead: 'rgba(210,61,116,1)',   //蛇头颜色
        styleBody: 'rgba(210,61,116,{0})', //蛇身颜色
        styleExtra: '#EAD2CE',  //扩展颜色
        styleEyes: '#333333',   //蛇眼颜色
        styleEyeBall: '#EEEEEE', //眼珠颜色
        foodColor: '#8B718C',   //食物颜色
        foodFuzzy: '#8B718C',   //模糊颜色
        foodBlur: 10,           //模糊级数
        guideColor: '#B9AABA',  //辅助线
        direction: 2,           //移动方向 1:up 2:right 3:down 4:left
        speed: 400,             //移动速度
        maxSpeed: 300,          //限速数值
        blankRows: 2,           //前N行不做食物
        gameover: false,        //是否结束
        timerStart: new Date().getTime(), //初始化的时间
        scoreStep: 50,                    //分数增长频率
        score: 0                          //初始分数
    };
    
    //蛇身数据
    this.kaca = [
        {x:5, y:2, d:2},
        {x:4, y:2, d:2},
        {x:3, y:2, d:2},
        {x:2, y:2, d:2}
    ];
    
    //食物数据
    this.food = [
        {x:8, y:4}
    ];

    //popup
    this.popup = [];
}

snakeGame.prototype = {
    
    //初始化
    init: function(w, h) {
        var width  = window.innerWidth,
            height = window.innerHeight;
        if (w && h) {
            width  = w;
            height = h;
        }
        
        this.canvas.rows = Math.floor((width - this.canvas.gapX * 2) / this.canvas.grid);
        this.canvas.cols = Math.floor((height - this.canvas.gapY * 2) / this.canvas.grid);
        this.canvas.cwidth  = this.canvas.rows * this.canvas.grid + 1;
        this.canvas.cheight = this.canvas.cols * this.canvas.grid + 1;
        this.canvas.canvas.width  = width;
        this.canvas.canvas.height = height;
        this.canvas.marginX = Math.floor((width - this.canvas.cwidth) / 2);
        this.canvas.marginY = Math.floor((height - this.canvas.cheight) / 2);

        this.drawBackground();
        this.drawSnake();
        this.drawFood();
    },
    
    //画背景
    drawBackground: function() {
        var context = this.canvas.context,
            grid = this.canvas.grid,
            x = this.canvas.marginX,
            y = this.canvas.marginY;
        context.fillStyle = this.options.bgColor;
        context.fillRect(x, y, this.canvas.cwidth, this.canvas.cheight);
        for (var i = 0; i <= this.canvas.rows; i++) {
            context.beginPath();
            context.strokeStyle = this.options.bgLine;
            context.moveTo(x+0.5, this.canvas.marginY);
            context.lineTo(x+0.5, this.canvas.cheight + this.canvas.marginY);
            context.lineWidth = 1;
            context.stroke();
            x += grid;
        }
        for (var i = 0; i <= this.canvas.cols; i++) {
            context.beginPath();
            context.strokeStyle = this.options.bgLine;
            context.moveTo(this.canvas.marginX, y+0.5);
            context.lineTo(this.canvas.cwidth + this.canvas.marginX, y+0.5);
            context.lineWidth = 1;
            context.stroke();
            y += grid;
        }
    },
    
    //画蛇不添足,添个眼睛就好
    drawSnake: function() {
        var context = this.canvas.context,
            grid = this.canvas.grid,
            len = this.kaca.length,
            kacax,
            kacay,
            lastd;
        context.beginPath();
        for (var i = 0; i < len; i++) {
            kacax = this.kaca[i].x * grid + this.canvas.marginX;
            kacay = this.kaca[i].y * grid + this.canvas.marginY;
            //头
            if (i == 0) {
                //基本形
                context.shadowBlur = 0;
                context.fillStyle = this.options.styleHead;
                context.fillRect(kacax, kacay, grid, grid);
                //眼睛舌头
                switch(this.kaca[i].d) {
                    case 1:
                        context.fillRect(kacax + grid, kacay + grid/2, grid/4, grid/8);
                        context.fillStyle = this.options.styleBody.snakeFormat(0.8);
                        context.fillRect(kacax + grid, kacay + grid*0.4, grid/4, grid/8);
                        context.fillStyle = this.options.styleEyes;
                        context.fillRect(kacax + grid/3, kacay + grid*1/5, grid/3, grid/5);
                        context.fillRect(kacax + grid/3, kacay + grid*3/5, grid/3, grid/5);
                        context.fillStyle = this.options.styleEyeBall;
                        context.fillRect(kacax + grid*0.45, kacay + grid*1/4, grid/10, grid/10);
                        context.fillRect(kacax + grid*0.45, kacay + grid*2/3, grid/10, grid/10);
                        ////边框
                        /*
                        context.strokeStyle = this.options.styleExtra;
                        context.lineWidth = 2;
                        context.moveTo(kacax, kacay);
                        context.lineTo(kacax+grid, kacay);
                        context.lineTo(kacax+grid, kacay+grid);
                        context.stroke();
                        context.moveTo(kacax, kacay);
                        context.lineTo(kacax, kacay+grid);
                        context.stroke();
                        */
                        break;
                    case 2:
                        context.fillRect(kacax + grid/2, kacay + grid, grid/8, grid/4);
                        context.fillStyle = this.options.styleBody.snakeFormat(0.8);
                        context.fillRect(kacax + grid*0.4, kacay + grid, grid/8, grid/4);
                        context.fillStyle = this.options.styleEyes;
                        context.fillRect(kacax + grid*1/5, kacay + grid/3, grid/5, grid/3);
                        context.fillRect(kacax + grid*3/5, kacay + grid/3, grid/5, grid/3);
                        context.fillStyle = this.options.styleEyeBall;
                        context.fillRect(kacax + grid*1/4, kacay + grid*0.45, grid/10, grid/10);
                        context.fillRect(kacax + grid*2/3, kacay + grid*0.45, grid/10, grid/10);
                        ////边框
                        /*
                        context.strokeStyle = this.options.styleExtra;
                        context.lineWidth = 2;
                        context.moveTo(kacax, kacay);
                        context.lineTo(kacax+grid, kacay);
                        context.lineTo(kacax+grid, kacay+grid);
                        context.lineTo(kacax, kacay+grid);
                        context.stroke();
                        */
                        break;
                    case 3:
                        context.fillRect(kacax-grid/4, kacay + grid/2, grid/4, grid/8);
                        context.fillStyle = this.options.styleBody.snakeFormat(0.8);
                        context.fillRect(kacax-grid/4, kacay + grid*0.4, grid/4, grid/8);
                        context.fillStyle = this.options.styleEyes;
                        context.fillRect(kacax + grid/3, kacay + grid*1/5, grid/3, grid/5);
                        context.fillRect(kacax + grid/3, kacay + grid*3/5, grid/3, grid/5);
                        context.fillStyle = this.options.styleEyeBall;
                        context.fillRect(kacax + grid*0.45, kacay + grid*1/4, grid/10, grid/10);
                        context.fillRect(kacax + grid*0.45, kacay + grid*2/3, grid/10, grid/10);
                        ////边框
                        /*
                        context.strokeStyle = this.options.styleExtra;
                        context.lineWidth = 2;
                        context.moveTo(kacax, kacay);
                        context.lineTo(kacax, kacay+grid);
                        context.lineTo(kacax+grid, kacay+grid);
                        context.lineTo(kacax+grid, kacay);
                        context.stroke();
                        */
                        break;
                    case 4:
                        context.fillRect(kacax + grid/2, kacay-grid/4, grid/8, grid/4);
                        context.fillStyle = this.options.styleBody.snakeFormat(0.8);
                        context.fillRect(kacax + grid*0.4, kacay-grid/4, grid/8, grid/4);
                        context.fillStyle = this.options.styleEyes;
                        context.fillRect(kacax + grid*1/5, kacay + grid/3, grid/5, grid/3);
                        context.fillRect(kacax + grid*3/5, kacay + grid/3, grid/5, grid/3);
                        context.fillStyle = this.options.styleEyeBall;
                        context.fillRect(kacax + grid*1/4, kacay + grid*0.45, grid/10, grid/10);
                        context.fillRect(kacax + grid*2/3, kacay + grid*0.45, grid/10, grid/10);
                        ////边框
                        /*
                        context.strokeStyle = this.options.styleExtra;
                        context.lineWidth = 2;
                        context.moveTo(kacax, kacay);
                        context.lineTo(kacax, kacay+grid);
                        context.lineTo(kacax+grid, kacay+grid);
                        context.stroke();
                        context.moveTo(kacax, kacay);
                        context.lineTo(kacax+grid, kacay);
                        context.stroke();
                        */
                        break;
                }
            }
            //身
            else {
                lastd = this.kaca[i-1].d;
                //基本形
                context.shadowBlur = 0;
                context.fillStyle = this.options.styleBody.snakeFormat(1 - ( i / this.kaca.length ) * 0.4);
                context.fillRect(kacax, kacay, grid, grid);
                    ////边框
                    /*
                    context.strokeStyle = this.options.styleExtra;
                    context.lineWidth = 2;
                    //方向一致画两条平行线
                    if (lastd == this.kaca[i].d) {
                        if (lastd == 2 || lastd == 4) {
                            context.moveTo(kacax, kacay);
                            context.lineTo(kacax+grid, kacay);
                            context.stroke();
                            context.moveTo(kacax, kacay+grid);
                            context.lineTo(kacax+grid, kacay+grid);
                            context.stroke();
                            if ((i == len-1) && lastd == 2) {
                                context.moveTo(kacax, kacay);
                                context.lineTo(kacax, kacay+grid);
                                context.stroke();
                            } else if ((i == len-1) && lastd == 4) {
                                context.moveTo(kacax+grid, kacay);
                                context.lineTo(kacax+grid, kacay+grid);
                                context.stroke();
                            }
                        } else {
                            context.moveTo(kacax, kacay);
                            context.lineTo(kacax, kacay+grid);
                            context.stroke();
                            context.moveTo(kacax+grid, kacay);
                            context.lineTo(kacax+grid, kacay+grid);
                            context.stroke();
                            if ((i == len-1) && lastd == 1) {
                                context.moveTo(kacax, kacay+grid);
                                context.lineTo(kacax+grid, kacay+grid);
                                context.stroke();
                            } else if ((i == len-1) && lastd == 3) {
                                context.moveTo(kacax, kacay);
                                context.lineTo(kacax+grid, kacay);
                                context.stroke();
                            }
                        }
                    }
                    //不一致则按方向画
                    else {
                        if ((this.kaca[i].d == 4 && lastd == 1) || (this.kaca[i].d == 3 && lastd == 2)) {
                            context.moveTo(kacax, kacay);
                            context.lineTo(kacax, kacay+grid);
                            context.lineTo(kacax+grid, kacay+grid);
                            context.stroke();
                            if ((i == len-1) && (this.kaca[i].d == 3 && lastd == 2)) {
                                context.moveTo(kacax, kacay);
                                context.lineTo(kacax+grid, kacay);
                                context.stroke();
                            } else if ((i == len-1) && (this.kaca[i].d == 4 && lastd == 1)) {
                                context.moveTo(kacax+grid, kacay);
                                context.lineTo(kacax+grid, kacay+grid);
                                context.stroke();
                            }
                        } else if ((this.kaca[i].d == 2 && lastd == 1) || (this.kaca[i].d == 3 && lastd == 4)) {
                            context.moveTo(kacax, kacay+grid);
                            context.lineTo(kacax+grid, kacay+grid);
                            context.lineTo(kacax+grid, kacay);
                            context.stroke();
                            if ((i == len-1) && (this.kaca[i].d == 3 && lastd == 4)) {
                                context.moveTo(kacax, kacay);
                                context.lineTo(kacax+grid, kacay);
                                context.stroke();
                            } else if ((i == len-1) && (this.kaca[i].d == 2 && lastd == 1)) {
                                context.moveTo(kacax, kacay);
                                context.lineTo(kacax, kacay+grid);
                                context.stroke();
                            }
                        } else if ((this.kaca[i].d == 1 && lastd == 4) || (this.kaca[i].d == 2 && lastd == 3)) {
                            context.moveTo(kacax, kacay);
                            context.lineTo(kacax+grid, kacay);
                            context.lineTo(kacax+grid, kacay+grid);
                            context.stroke();
                            if ((i == len-1) && (this.kaca[i].d == 2 && lastd == 3)) {
                                context.moveTo(kacax, kacay);
                                context.lineTo(kacax, kacay+grid);
                                context.stroke();
                            } else if ((i == len-1) && (this.kaca[i].d == 1 && lastd == 4)) {
                                context.moveTo(kacax, kacay+grid);
                                context.lineTo(kacax+grid, kacay+grid);
                                context.stroke();
                            }
                        } else if ((this.kaca[i].d == 4 && lastd == 3) || (this.kaca[i].d == 1 && lastd == 2)) {
                            context.moveTo(kacax, kacay);
                            context.lineTo(kacax+grid, kacay);
                            context.stroke();
                            context.moveTo(kacax, kacay);
                            context.lineTo(kacax, kacay+grid);
                            context.stroke();
                            if ((i == len-1) && (this.kaca[i].d == 4 && lastd == 3)) {
                                context.moveTo(kacax+grid, kacay);
                                context.lineTo(kacax+grid, kacay+grid);
                                context.stroke();
                            } else if ((i == len-1) && (this.kaca[i].d == 1 && lastd == 2)) {
                                context.moveTo(kacax, kacay+grid);
                                context.lineTo(kacax+grid, kacay+grid);
                                context.stroke();
                            }
                        }
                    }
                    */
            }
        }
    },

    //画食物
    drawFood: function() {
        var context = this.canvas.context,
            grid = this.canvas.grid,
            foodx,
            foody;
        for (var i = 0; i < this.food.length; i++) {
            foodx = this.food[i].x * grid + this.canvas.marginX;
            foody = this.food[i].y * grid + this.canvas.marginY;
            context.beginPath();
            context.arc(foodx+grid/2, foody+grid/2, grid*0.4, 0, 2*Math.PI);
            context.fillStyle = this.options.foodColor;
            context.shadowBlur = this.options.foodBlur;
            context.shadowColor = this.options.foodFuzzy;
            context.fill();
            context.strokeStyle = this.options.foodColor;
            context.stroke();
            context.closePath();
        }
    },

    //画辅助线
    drawFoodGuide: function() {
        var context = this.canvas.context,
            grid = this.canvas.grid,
            guidex,
            guidey;
        for (var i = 0; i < this.food.length; i++) {
            guidex = this.food[i].x * grid + this.canvas.marginX + grid/2;
            guidey = this.food[i].y * grid + this.canvas.marginY + grid/2;
            for (var x = 0; x < this.canvas.rows; x++) {
                context.shadowBlur = 0;
                context.fillStyle = this.options.guideColor;
                context.fillRect(x*grid+this.canvas.marginX+grid/2-grid/20, guidey, grid / 16, grid / 16);
            }
            for (var y = 0; y < this.canvas.cols; y++) {
                context.shadowBlur = 0;
                context.fillStyle = this.options.guideColor;
                context.fillRect(guidex, y*grid+this.canvas.marginY+grid/2-grid/20, grid / 16, grid / 16);
            }
        }
    },
    
    //生成食物/吃食物
    checkFood: function(index) {
        if (index >= 0) {
            this.options.score += this.options.scoreStep + (400-this.options.speed) + parseInt(10 * Math.random());
            this.food.splice(index, 1);
            this.options.speed -= 15;
            this.options.speed = Math.max(this.options.maxSpeed, this.options.speed);
            snakeMusic.eatFood();
            fireworks(this.options.styleBody);
        }
        var o = true,
            x = Math.floor(Math.random() * this.canvas.rows),
            y = Math.max(this.options.blankRows+1, Math.floor(Math.random() * this.canvas.cols));
        for (var i = 0; i < this.kaca.length; i++) {
            if (this.kaca[i].x == x && this.kaca[i].y == y) {
                o = false;
            }
        }
        for (var i = 0; i < this.food.length; i++) {
            if (this.food[i].x == x && this.food[i].y == y) {
                o = false;
            }
        }
        if (o == true) {
            this.food.push({x:x, y:y});
        } else if (this.kaca.length >= this.canvas.rows * (this.canvas.cols-this.options.blankRows)) {
            alert('You are brilliant!');
        } else {
            this.checkFood(-1);
        }
    },

    //*蛇移动
    move: function() {
        if (this.options.gameover) return ;
        //吃食物
        for (var i = 0; i < this.food.length; i++) {
            if (this.food[i].x == this.kaca[0].x && this.food[i].y == this.kaca[0].y) {
                this.checkFood(i);
                this.kaca.push({
                        x: this.kaca[this.kaca.length - 1].x - 1,
                        y: this.kaca[this.kaca.length - 1].y,
                        d: this.kaca[this.kaca.length - 1].d
                    });
            }
        }
        this.kaca.splice(this.kaca.length - 1, 1);
        switch(this.options.direction) {
            case 1:
                this.kaca.unshift({x:this.kaca[0].x, y:this.kaca[0].y - 1, d:this.options.direction});
                break;
            case 2:
                this.kaca.unshift({x:this.kaca[0].x + 1, y:this.kaca[0].y, d:this.options.direction});
                break;
            case 3:
                this.kaca.unshift({x:this.kaca[0].x, y:this.kaca[0].y + 1, d:this.options.direction});
                break;
            case 4:
                this.kaca.unshift({x:this.kaca[0].x - 1, y:this.kaca[0].y, d:this.options.direction});
                break;
        }
    },
    
    //*检测
    check: function() {
        if (this.options.gameover) return ;
        //超出边界
        if (this.options.direction == 1 && this.kaca[0].y < 0) {
            this.gameover();return;
            this.kaca[0].y = this.canvas.cols - 1;
        }
        if (this.options.direction == 2 && (this.kaca[0].x > this.canvas.rows - 1)) {
            this.gameover();return;
            this.kaca[0].x = 0;
        }
        if (this.options.direction == 3 && (this.kaca[0].y > this.canvas.cols - 1)) {
            this.gameover();return;
            this.kaca[0].y = 0;
        }
        if (this.options.direction == 4 && this.kaca[0].x < 0) {
            this.gameover();return;
            this.kaca[0].x = this.canvas.rows - 1;
        }
        //头跟任何身体碰撞，游戏结束
        for (var i = 1; i < this.kaca.length; i++) {
            if (this.kaca[0].x == this.kaca[i].x && this.kaca[0].y == this.kaca[i].y) {
                this.gameover();return;
            }
        }
    },

    //*循环执行
    loop: function() {
        if (this.options.gameover) return ;
        this.canvas.canvas.width  = this.canvas.canvas.width;
        this.canvas.canvas.height = this.canvas.canvas.height;
        this.drawBackground();
        this.drawFoodGuide();
        this.drawFood();
        this.drawSnake();
    },
    
    //转换方向
    direction: function(direction) {
        switch(direction) {
            case 1:
            case 'up':
                if (this.options.direction != 3) {
                    this.options.direction = 1;
                }
                break;
            case 2:
            case 'right':
                if (this.options.direction != 4) {
                    this.options.direction = 2;
                }
                break;
            case 3:
            case 'down':
                if (this.options.direction != 1) {
                    this.options.direction = 3;
                }
                break;
            case 4:
            case 'left':
                if (this.options.direction != 2) {
                    this.options.direction = 4;
                }
                break;
        }
        //防止手速太快引起蛇头回头
        if (Math.abs(this.kaca[0].d-this.options.direction) == 2) {
            this.options.direction = this.kaca[0].d;
        }
    },
    
    //结束
    gameover: function() {
        //alert('Game Over');
        this.options.gameover = true;
        snakeMusic.bgSound(false);
        
        //判断客户端
        /*
        if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
            $('#ios').show();
            $('#ioshref').attr('href',  "/wechat/snake/over?wid="+snakeWid+"&token="+snakeToken+"&score="+this.options.score);
        } else if (/(Android)/i.test(navigator.userAgent)) {

            window.location.href = "/wechat/snake/over?wid="+snakeWid+"&token="+snakeToken+"&score="+this.options.score;
        } else {
            window.location.href = "/wechat/snake/over?wid="+snakeWid+"&token="+snakeToken+"&score="+this.options.score;
        };
        
        //window.location.href = "/wechat/snake/over?wid="+snakeWid+"&token="+snakeToken+"&score="+this.options.score;
        */
        //根据分数处理跳转链接
        
        $.ajax({
            type: "POST",
            url: "/api/snake/score?format=json",
            data: {wid:snakeWid,token:snakeToken,score:this.options.score},
            dataType: "json",
            success: function(data){
                if (data.data != 'ERROR') {
                    //判断客户端
                    if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
                        $('#ios').show();
                        $('#ioshref').attr('href',  "/wechat/snake/over");
                    } else if (/(Android)/i.test(navigator.userAgent)) {
                        window.location.href = "/wechat/snake/over";
                    } else {
                        window.location.href = "/wechat/snake/over";
                    };
                } else {
                    alert('非法请求');
                }
            }
        });
        

    },
    
    //保存为图片
    toImage: function(download) {
        this.canvas.context.font = "normal 30px snake,impact";
        this.canvas.context.fillStyle = this.options.styleHead;
        this.canvas.context.textBaseline = "top";
        this.canvas.context.fillText(this.options.score, this.canvas.marginX+10, this.canvas.marginY+10);
        if (download) {
            var image = this.canvas.canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
            window.location.href = image;
        } else {
            return this.canvas.canvas.toDataURL("image/png");
        }
    }

}


//音效
var snakeMusic = {
    
    toggle: true,
    
    init: function() {
        this.audioBackground = document.getElementById("audio-background");
        this.audioEat = document.getElementById("audio-eat");
        this.audioFireworks = document.getElementById("audio-fireworks");
        this.audioSuccessful = document.getElementById("audio-successful");
        this.audioFailed = document.getElementById("audio-failed");
        if (this.audioBackground) {
            this.audioBackground.volume = 0.2;
        }
    },
    
    bgSound: function(flag) {
        if (this.toggle && flag && this.audioBackground) {
            this.audioBackground.play();
        } else if (this.audioBackground) {
            this.audioBackground.pause();
        }
    },
    
    eatFood: function() {
        if (this.toggle && this.audioEat) {
            this.audioEat.play();
            this.audioEat.volume = 0.4;
        }
    },
    
    fireBoom: function() {
        if (this.toggle && this.audioFireworks) {
            this.audioFireworks.play();
            this.audioFireworks.volume = 0.8;
        }
    },
    
    successful: function() {
        if (this.toggle && this.audioSuccessful) {
            this.audioSuccessful.play();
        }
    },
    
    failed: function() {
        if (this.toggle && this.audioFailed) {
            this.audioFailed.play();
        }
    },
    
    stop: function() {
        this.toggle = false;
        this.bgSound(false);
    },
    
    start: function() {
        this.toggle = true;
        this.bgSound(true);
    }

}

//烟花效果
var fireworks = function(color) {
    
    var width  = window.innerWidth,
        height = window.innerHeight;

    //爆炸点数据
    var booms = [];
    
    var canvas  = document.getElementById("fireworks"),
        context = document.getElementById("fireworks").getContext("2d");
    
    canvas.width = width;
    canvas.height = height;
    
    //创建烟火
    function createFire(x, y, c) {
        return {
           x:x,
           y:y,
           c:c,
           life: 30 + rnd(30),
           pos: [],
           dx: rnd(20) - 10,
           dy: rnd(16) - 7,
           move: function() {
                this.dx *= .98;
                this.dy *= .98;
                this.dy += .42;
                this.x += this.dx + this.dx/this.x;
                this.y += this.dy + this.dy/this.y;
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
        for (var i = 0; i < rnd(24) + 8; i++) {
            tmp.push(createFire(x, y, color));
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
            context.strokeStyle = c.snakeFormat(a/4);
            context.lineWidth = Math.min(i+0.5, 3);
            context.lineCap = "round";
            context.moveTo(pos[i][0], pos[i][1]);
            for (var j = i + 1; j < pos.length; j++) {
                context.lineTo(pos[j][0], pos[j][1]);
            }
            context.stroke();
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
        if (!booms.length) {
            canvas.style.visibility = "hidden";
            clearInterval(interval);
        }
    }, 20);

    createBoom(rnd(width/4)+width*0.4, rnd(height/8)+height*0.15);
    snakeMusic.fireBoom();

}
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
    function createFire(x, y, c) {
        return {
           x:x,
           y:y,
           c:c,
           life: 30 + rnd(30),
           pos: [],
           dx: rnd(20) - 10,
           dy: rnd(16) - 7,
           move: function() {
                this.dx *= .98;
                this.dy *= .98;
                this.dy += .42;
                this.x += this.dx + this.dx/this.x;
                this.y += this.dy + this.dy/this.y;
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
        for (var i = 0; i < rnd(24) + 8; i++) {
            tmp.push(createFire(x, y, color));
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
            context.strokeStyle = c.snakeFormat(a/4);
            context.lineWidth = Math.min(i+0.5, 3);
            context.lineCap = "round";
            context.moveTo(pos[i][0], pos[i][1]);
            for (var j = i + 1; j < pos.length; j++) {
                context.lineTo(pos[j][0], pos[j][1]);
            }
            context.stroke();
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
            createBoom(rnd(width/2)+width/4, rnd(height/8));
            //snakeMusic.fireBoom();
            timer = 0;
        }
    }, 20);

}

var snake = new snakeGame();
function snakeLoop() {
    snake.move();
    snake.check();
    snake.loop();
    snake.interval = setTimeout(snakeLoop, snake.options.speed);
}
function snakeStart() {
    clearTimeout(snake.interval);
    snakeLoop();
}
function snakePause() {
    clearTimeout(snake.interval);
}
