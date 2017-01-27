# Elixir Primes Generator (EPG)

A command line application that generates N Primes and then produces a multiplication table from the list of primes e.g.

| &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;2 | &nbsp;&nbsp;3 | &nbsp;&nbsp;5 |

| &nbsp;2 | &nbsp;&nbsp;4 | &nbsp;&nbsp;6 | 10 |

| &nbsp;3 | &nbsp;&nbsp;6 | &nbsp;&nbsp;9 | 15 |

| &nbsp;5 | 10 | 15 | 25 |
## Installation

First clone this project

Then in the cloned directory run
    
    mix deps.get
    
This will pull down any dependencies

Once the dependencies have been downloaded run
    
    escript.build
    
This will build the executable and place it into the current directory

## Usage

If you are running on a *nix platform then to generate a 4x4 multiplication grid based on the first 3 prime numbers run:

    ./epg 3

On windows command line run

    escript epg 3

Other options are

    ./epg --upto n

--upto will print all prime numbers up to n

    ./epg --list n
    
--list will list the first n prime numbers

If you generate a very large grid it will not be easily viewable in the terminal,
if you would like to view all of the data then you can save the output into a file by running

    ./epg n > output.txt

This can be viewed in most text editors and will be formatted correctly as long as word wrap is disabled

## Features
* Single process n primes generator (Epg.SingleProcess)
* Multi Process n primes generator (Epg.MultiProcess)
* Sieve of Eratosthenes find prime numbers upto n generator (Epg.SOE)
* Sieve of Eratosthenes using ETS for storage (Epg.SOEETS)

## Future improvements

### Multi Process Sieve
The current versions of the Sieve of Eratosthenes (used in the --upto option) 
use a single process, the reason for this is because early multi-process 
prototypes ran much slower than the single threaded version.

I would like to revisit this to improve performance as the multi process Sieve 
should in theory run much faster than the naive iterative methods currently used
 
### Multi Node Distributed Prime Generation
The application currently makes use of multiple local processes, but it is possible that 
it could be made faster by making use of distributed Erlang nodes
 
### Use NIFs 
Although Erlang has great process parallelism, it is not particularly performant at numerical tasks, Erlang
has these performance tradeoffs in order to prioritise safety, concurrency and fast response times, looking at the
benchmarks of C prime generators though it is clear that even a naive single threaded C version has incredibly 
good performance.

A NIF is a native function written in C, although this can be good for performance the tradeoff is 
that if the C code crashes it will take down the Erlang VM with it, thankfully there is a tool called Nifty
http://parapluu.github.io/nifty/ that will generate a NIF from C header files allowing them to be called relatively 
safely, as the NIF is managed by its own Erlang process.

Making use of this could mean having a sieve process manager in erlang that divides a list of natural numbers into 
chunks and sends those chunks + the current prime to several NIF processes that mark the numbers in that chunk as prime, 
as these native functions are implemented in C they could make use of SIMD CPU intrinsics to mark many 
composite numbers per clock cycle.

## Issues
* Can run out of memory on windows causing a crash (*nix's seem to chug along happily)
* Large grids can take a while to generate


