package animate.zip;

import swf.exporters.animate.AnimateLibrary;
import lime.app.Future;
import openfl.utils.Assets;

class AnimateZipLoader
{
    public static function load(
        zipPath:String,
        libraryName:String,
        onComplete:Void->Void
    )
    {
        AnimateLibrary.loadFromFile(zipPath).onComplete(function(lib)
        {
            Assets.registerLibrary(libraryName, lib);
            onComplete();
        });
    }
}
