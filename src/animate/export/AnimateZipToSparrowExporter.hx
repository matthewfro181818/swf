package animate.export;

import animate.zip.AnimateZipLoader;
import openfl.Assets;
import openfl.display.MovieClip;

class AnimateZipToSparrowExporter
{
    public static function export(
        zipPath:String,
        symbol:String,
        outDir:String
    )
    {
        AnimateZipLoader.load(zipPath, "anim", function()
        {
            var mc:MovieClip = Assets.getMovieClip('anim:$symbol');
            if (mc == null)
                throw 'Missing symbol $symbol in ZIP';

            AnimateToSparrowExporter.export(symbol, outDir);
        });
    }
}
