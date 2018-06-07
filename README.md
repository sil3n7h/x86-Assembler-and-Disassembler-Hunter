# x86-Assembler-and-Disassembler-Hunter
Search a directory of binaries and dlls for a specific assembly code or hex string (Intel syntax).

__Usage:__\
__./aad_hunter.sh__ [-h] [-d directory] [-a assembly_command] [-b hex_value]

__Where:__\
    -h  show this help text\
    -d  directory that has files to search ex: /var/opt/\
    -a  assembly to search for ex: \"call esp\"\
    -b  hex to search for ex: \"ff d4\""

__Example (search for JMP ESP in WinAmp files winamp.exe and in_mp3.dll):__\
__./aad_hunter.sh__ -a "CALL ESP" -d /files/\
Searching for the following hex code:  ff d4\
in_mp3.dll\
 202d960:	e8 ff d4 ff ff       	call   0x202ae64\
winamp.exe

__Or:__

__./aad_hunter.sh__ -b "ffd4" -d /files/\
Searching for the following hex code:  ffd4\
in_mp3.dll\
 202d960:	e8 ff d4 ff ff       	call   0x202ae64\
winamp.exe
