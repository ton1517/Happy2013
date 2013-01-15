package {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.ProgressEvent;
    import flash.geom.Point;

    public class DrawingPanel extends Sprite {

        private const RECT_OFFSET:int = 3;
        private const SPACE:int = 10;

        private var _drawingColor:uint = 0x000000;
        private var _lineColor:uint = 0xc0c6c9;
        private var _lineSize:int = 12;

        private var _drawCount:int;
        private var _lines:Vector.<Vector.<Point>>;
        private var _line:Vector.<Point>;

        private var _stage:Stage;
        private var _maxLines:int;

        private var _baseCanvas:Sprite;
        private var _canvases:Vector.<Shape>;
        private var _canvas:Shape;

        private var _panelWidth:int;
        private var _panelHeight:int;

        public function DrawingPanel(stage:Stage, maxLines:int, width:int, height:int) {
            _stage=stage;
            _maxLines=maxLines;

            _panelWidth=width;
            _panelHeight=height;
            
            _baseCanvas = new Sprite();
            addChild(_baseCanvas);

            drawBaseLine();
            init();
        }
        
        public function get canvas():Sprite {
            return _baseCanvas;
        }

        public function get lineSize():int {
            return _lineSize;
        }

        public function set lineSize(value:int):void {
            _lineSize=value;
        }

        public function get lineColor():uint {
            return _lineColor;
        }

        public function set lineColor(value:uint):void {
            _lineColor=value;
        }

        public function get drawingColor():uint {
            return _drawingColor;
        }

        public function set drawingColor(value:uint):void {
            _drawingColor=value;
        }

        public function init():void {
            if (_canvases) {
                for (var i:int = 0; i < _canvases.length; i++) {
                    if (contains(_canvases[i]))
                        _baseCanvas.removeChild(_canvases[i]);
                }
            }
            _canvases=new Vector.<Shape>();
            _lines=new Vector.<Vector.<Point>>();
            _drawCount=0;

        }

        public function start():void {
            _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }

        public function stop():void {
            _stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }

        public function get lineLength():int {
            return lines.length;
        }

        public function get lines():Vector.<Vector.<Point>> {
            return _lines;
        }


        private function onMouseDown(e:MouseEvent):void {
            var x:Number = mouseX;
            var y:Number = mouseY;
            if (x >= RECT_OFFSET && x <= _panelWidth - RECT_OFFSET && y >= RECT_OFFSET && y <= _panelHeight - RECT_OFFSET) {
                _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
                _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
                _line=new Vector.<Point>();

                _canvas=new Shape();
                _baseCanvas.addChild(_canvas);
                _canvas.graphics.lineStyle(lineSize, drawingColor, 1);
                _canvas.graphics.moveTo(x, y);
            }
        }

        private function onMouseMove(e:MouseEvent):void {
            var x:Number = mouseX;
            var y:Number = mouseY;

            if (x < RECT_OFFSET) {
                x=RECT_OFFSET;
            } else if (x > _panelWidth - RECT_OFFSET) {
                x=_panelWidth - RECT_OFFSET;
            }

            if (y < RECT_OFFSET) {
                y=RECT_OFFSET;
            } else if (y > _panelHeight - RECT_OFFSET) {
                y=_panelHeight - RECT_OFFSET;
            }

            _line.push(this.localToGlobal(new Point(x, y)));
            _canvas.graphics.lineTo(x, y);
        }

        private function onMouseUp(e:MouseEvent):void {
            _stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            _stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

            var length:int = _line.length;

            if (length > 10 && length < 400) {
                _canvases.push(_canvas);
                _lines.push(_line);

                dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, lineLength, _maxLines));

                _drawCount++;
                if (_drawCount == _maxLines) {
                    stop();
                    dispatchEvent(new Event(Event.COMPLETE, false, false));
                }
            } else {
                _baseCanvas.removeChild(_canvas);
            }
        }

        private function drawBaseLine():void {
            graphics.lineStyle(1, lineColor);
            graphics.beginFill(lineColor, 0.01);
            graphics.drawRect(0, 0, _panelWidth, _panelHeight);

            graphics.lineStyle(0, lineColor, 0.2);
            var i:int;

            for (i=SPACE; i < _panelWidth; i+=SPACE) {
                graphics.moveTo(i, 0);
                graphics.lineTo(i, _panelHeight);
            }

            for (i=SPACE; i < _panelHeight; i+=SPACE) {
                graphics.moveTo(0, i);
                graphics.lineTo(_panelWidth, i);
            }

            graphics.endFill();
        }
    }
}
