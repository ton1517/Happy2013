package {
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    
    import a24.tween.Tween24;
    
    public class NavigationButton extends Sprite {
        
        private var _text:String;
        private var _size:int;
        private var _left:Boolean;
        
        private const BUTTON_OFFSET:int = 3;
        
        private const UP_COLOR:uint = 0x333333;
        
        public function NavigationButton(text:String, size:int, left:Boolean = true) {
            this._text = text;
            this._size = size;
            this._left = left;
            
            var state:DisplayObject = createState(UP_COLOR);
            addChild(state);
            var hitState:DisplayObject = createHitState();
            hitState.alpha = 0;
            addChild(hitState);
            
            buttonMode = true;
            useHandCursor = true;
            
            addEventListener(MouseEvent.MOUSE_OVER, onOver);
            addEventListener(MouseEvent.CLICK, onClick);
        }
        
        private function createState(color:uint):Sprite {
            var state:Sprite = new Sprite();
            
            var txt:TextField = new TextField();
            txt.autoSize = TextFieldAutoSize.LEFT;
            txt.selectable = false;
            txt.defaultTextFormat = new TextFormat("_sans", _size, color);
            txt.text = _text;
            txt.y = -2;
            
            if (Capabilities.os.indexOf("Mac") != -1)
                txt.y += 4;
            
            state.addChild(txt);
            
            var mark:Shape = createButtonMark(color);
            mark.y = txt.height / 2;
            state.addChild(mark);
            
            if (_left) {
                mark.x = mark.width / 2;
                txt.x = mark.width + BUTTON_OFFSET;
            } else {
                mark.scaleX = -1;
                mark.x = txt.width + BUTTON_OFFSET + mark.width / 2;
            }
            
            return state;
        }
        
        private function createHitState():Sprite {
            var state:Sprite = createState(UP_COLOR);
            var rect:Rectangle = state.getBounds(this);
            
            var hitState:Sprite = new Sprite();
            hitState.graphics.beginFill(0);
            hitState.graphics.drawRect(0, 0, rect.width, rect.height);
            hitState.graphics.endFill();
            
            return hitState;
        }
        
        private function createButtonMark(color:uint):Shape {
            var mark:Shape = new Shape();
            with(mark.graphics) {
                beginFill(color);
                drawCircle(0, 0, 18);
                moveTo(3, -8);
                lineTo(-6, 0);
                lineTo(3, 8);
                endFill();           
            }
            
            return mark;
        }
        
        private function onOver(e:MouseEvent):void {
            Tween24.serial(
                Tween24.tween(this, 0.05).bright(1),
                Tween24.tween(this, 0.05).bright(0)
            ).play();
        }
        
        private function onClick(e:MouseEvent):void {
            Tween24.serial(
                Tween24.tween(this, 0.05).bright(1),
                Tween24.tween(this, 0.05).bright(0)
            ).play();
        }
    }
}