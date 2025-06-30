# `brainfuck-asm`

A [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter written in x86_64 assembly for Linux based systems.

> [!IMPORTANT]  
> I made this because I was bored at night. I don't guarantee any support of any kind. This project was made thanks to the Almighty Coffee God. Don't ask too many questions about how it really works because it's very likely that I already forgot everything!

## Usage

I have absolutely no idea why would you want to know how to use a Brainfuck interpreter.. Anyways, apparently you do so let's dive in!

This interpreter is probably the simplest one you ever used. It takes a path to a Brainfuck file (with the bf file extension) as its first and only argument, interprets it and terminates.

```bash
./interpreter program.bf
```

## How do I write a Brainfuck program?

Heads up: that's a terrible idea. Here's the [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck) page. There, you can find a simple but useful table which states everything you can do. The language is pretty basic and easy to understand but is a living hell to use.

## Exit codes

It might go wrong. If, somehow, you manage to encounter a handled error the program will exit with a non zero exit code.

If you are lucky, the program will tell you what happened. Most of the time it wont; especially if you catch a never seen before error (_or worse, a segfault_ 😱)

| Exit code | Description              |
| --------- | ------------------------ |
| `0`       | No error                 |
| `1`       | Incorrect usage          |
| `2`       | File is not accessible   |
| `3`       | Error while opening file |

## Build

If you want to build this project on your machine, I am so sorry but it's all lost and hopeless for you.. I am not joking, nobody can help you at this point.. Anyways, here's a simple guide:

1. Make sure you are on a Linux distribution (you didn't really expect this to work on Windows, did you??). You can use WSL if you want.
2. Install the `nasm` compiler (should be `apt install nasm` on most distributions and `pacman -S nasm` for the elite).
3. Run the `./compile.sh` script. This will compile the program and create a binary named `interpreter` inside the `build` folder.
