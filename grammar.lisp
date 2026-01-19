Grammar:
X -> C | O
A -> C|S|P|O|R
C -> 'C'{N' 'N}
S -> 'S'
P -> 'P'{N' 'N}
O -> o[A' 'AF]
R -> p[A' 'A]
F -> ' 'AF|:
N -> 0|S(N)

First:
A = 'C', 'S', 'P', o, r
C = 'C'
S = 'S'
P = 'P'
O = o
R = p
F = ' ', :
N = 0, 'S'

Follow:
A = $, ' ', ]
C = $, ' ', ]
S = $, ' ', ]
P = $, ' ', ]
O = $, ' ', ]
R = $, ' ', ]
F = ]
N = ), }, ' '

Predict:
A -> C =          'C'
A -> S =          'S'
A -> P =          'P'
A -> O =           o
A -> R =           p
C -> 'C'{N' 'N} = 'C'
S -> 'S' =        'S'
P -> 'P'{N' 'N} = 'P'
O -> o[A' 'AF] =   o
R -> p[A' 'A] =    p
F -> ' 'AF =       ' '
F -> : =           ] 
N -> 0 =           0
N -> S(N) =       'S'

