package animate.export;

import openfl.geom.Rectangle;
import sys.io.File;

class SparrowXMLWriter
{
    public static function write(
        xmlPath:String,
        imageName:String,
        frames:Array<{ name:String, rect:Rectangle, bounds:Rectangle }>
    )
    {
        var out = '<TextureAtlas imagePath="$imageName">\n';

        for (f in frames)
        {
            out +=
                '  <SubTexture ' +
                'name="${f.name}" ' +
                'x="${Std.int(f.rect.x)}" ' +
                'y="${Std.int(f.rect.y)}" ' +
                'width="${Std.int(f.rect.width)}" ' +
                'height="${Std.int(f.rect.height)}" ' +
                'frameX="${-Std.int(f.bounds.x)}" ' +
                'frameY="${-Std.int(f.bounds.y)}" ' +
                'frameWidth="${Std.int(f.bounds.width)}" ' +
                'frameHeight="${Std.int(f.bounds.height)}"/>\n';
        }

        out += '</TextureAtlas>';
        File.saveContent(xmlPath, out);
    }
}
