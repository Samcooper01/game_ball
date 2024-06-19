# Game Ball

**Game Ball** is a simplified version of the well known pong game written in nasm syntax x86-32 assembly language. The game runs in a MS-DOS emulator called DOSbox.

## Game Rules
- Don't let the ball go below the top of the white paddle at the bottom of the screen.
- Move the paddle left and right with the arrow keys.
- Once all the blocks in a row have been hit you will move on to the next row and once both rows and hit with the ball you win the game.
- Follow directions on screen to start, restart, and complete the game.

## Launching the game in DOSbox

- To play **Game Ball** first you need to install and setup DOSbox. The link to the official website where you can download and install the emulator is available below.
```
https://www.dosbox.com/download.php?main=1
```
- Once the emulator is installed, open  ```~/.dosbox/dosbox*.conf``` in a text editor and insert the following at line 249:
```
mount c <THE PATH TO THE REPO>/game_ball
C:
GAME.COM
```
- In the carrot brackets labeled ```<THE PATH TO THE REPO>``` insert the path to this cloned repository
- Now that all of this is setup to play the game run the bash script provided ```build.sh```
```
./build.sh
```
- This will build the .com binary and load dosbox, if you inserted the previous steps lines correctly at line 249 dosbox will automatically boot the game.
- There is a video attached with a full demo on this process if any steps were missed

### Build Dependency List

- NASM: https://nasm.us/

## Code Summary
- Initialization
  The first section of code initializes the backboard and all of the global variables declared in the .bss section. As well, it prompts the user to start the game
- Game State 1
  The second state, game state 1, is the first row of the game. The program waits until the user has hit the ball into each block in the first row available until advancing to the final state. If the user misses the ball and it goes past the paddle. The game is over.
- Game State 2
  The third state, game state 2, is the final state of the game. In the transition from Game State 1 to 2 the program erases row 1 and leaves the user with the final row. Same as the last state, if the user missess the ball and it goes past the paddle, the game is over. Once all the blocks in this row have been hit the user is prompted with a YOU WIN message. At this point the user can decide if they want to play again.
- The graphics are generated using DOS bios interrupts, which take register values as parameters. Specifically, VGA interrupts are used in 320 x 200 mode. The paddle is 50px by 10 px, each block is 60px by 20px. The blocks are number in the following fashion:
- First Row: 1 2 3 4 5
- Second Row: 6 7 8 9 10
- The ball movement is represented as four possible directions: northeast=00 northwest=03 southwest=02 southeast=01

##### LIMITATIONS
- ***Why this code is ugly***: 
In researching this project I found several examples of simple games people made online in DOSbox using assembly language. One of the things I noted was all of their games were laggy as they had created their own dynamic memory allocation functions to shorten their code, and they also used the stack frame to call functions with arguments and also return values. This seemed to add a lot of overhead to the game, so in designing my game I chose to have only a few functions which took no arguments and returned no values. This means there are a lot of unconditional jumps, some of which have the same functioinality. This for sure, increases the size of the applicatoin, and also the complexity as I'm guessing anyone other than me the creator will not be able to work on this project. I took these things all into consideration and decided creating a game that was non-laggy was more important than providing concise clean code. There may be a better way to still use function calls and dynamic memory allocation to achieve similar speeds but I just wanted to understand how graphics are generated using low level software, which I achieved in making this game
