package {
    import flash.display.Sprite;

    public class DotLayer extends Sprite {
        public function DotLayer(color:uint, width:int, height:int) {
            var circleSize:int = 4;
            var circleSpace:int = 1;
            var d:int = circleSize + circleSpace;
            this.graphics.beginFill(color);
            for (var h:int = 0; h <= height; h += d) {
                for (var w:int = 0; w <= width; w += d) {
                    this.graphics.drawCircle(h / d % 2 ? w : w + d / 2, h, circleSize / 2);
                }
            }
            this.graphics.endFill();
        }
    }
}
