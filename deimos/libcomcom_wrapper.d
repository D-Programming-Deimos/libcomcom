/*
 * libcomcom.d
 * Copyright (C) 2019 Victor Porton <porton@narod.ru>
 *
 * libcomcom is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * libcomcom is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.";
 */

module libcomcom_wrapper;

import std.string;
import std.algorithm.iteration : map;
import std.array : array;
import std.exception : ErrnoException;
import libcomcom;

string _runCommand(string file,
                   string[] argv,
                   const char** childEnvp,
                   string input,
                   int timeout = -1)
{
    const(char*) output;
    size_t output_len;
    const char*[] childArgv = map!toStringz(argv).array ~ null;
    immutable int res = libcomcom_run_command(input.ptr, input.length,
                                              &output, &output_len,
                                              file.toStringz, childArgv.ptr,
                                              childEnvp,
                                              timeout);
    if (res != 0) {
        throw new ErrnoException("Run command"); // TODO: Localization
    }
    import core.stdc.stdlib : free;
    scope(exit) free(cast(void*) output);
    return output[0..output_len].idup;
}

// `environ` is avail only on Unix, but libcomcom doesn't work on Windows anyway
private extern(C) extern __gshared const char** environ;

string runCommand(string file, string[] argv,string input, int timeout = -1) {
    return _runCommand(file, argv, environ, input, timeout);
}

string runCommandWithEnvironment(string file,
                                 string[] argv,
                                 string[] envp,
                                 string input,
                                 int timeout = -1)
{
    const char*[] childEnv = map!toStringz(envp).array ~ null;
    return _runCommand(file, argv, childEnv.ptr, input, timeout);
}

