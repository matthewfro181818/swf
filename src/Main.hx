class Main
{
    static function main()
    {
        var args = Sys.args();

        if (args.length < 3)
        {
            trace("Usage:");
            trace("  export <animate.zip> <symbolName> <outDir>");
            return;
        }

        var zip = args[0];
        var symbol = args[1];
        var outDir = args[2];

        animate.export.AnimateZipToSparrowExporter.export(
            zip,
            symbol,
            outDir
        );
    }
}
