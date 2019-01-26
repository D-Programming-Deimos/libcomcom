module test;

import std.stdio;
import libcomcom_wrapper;

void main(string[] args)
{
    // Tests
    libComComInitializer();
    scope(exit) libComComDestructor();

    assert(runCommand("cat", ["cat"], "qwe", 5000) == "qwe");

    {
        char[] buf = new char[1000000];
        for(int i=0; i<1000000; ++i)
            buf[i] = cast(char) (i % 3);
        assert(runCommand("cat", ["cat"], cast(const) buf, 5000) == buf);
    }

    {
        char[] buf = new char[1000000];
        for(int i=0; i<1000000; ++i)
            buf[i] = cast(char) (i % 3);
        string output = runCommand("dd",
                                   ["dd", "bs=100000", "count=10", "iflag=fullblock"],
                                   cast(const) buf,
                                   5000);
        assert(output == buf);
    }

    writeln("Tests passed.");
}
