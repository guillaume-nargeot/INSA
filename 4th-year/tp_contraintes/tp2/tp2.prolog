/* tp 2 */
    :-lib(fd).


taches2(T) :- T = [](tache(3, [],     m1, _),
                 tache(8, [],     m1, _),
                 tache(8, [4,5],  m1, _),
                 tache(6, [],     m2, _),
                 tache(3, [1],    m2, _),
                 tache(4, [1,7],  m1, _),
                 tache(8, [3,5],  m1, _),
                 tache(6, [4],    m2, _),
                 tache(6, [6,7],  m2, _),
                 tache(6, [9,12], m2, _),
                 tache(3, [1],    m2, _),
                 tache(6, [7,8],  m2, _)).
   
taches(T) :- T = [](tache(5, [],     m2, _),
                 tache(8, [1],     m1, _),
                 tache(7, [1],     m1, _),
                 tache(6, [],      m1, _),
                 tache(3, [],      m1, _),
                 tache(6, [3,4],   m2, _),
                 tache(5, [5,6],   m1, _),
                 tache(4, [2,7],   m2, _),
                 tache(7, [3,4],   m2, _),
                 tache(6, [5,6],   m2, _),
                 tache(3, [8,10],  m1, _),
                 tache(4, [9],     m2, _)).          
                
contrainte1(T,Fin) :- dim(T,[Y]), (for(I,1,Y), param(T,Fin) do tache(A,_,_,D) is T[I], D #>= 0, D+A #=< Fin).
/*
[eclipse 3]: taches(T), contrainte1(T, 10).

T = [](tache(5, [], m2, D{[0..5]}), tache(8, [1], m1, D{[0..2]}), tache(7, [1], m1, D{[0..3]}), tache(6, [], m1, D{[0..4]}), tache(3, [], m1, D{[0..7]}), tache(6, [3, 4], m2, D{[0..4]}), tache(5, [5, 6], m1, D{[0..5]}), tache(4, [2, 7], m2, D{[0..6]}), tache(7, [3, 4], m2, D{[0..3]}), tache(6, [5, 6], m2, D{[0..4]}), tache(3, [8, 10], m1, D{[0..7]}), tache(4, [9], m2, D{[0..6]}))
        Yes (0.00s cpu)
*/

/*
appartient(E,[E]).
appartient(E,[E|R]).
appartient(E,[A|R]) :- \=(A,E),  appartient(E,R).


contrainte2(T) :- dim(T,[Y]), 
                (for(I,1,Y), param(T, Y) do tache(A,B,_,D) is T[I], 
                        (for (J,1,Y), param(T, A, B, D) do tache(A2,_,_,D2) is T[J], %appartient(J,B), 
                        D #>= D2 + A2)).

*/

contrainte2(T) :- dim(T,[Y]), 
        (for(I,1,Y), param(T) do tache(_,B,_,D) is T[I], 
         (foreach(P, B), param(T, D) do tache(A2, _, _, D2) is T[P], D #>= D2 + A2)).
                    

/*
[eclipse 7]: taches(T), contrainte1(T, 35), contrainte2(T).
T = [](tache(5, [], m2, D{[0..5]}), tache(8, [1], m1, D{[5..20]}), tache(7, [1],  m1, D{[5..10]}), tache(6, [], m1, D{[0..11]}), tache(3, [], m1, D{[0..20]}), ta che(6, [3, 4], m2, D{[12..17]}), tache(5, [5, 6], m1, D{[18..23]}), tache(4, [2,  7], m2, D{[23..28]}), tache(7, [3, 4], m2, D{[12..24]}), tache(6, [5, 6], m2, D {[18..26]}), tache(3, [8, 10], m1, D{[27..32]}), tache(4, [9], m2, D{[19..31]}))

    There are 15 delayed goals. Do you want to see them? (y/n)

Delayed goals:
    D{[27..32]} - D{[23..28]}#>=4
    D{[23..28]} - D{[5..20]}#>=8
    D{[5..20]} - D{[0..5]}#>=5
    D{[23..28]} - D{[18..23]}#>=5
    D{[18..23]} - D{[0..20]}#>=3
    D{[18..23]} - D{[12..17]}#>=6
    D{[12..17]} - D{[5..10]}#>=7
    D{[5..10]} - D{[0..5]}#>=5
    D{[12..17]} - D{[0..11]}#>=6
    D{[27..32]} - D{[18..26]}#>=6
    D{[18..26]} - D{[0..20]}#>=3
    D{[18..26]} - D{[12..17]}#>=6
    D{[19..31]} - D{[12..24]}#>=7
    D{[12..24]} - D{[5..10]}#>=7
    D{[12..24]} - D{[0..11]}#>=6
    Yes (0.00s cpu)
*/

contrainte3(T) :- dim(T,[Y]),
        (for(I, 1, Y), param(T, Y) do tache(A,_,C,D) is T[I], 
         (for(J, 1, Y), param(T, I, A, C, D) do tache(A2, _, C2, D2) is T[J],
          I #= J #\/ C #\= C2 #\/ A2 + D2 #<= D #\/ A + D #<= D2)).

predicatFinal(Fin, V) :- taches2(T),
                    contrainte1(T, Fin),
                    contrainte2(T),
                    contrainte3(T),
                    dim(T, [Y]),
                    (for(I, 1, Y), param(T), fromto([], In, Out, V) do tache(_, _, _, Deb) is T[I], Out = [Deb|In] ),
                    min_max(labeling(V),Fin).
/*
[eclipse 2]: predicatFinal(Fin, V).
Found a solution with cost 43

Fin = Fin{[43..10000000]}
V = [25, 9, 37, 31, 12, 17, 25, 6, 0, 9, 29, 0]
Yes (0.02s cpu)
*/