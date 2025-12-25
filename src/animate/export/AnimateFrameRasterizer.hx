package animate.export;

import openfl.display.MovieClip;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.display.PNGEncoderOptions;
import sys.FileSystem;
import sys.io.File;

class AnimateFrameRasterizer
{
    public static function export(
        mc:MovieClip,
        outDir:String
    ):Array<{ file:String, bounds:Rectangle }>
    {
        FileSystem.createDirectory(outDir);

        var results = [];

        for (i in 0...mc.totalFrames)
        {
            mc.gotoAndStop(i + 1);

            var bounds = mc.getBounds(mc);

            bounds.x = Math.floor(bounds.x);
            bounds.y = Math.floor(bounds.y);
            bounds.width  = Math.ceil(bounds.width);
            bounds.height = Math.ceil(bounds.height);

            var bmp = new BitmapData(
                Std.int(bounds.width),
                Std.int(bounds.height),
                true,
                0x00000000
            );

            var m = new Matrix();
            m.translate(-bounds.x, -bounds.y);

            bmp.draw(mc, m, null, null, null, false);

            var name = 'frame_${StringTools.lpad("" + i, "0", 4)}.png';
            var path = '$outDir/$name';

            File.saveBytes(path, bmp.encode(bmp.rect, new PNGEncoderOptions()));

            results.push({
                file: name,
                bounds: bounds
            });
        }

        return results;
    }
}
