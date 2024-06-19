#!/bin/bash

nasm -f bin game.asm -o game.com
dosbox -debug &