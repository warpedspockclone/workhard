#!/bin/bash
#TODO: add input options for speed, type of characters
#TODO: add colors to output
#use ascii 21-79, 100-179

function buildSpaces {
local ct=0
local sp=""
local space=" "
while [ $ct -lt $1 ];
do
  sp="${sp}${space}"
  ((ct = ct + 1))
done
echo "${sp}"
} #12

function buildWord {
local ct=0
local wd=""
while [ $ct -lt $1 ];
do
  char=$((21 + RANDOM % 158))
  if [[ char -gt 79 && char -lt 100 ]] ; then
    ((char = char / 2))
  fi  
  wd="${wd}\u${char}" #concat random char to current word
  ((ct = ct + 1))
done
echo "${wd}" #return word
} #25

function buildLine {
local col2go=$((6 + RANDOM % $1)) #how many columns to write
local leadingSpaces=$((RANDOM % ( col2go / 6 ) )) #how many leading spaces
((col2go = col2go - leadingSpaces)) #characters to go needs to deduct spaces
local line1="$(buildSpaces $leadingSpaces)" #set line1 to empty spaces
while [ $col2go -gt 0 ];
do
  n=$((1 + RANDOM % ${col2go})) #compute size of word to generate
  line1="${line1} $(buildWord ${n})" #concatenate word to line
  ((col2go = col2go - n - 1)) #decrement
done
echo "${line1}" #return
} 

#lineNum=1
while true 
do
COLUMNS="$(tput cols)" #find size of window each loop in case of resize
((COLUMNS = COLUMNS - 10)) #let us back off a few characters
word="$(buildLine $COLUMNS)" #get the line
echo -e "${word}" #output it
#((lineNum = lineNum + 1))
waiting=$((RANDOM % 500))
sleep ".${waiting}s" #make this configurable, sleep so it looks like there is processing time
done #57

