#!/bin/sh

if [ "$#" -eq  3 ];
then
   find ./$1 -type f \( -iname \*.rb  \)  | xargs fgrep -n -i "$2" 2>/dev/null | fgrep -n "$3" 2>/dev/null > "code_find_rb_\"$2\"_\"$3\"".txt
else
   find ./$1 -type f \( -iname \*.rb  \)  | xargs fgrep -n -i "$2" 2>/dev/null > "code_find_rb_\"$2\"".txt
fi
