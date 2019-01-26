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
        for(int i=0; i<buf.sizeof; ++i)
            buf[i] = (cast(char)i) % 3;
        assert(runCommand("cat", ["cat"], cast(string) buf, 5000) == buf);
    }

    {
        char[] buf = new char[1000000];
        for(int i=0; i<buf.sizeof; ++i)
            buf[i] = (cast(char)i) % 3;
        string output = runCommand("dd",
                                   ["dd", "bs=100000", "count=10", "iflag=fullblock"],
                                   cast(string) buf,
                                   5000);
        assert(output == buf);
    }

    writeln("Tests passed.");
}
