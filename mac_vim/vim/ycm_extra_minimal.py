import os

def FlagsForFile( filename, **kwargs ):
    _,ext = os.path.splitext(filename);
    if(ext == ".cpp" or ext == ".cc" or ext == ".hpp"):
        return { 'flags': ['-std=gnu++17'], 'do_cache': False }
    return { 'flags': [], 'do_cache': False }
