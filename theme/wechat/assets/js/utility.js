var utility = {
    
    ms: {},
    
    mouse: function(e) {
        if (e) {
            this.ms.x = e.pageX;
            this.ms.y = e.pageY;
        } else {
            this.ms.x = e.x + document.body.scrollLeft;
            this.ms.y = e.y + document.body.scrollTop;
        };
        return this.ms;
    }
    
}

/*
window.addEventListener("load", function() {
    document.onmousemove = function(e) {
        utility.mouse(e);
    };
});
*/