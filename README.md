# `brainfuck-asm`

A [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter written in x86_64 assembly for Linux based systems.

> [!IMPORTANT]  
> I made this because I was bored at night. I don't guarantee any support of any kind. This project was made thanks to the Almighty Coffee God. Don't ask too many questions about how it really works because it's very likely that I already forgot everything!

## Usage

I have absolutely no idea why would you want to know how to use a Brainfuck interpreter.. Anyways, apparently you do so let's dive in!

For now the program is hardcoded because I really need to get some sleep. I'll do program loading when my brain decides not to be a lazy fu\*\*. Here's how to run it:

```bash
./interpreter
```

## How do I write a Brainfuck program?

Heads up: that's a terrible idea. Here's the [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck) page. There, you can find a simple but useful table which states everything you can do. The language is pretty basic and easy to understand but is a living hell to use.

## Build

If you want to build this project on your machine, I am so sorry but it's all lost and hopeless for you.. I am not joking, nobody can help you at this point.. Anyways, here's a simple guide:

1. Make sure you are on a Linux distribution (you didn't really expect this to work on Windows, did you??). You can use WSL if you want.
2. Install the `nasm` compiler (should be `apt install nasm` on most distributions and `pacman -S nasm` for the elite).
3. Run the `./compile.sh` script. This will compile the program and create a binary named `interpreter` inside the `build` folder.
