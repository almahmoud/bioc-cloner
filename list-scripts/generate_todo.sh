#!/bin/bash
# usage: bash list-scripts/generate_todo.sh
cd lists
lists=${1:-314}
todo=${2:-todo.txt}
ls $lists/* > $todo
cd ..
