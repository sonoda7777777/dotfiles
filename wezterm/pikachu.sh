#!/bin/bash
awk '
{
    n = length($0)

    # 各行の最初・最後の非スペース位置を検索
    first = 0; last = 0
    for (i = 1; i <= n; i++) {
        if (substr($0, i, 1) != " ") {
            if (first == 0) first = i
            last = i
        }
    }

    out = ""
    for (i = 1; i <= n; i++) {
        c = substr($0, i, 1)
        if (c == " " && i > first && i < last)
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
' "$(dirname "$0")/pikachu.txt"
