# x86-Assembler-and-Disassembler-Hunter
Search a directory of binaries and dlls for a specific assembly code or hex string (Intel syntax)

Usage:
./aad_hunter.sh [-h] [-d directory] [-a assembly_command] [-b hex_value]

where:
    -h  show this help text
    -d  directory that has files to search ex: /var/opt/
    -a  assembly to search for ex: \"call esp\"
    -b  hex to search for ex: \"ff d4\""

Example (search for JMP ESP in WinAmp files winamp.exe and in_mp3.dll):
./aad_hunter.sh -a "CALL ESP" -d /files/
Searching for the following hex code:  ff d4
in_mp3.dll
 202d960:	e8 ff d4 ff ff       	call   0x202ae64
winamp.exe

Alternatively...
./aad_hunter.sh -b "ffd4" -d /files/
Searching for the following hex code:  ffd4
in_mp3.dll
 202d960:	e8 ff d4 ff ff       	call   0x202ae64
winamp.exe
