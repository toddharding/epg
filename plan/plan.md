# Initial Plan

Elixir Prime Generator (EPG)

This document outlines the initial development plan, the application will take the form of a console application written in Elixir, the application module name will be Epg and will be generated as a mix project as opposed to an .exs script in order to ensure ExUnit is setup correctly and to guarantee performance.

# Form

The application will take the form of a typical linux console application, and will expect an integer as an argument

E.g. $ epg 4

The application will then output a multiplication table

# Methods Identified

All methods are under the Epg module namespace e.g. Epg.is_prime(x)

<table>
  <tr>
    <td>Signature</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>parse_input (x:string | x:int) → (x:int | error:tuple)</td>
    <td>Parses the user input to ensure a positive number has been entered
Returns an int on success or an error tuple on failure</td>
  </tr>
  <tr>
    <td>generate_primes (n:int) → (x:list<int>)</td>
    <td>Takes a positive integer n 
returns a list of prime numbers of size n </td>
  </tr>
  <tr>
    <td>is_prime(x:int) → (z:boolean) </td>
    <td>Takes an integer x
Returns true if x is prime </td>
  </tr>
  <tr>
    <td>generate_multiplication_table(x:list<int>) → : matrix</td>
    <td>Takes a list of integer of size N and generates a multiplication table of size N+1 x N+1</td>
  </tr>
  <tr>
    <td>print_table(x:table) → []</td>
    <td>Prints the table data to console (stdout)</td>
  </tr>
</table>


# 1.Write Unit Tests for Identified Methods

<table>
  <tr>
    <td>parse_input</td>
    <td></td>
  </tr>
  <tr>
    <td>input</td>
    <td>Expected output</td>
  </tr>
  <tr>
    <td>4 : int</td>
    <td>4 : int</td>
  </tr>
  <tr>
    <td>"4" : string</td>
    <td>4 : int</td>
  </tr>
  <tr>
    <td>“!ABC123” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
  <tr>
    <td>-4 : int</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
  <tr>
    <td>“-4” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
  <tr>
    <td>“5 6” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
</table>


<table>
  <tr>
    <td>generate_primes</td>
    <td></td>
  </tr>
  <tr>
    <td>input</td>
    <td>Expected output</td>
  </tr>
  <tr>
    <td>1 : int</td>
    <td>[2] : list<int></td>
  </tr>
  <tr>
    <td>2 : int</td>
    <td>[2, 3] : list<int></td>
  </tr>
  <tr>
    <td>3 : int</td>
    <td>[2, 3, 5] : list<int></td>
  </tr>
  <tr>
    <td>-1 : int</td>
    <td>{:error, "input must be a positive integer"} : tuple</td>
  </tr>
  <tr>
    <td>“3” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
  <tr>
    <td>“!ABC123” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
</table>


<table>
  <tr>
    <td>is_prime</td>
    <td></td>
  </tr>
  <tr>
    <td>input</td>
    <td>Expected output</td>
  </tr>
  <tr>
    <td>1 : int</td>
    <td>{false : bool, 1 : int} : tuple</td>
  </tr>
  <tr>
    <td>2 : int</td>
    <td>{true : bool, 2 : int} : tuple</td>
  </tr>
  <tr>
    <td>3 : int</td>
    <td>{true : bool, 3 : int} : tuple</td>
  </tr>
  <tr>
    <td>4 : int</td>
    <td>{false : bool, 4 : int} : tuple</td>
  </tr>
  <tr>
    <td>-1 : int</td>
    <td>{:error, "input must be a positive integer"} : tuple</td>
  </tr>
  <tr>
    <td>“1” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
  <tr>
    <td>“!ABC123” : string</td>
    <td>{:error, “input must be a positive integer”} : tuple</td>
  </tr>
</table>


<table>
  <tr>
    <td>generate_multiplication_table</td>
    <td></td>
  </tr>
  <tr>
    <td>input</td>
    <td>Expected output</td>
  </tr>
  <tr>
    <td>[2] : list<int></td>
    <td>[[_, 2], [2, 4]] : list<list<int>></td>
  </tr>
  <tr>
    <td>[2, 3] : list<int></td>
    <td>[[_, 2, 3], [2, 4, 6], [3, 6, 9]] : list<list<int>></td>
  </tr>
  <tr>
    <td>[2, 3, 5] : list<int></td>
    <td>[[_, 2, 3, 5], [2, 4, 6, 10], [3, 6, 9, 15], [5, 10, 15, 25]] : list<list<int>></td>
  </tr>
  <tr>
    <td>[2, 2, 2] : list<int></td>
    <td>[[_, 2, 2, 2], [2, 4, 4, 4], [2, 4, 4, 4], [2, 4, 4, 4]] : list<list<int>></td>
  </tr>
  <tr>
    <td>[-2, -3] : list<int></td>
    <td>[[_, -2, -3], [-2, 4, 6], [-3, 6, 9]] : list<list<int>></td>
  </tr>
  <tr>
    <td>[1, 2, "3"] : list<int | string></td>
    <td>{:error, “input must be a list of integers”} : tuple</td>
  </tr>
  <tr>
    <td>“!ABC123” : string</td>
    <td>{:error, “input must be a list of integers”} : tuple</td>
  </tr>
</table>


<table>
  <tr>
    <td>print_table</td>
    <td></td>
  </tr>
  <tr>
    <td>input</td>
    <td>Expected output from stdio</td>
  </tr>
  <tr>
    <td>[[_, 2], [2, 4]] : list<list<int>></td>
    <td>|          |        2 | 
|        2|        4 |</td>
  </tr>
  <tr>
    <td>[[_, 2, 3], [2, 4, 6], [3, 6, 9]] : list<list<int>></td>
    <td>|          |        2 |       3 | 
|        2|        4 |       6 |
|        3|        6 |       9 |</td>
  </tr>
  <tr>
    <td>[[_, 2, 3, 5], [2, 4, 6, 10], [3, 6, 9, 15], [5, 10, 15, 25]] : list<list<int>></td>
    <td>|          |        2 |       3 |       5 |
|        2|        4 |       6 |     10 |
|        3|        6 |       9 |     15 |
|        5|       10 |    15 |     25 |</td>
  </tr>
  <tr>
    <td>[] : list</td>
    <td>No output</td>
  </tr>
  <tr>
    <td>"!ABC123" : string</td>
    <td>{:error, “input must be a matrix”} : tuple</td>
  </tr>
</table>


# 2. Write methods

The first pass at writing the prime numbers generator and multiplication table generator methods will be a naive single erlang process implementation

# 3. Find and read relevant literature and implement findings

Once the naive implementation has been completed and works correctly, an implementation that makes use of more advanced algorithms and parallelization will be created

