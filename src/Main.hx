class Main
{
    static function main()
    {
        var symbol = Sys.args()[0];
        var outDir = Sys.args()[1];

        if (symbol == null || outDir == null)
        {
            trace("Usage: export <symbolName> <outDir>");
            return;
        }

        AnimateToSparrowExporter.export(symbol, outDir);
        trace("Exported " + symbol);
    }
}
