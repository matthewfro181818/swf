package swf.exporters;

class AnimateFrameRasterizer
{
    public static function export(
        mc:MovieClip,
        outDir:String
    )
    {
        FileSystem.createDirectory(outDir);

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

            File.saveBytes(
                '$outDir/frame_${StringTools.lpad("" + i, "0", 4)}.png',
                bmp.encode(bmp.rect, new PNGEncoderOptions())
            );
        }
    }
}
