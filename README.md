# Description
This project contains a system for enumerating primitive recursive functions, along with a compiler to execute them in Lisp. Enumeration is done by building up each function that can be built in n production rules in accordance wit​h the specified grammar in grammar.txt.

# Run
The enumerator can be run by loading the generator.lisp program ```sbcl --load generator.lisp``` and then typing the desired search depth.

# Background
## Primitive Recursive Functions
Primitive recursive functions is a formalization for representing programs that can only use bounded recursion and therefore are guaranteed to halt. They are interesting because they span almost every program that programmers create and yet are not affected by the halting problem. Primitive recursive functions are defined by 3 axioms (constant, successor, and projection functions) and 2 operators (composition and primitive recursive operator). For example, the add function that adds two numbers would look like p[P{S(0) S(0)} o[S P{S(S(0)) S(S(S(0)))}]]. The full syntax specification is found in definition.txt. More details here: https://en.wikipedia.org/wiki/Primitive_recursive_function

## Kolgomorov Complexity
Kolgomorov complexity measures how "compressible" an arbitrary string is. The kolgomorov complexity of a string is defined as the smallest program that outputs the string. Kolgomorov complexity is interesting because finding the kolgomorov complexity of a string and its associated program would allow us to optimally compress any string and is also analogous to discovering the laws of physics in science. The caveat is that kolgomorov complexity, when defined as the smallest turing machine, is uncomputable due to the halting problem. However, primitive recursive functions always halt anyway, therefore a promising alternative formulation is to instead seek the primitive recursive kolgomorov complexity of a string (the smallest primitive recursive function that outputs the string). More details here: https://en.wikipedia.org/wiki/Kolmogorov_complexity

## Program Enumeration
Unfortunately, the only known method to computing the finding the primitive recursive kolgomorov complexity of a string is to exhaustively enumerate all possible primitive recursive functions that are smaller than the string and execute them one by one until a program is found that outputs the string. Such an algorithm is clearly exponential in time complexity and therefore is quite slow. Despite that, it is a promising start and hopefully heuristics can be researched to speed up the process.
