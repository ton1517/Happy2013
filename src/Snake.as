package {
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class Snake extends Sprite {
        private static const PI_2:Number = Math.PI / 2;

        private var _line:Vector.<Point>;
        private var _toLine:Vector.<Point>;
        private var _routePoints:Vector.<Point> = new Vector.<Point>();
        private var _edge:Vector.<Point>;
        private var _color:uint;
        private var _thickness:Number;

        private var _vx:Number;
        private var _vy:Number;
        private var _rad:Number;

        private var _radInc:Number = 20 * Math.PI / 180;
        private var _sinRad:Number = 0;

        private var _snakeWidth:Number = 4;
        
        private var _completed:Boolean = false;

        public function Snake(fromLine:Vector.<Point>, toLine:Vector.<Point>, color:uint, thickness:Number) {
            _line = new Vector.<Point>();
            for (var i:int = 0; i < fromLine.length;i++){
                _line.push(fromLine[i].clone());
            }
            _toLine = toLine;
            _color = color;
            _thickness = thickness;

            _edge = calcEdge(_line, _thickness);
            
            var p1:Point, p2:Point;
            if(_toLine) {
               p1 = toLine[0];
               p2 = _line[_line.length - 1];
            } else {
                p1 = _line[_line.length - 1];
                p2 = _line[_line.length - 3];
            }
            
            var dx:Number = p1.x - p2.x;
            var dy:Number = p1.y - p2.y;
            _rad = Math.atan2(dy, dx);
            _vx = 5 * Math.cos(_rad);
            _vy = 5 * Math.sin(_rad);
            
            if(_toLine) {
                calcRoute();
            }
        }
        
        public function get completed():Boolean
        {
            return _completed;
        }

        public function get thickness():Number {
            return _thickness;
        }

        public function set thickness(value:Number):void {
            _thickness = value;
            draw();
        }

        public function get color():uint {
            return _color;
        }

        public function set color(value:uint):void {
            _color = value;
            draw();
        }

        public function get line():Vector.<Point> {
            return _line;
        }

        public function set line(value:Vector.<Point>):void {
            _line = value;
        }

        private function calcEdge(line:Vector.<Point>, thickness:Number):Vector.<Point> {
            var j:int;
            var p1:Point;
            var p2:Point;
            var np:Point;

            var nowThickness:Number = 0.1;

            var edge1:Vector.<Point> = new Vector.<Point>();
            var edge2:Vector.<Point> = new Vector.<Point>();
            
            for (j = 0; j < line.length - 4; j++) {
                p1 = line[j];
                p2 = line[j + 1];

                edge1.push(calcPoint(p1, p2, nowThickness));
                edge2.push(calcPoint(p2, p1, nowThickness));

                if (j < (line.length / 4)) {
                    nowThickness += thickness / (line.length / 4);
                } else {
                    nowThickness = thickness;
                }

            }

            p1 = line[line.length - 4];
            p2 = line[line.length - 2];
            nowThickness += nowThickness / 2;
            edge1.push(calcPoint(p1, p2, nowThickness));
            edge2.push(calcPoint(p2, p1, nowThickness));

            edge1.push(line[line.length-1]);

            return edge1.concat(edge2.reverse());
        }

        private function calcPoint(p1:Point, p2:Point, thickness:Number):Point {
            var dx:Number = p1.x - p2.x;
            var dy:Number = p1.y - p2.y;
            var centerP:Point = new Point((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);

            var angle:Number = Math.atan2(dy, dx);
            angle += PI_2;

            centerP.x += thickness * Math.cos(angle);
            centerP.y += thickness * Math.sin(angle);

            return centerP;
        }
        
        private function calcRoute():void
        {
            var head:Point = _line[_line.length - 1];
            var newHead:Point;
            
            var dist:Number = Point.distance(head, _toLine[0]);
            var prevDist:Number = dist + 1;
            
            while(dist < prevDist) {
                newHead = nextPoint(head);
                _routePoints.push(newHead);
                head = newHead.clone();
                
                prevDist = dist;
                dist = Point.distance(head, _toLine[0]);
            }
            
            _routePoints = _routePoints.concat(_toLine).reverse(); 
        }
        
        private function nextPoint(head:Point):Point {
             var newHead:Point = head.clone();
            _sinRad += _radInc;
            newHead.x += _vx + _snakeWidth * Math.sin(_sinRad) * Math.cos(_rad + PI_2);
            newHead.y += _vy + _snakeWidth * Math.sin(_sinRad) * Math.sin(_rad + PI_2);           
            
            return newHead;
        }
        
        public function move():void {
            if(_toLine && (!_routePoints || !_routePoints.length)){
                _completed = true;
                return ;
            }
            
             _line.shift();
            
             var newHead:Point;
             
             if(_toLine && _routePoints && _routePoints.length) {
                 newHead = _routePoints.pop();
            } else {
                newHead = nextPoint(_line[_line.length-1]);
            }
            _line.push(newHead);
           
            draw();
        }
        
        public function draw():void {
             _edge = calcEdge(_line, _thickness);

            graphics.clear();

            graphics.beginFill(color);

            var first:Point = _edge[0];
            graphics.moveTo(first.x, first.y);

            for (var j:int = 1; j < _edge.length; j++) {
                graphics.lineTo(_edge[j].x, _edge[j].y);
            }

            graphics.lineTo(first.x, first.y);           
            graphics.endFill();
            
        }
        
        public function containsRect(rect:Rectangle):Boolean {
            return rect.containsPoint(_line[0]) || rect.containsPoint(_line[_line.length-1]);
        }
    }
}