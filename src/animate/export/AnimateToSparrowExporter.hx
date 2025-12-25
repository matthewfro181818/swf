package animate.export;

import openfl.Assets;
import openfl.display.MovieClip;
import openfl.display.BitmapData;
import openfl.display.PNGEncoderOptions;
import sys.io.File;
import sys.FileSystem;

class AnimateToSparrowExporter
{
    public static function export(symbol:String, outDir:String)
    {
        var mc:MovieClip = Assets.getMovieClip(symbol);
        if (mc == null) throw 'Missing symbol $symbol';

        var framesDir = '$outDir/frames';
        FileSystem.createDirectory(framesDir);

        var frameInfo = AnimateFrameRasterizer.export(mc, framesDir);

        var frames = [];
        for (info in frameInfo)
        {
            var bmp = BitmapData.fromFile('$framesDir/${info.file}');
            frames.push({
                bmp: bmp,
                name: symbol + info.file.substr(5, 4),
                bounds: info.bounds
            });
        }

        var packed = SimpleAtlasPacker.pack(
            frames.map(f -> ({ bmp: f.bmp, name: f.name }))
        );

        var atlasPath = '$outDir/$symbol.png';
        File.saveBytes(
            atlasPath,
            packed.atlas.encode(packed.atlas.rect, new PNGEncoderOptions())
        );

        var xmlFrames = [];
        for (f in frames)
        {
            xmlFrames.push({
                name: f.name,
                rect: packed.rects.get(f.name),
                bounds: f.bounds
            });
        }

        SparrowXMLWriter.write(
            '$outDir/$symbol.xml',
            '$symbol.png',
            xmlFrames
        );
    }
}
