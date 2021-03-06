# TrueRandom
A direct copy from https://code.google.com/p/tinkerit/ of the TrueRandom project.
This is done to preserve and allow editing following the archiving of all Google Code projects in August 2015.
#### All credit to the original contributors.

## Introduction
TrueRandom generates true random numbers on Arduino. They are different every time you start your program, and are truly unpredictable unlike the default Arduino random() function.

## Warning
It appears TrueRandom may not have a truely random distribution according to an analysis found on [endolith](http://www.endolith.com/wordpress/2013/06/19/truerandom-is-not-truly-random/):

> After testing it, I realized it’s not actually random and shouldn’t be used for anything important. ... Clearly these are not randomly distributed. They’re strongly centered around 0 and low powers of 2.

> ... So for Arduino, I used the frequency difference between the watchdog timer and Timer 1 as the entropy source ... It uses the watchdog timer to sample (and reset) Timer 1. Since the watchdog timer runs on its own RC oscillator, and Timer 1 is on the crystal oscillator, there is random variation in the value read. Then the randomness is spread around to all 8 bits by the same method. The watchdog timer’s minimum length is not short, so this method only produces about 64 bit/s, vs TrueRandom’s 3200 bit/s. But they’re good bits. Since TrueRandom doesn’t live up to its name, and I’m not a cryptographic expert, I erred on the side of caution and named it [ProbablyRandom](https://gist.github.com/endolith/2568571).

## Compatibility
TrueRandom currently functions on the Arduino Diecimila, Duemilanove, 168 and 328 based Arduinos. It does not yet function on the Arduino Mega. TrueRandom uses Analog 0. Do not connect anything to this pin. These restrictions may be removed in future versions of this library.

## Download
Download TrueRandom library. Extract the zip file, and copy the directory to your Arduino libraries folder.

## What happens when you use the Arduino random() function?
The Arduino default random() function generates what appear to be random numbers. They are actually calculated from a formula. On reset, the formula is reset at a start point, then progresses through a long sequence of random looking numbers. However, Arduino starts at the same point in the sequence every reset. You can move to a different part of the sequence using srandom(), but how do you get a random start point from in the first place?

## What happens when you use TrueRandom.random() function?
You get a random number. Really random. Different every time you restart.

## TrueRandom basic functions
The existing random functions of Arduino are replicated in TrueRandom.

### TrueRandom.random()
Like the Arduino library and ANSI C, this generates a random number between 0 and the highest signed long integer 2,147,483,647.

### TrueRandom.random(n)
This generates a random number between 0 and (n-1). So random(6) will generate numbers between 0 and 5.

### TrueRandom.random(a,b)
This generates a random number between a and (b-1). So random(1,7) will generate numbers between 1 and 6.

## TrueRandom advanced functions
### TrueRandom.randomBit()
Generating true random numbers takes time, so it can be useful to only generate as many random bits as you need. randomBit() generates a 0 or a 1 with 50% probability. This is the core function from which the other TrueRandom libraries are built.

### TrueRandom.randomByte()
Generates a random byte between 0 and 255. Equivalent to random(256).

### TrueRandom.rand()
Like the ANSI C rand() command, this generates a random number between 0 and the highest signed integer 32767.

### TrueRandom.memfill(address, length)
Fills a block of bytes with random numbers. (length) bytes are filled in total, starting at the given (address).

## TrueRandom specialist functions
### TrueRandom.mac(address)
When operating devices on an Ethernet network, each device must have a unique MAC address. Officially, MAC addresses should be assigned formally via the IEEE Registration Authority. However, for practical purposes, MAC addresses can be randomly assigned without problems. This function writes a 6 byte MAC address to a given address. Randomly generated MAC addresses are great for projects or workshops involving large numbers of Arduino Ethernet shields, as each shield has a different MAC address, even though they are running identical code. See the MacAddress example which shows this in use.

### TrueRandom.uuid(address)
UUIDs are unique identifiers. They are 16 bytes (128 bits) long, which means that generating them randomly This generates a random UUID, and writes it to an array. UUIDs are globally unique numbers that are often used in web services and production electronics. TrueRandom can produce any one of 5,316,911,983,139,663,491,615,228,241,121,378,304 different numbers. You're more likely to win top prize in the national lottery 3 times in a row than get two matching UUIDs.

## How TrueRandom works
It is hard to get a truly random number from Arduino. TrueRandom does it by setting up a noisy voltage on Analog pin 0, measuring it, and then discarding all but the least significant bit of the measured value. However, that isn't noisy enough, so a von Neumann whitening algorithm gathers enough entropy from multiple readings to ensure a fair distribution of 1s and 0s.

The other functions within TrueRandom construct the requested values by gathering just enough random bits to produce the required numbers. Generating a random bit takes time, so a significant part of the code works to ensure the random bits are used as efficiently as possible.
