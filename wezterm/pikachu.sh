#!/bin/bash
awk '
{
    n = length($0)

    out = ""
    for (i = 1; i <= n; i++) {
        c = substr($0, i, 1)
        if (c == "Y")
            out = out "\033[48;5;226m \033[0m"
        else if (c ~ /[$qubdP]/)
            out = out "\033[38;5;232m" c "\033[0m"
        else if (c == "#")
            out = out "\033[38;5;196m" c "\033[0m"
        else if (c ~ /[xX]/)
            out = out "\033[38;5;214m" c "\033[0m"
        else if (c ~ /[M]/)
            out = out "\033[38;5;130m" c "\033[0m"
        else
            out = out c
    }
    print out
}

# 以下のリンクを参照
# https://www.asciiart.eu/video-games/pokemon
' "$(dirname "$0")/pikachu.txt"
