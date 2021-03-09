# Linux::Fuser

Discover which process has a file open, in pure Raku.

![Build Status](https://github.com/jonathanstowe/Raku-Linux-Fuser/workflows/CI/badge.svg)

## Description

This is based on the similarly named module for Perl 5 available from CPAN.

Linux::Fuser provides a mechanism to determine which processes have
a specified file open in a similar manner to the system utility
*fuser*. There is an example program [raku-fuser](bin/raku-fuser) in
the *bin* directory which provides a Raku implementation of that command.

Because this relies on the layout of the /proc filesystem specific to the Linux
kernel it almost certainly will not work on any other operating system, though I
would be delighted to hear about any where it does work.

## Installation

Assuming you have a working Rakudo installation you should be able to install this with *zef* :

    zef install Linux::Fuser

Or if you have a local clone of the repository

    zef install .

## Support

Suggestions/patches are welcomed via github at:

https://github.com/jonathanstowe/Raku-Linux-Fuser/issues

I'm not able to test on a wide variety of platforms so any help there would be 
appreciated.

## Licence

This is free software.

Please see the [LICENCE](LICENCE) file in the distribution.

© Jonathan Stowe 2015 - 2021
