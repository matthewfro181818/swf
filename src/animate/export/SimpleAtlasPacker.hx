package animate.export;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Point;

class SimpleAtlasPacker
{
    public static function pack(
        frames:Array<{ bmp:BitmapData, name:String }>
    ):{
        atlas:BitmapData,
        rects:Map<String, Rectangle>
    }
    {
        var width = 0;
        var height = 0;

        for (f in frames)
        {
            width = Std.int(Math.max(width, f.bmp.width));
            height += f.bmp.height;
        }

        var atlas = new BitmapData(width, height, true, 0x00000000);
        var rects = new Map<String, Rectangle>();

        var y = 0;
        for (f in frames)
        {
            atlas.copyPixels(
                f.bmp,
                f.bmp.rect,
                new Point(0, y)
            );

            rects.set(
                f.name,
                new Rectangle(0, y, f.bmp.width, f.bmp.height)
            );

            y += f.bmp.height;
        }

        return { atlas: atlas, rects: rects };
    }
}
