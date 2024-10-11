
%man, a woman and two children had to go to the opposite bank of a river using a boat. The man and the woman weighed 80 kg each and the children weighed 30 kg each. Given that the boat can carry upto 100 kg and that everyone can drive a boat, write a Prolog program to find how all four can cross the river with the boat.

writenlist([]) :- nl.  % Base case: an empty list just outputs a newline
writenlist([H|T]) :-  
    write(H),
    write(' '),
    writenlist(T).

    
% Define possible weight for each person
weight(man, 80).
weight(woman, 80).
weight(child1, 30).
weight(child2, 30).

% Boat can carry up to 100kg, so define valid combinations that can travel together
valid_combination([P1]) :-
    weight(P1, W1),
    W1 =< 100.
valid_combination([P1, P2]) :-
    weight(P1, W1),
    weight(P2, W2),
    W1 + W2 =< 100.

% Opposite bank
opposite(left, right).
opposite(right, left).

% Check if a state is safe
safe(state(_, _, _, _, _)) :- true.

% Define possible moves:

% Children move together
move(state(Man, Woman, left, left, left), state(Man, Woman, right, right, right)) :-
    valid_combination([child1, child2]),
    safe(state(Man, Woman, right, right, right)),
    writenlist(['Children move together to the right']).

%child1 moves alone
move(state(Man, Woman, right, Child2, right), state(Man, Woman, left, Child2, left)) :-
    valid_combination([child1]),
    safe(state(Man, Woman, left, Child2, left)),
    writenlist(['Child 1 moves alone to the left']).

%child2 moves alone
move(state(Man, Woman, Child1, right, right), state(Man, Woman, Child1, left, left)) :-
    valid_combination([child2]),
    safe(state(Man, Woman, Child1, left, left)),
    writenlist(['Child 2 moves alone to the left']).

% Man moves alone
move(state(left, Woman, Child1, Child2, left), state(right, Woman, Child1, Child2, right)) :-
    valid_combination([man]),
    safe(state(right, Woman, Child1, Child2, right)),
    writenlist(['Man moves alone to the right']).


% Woman moves alone
move(state(Man, left, Child1, Child2, left), state(Man, right, Child1, Child2, right)) :-
    valid_combination([woman]),
    safe(state(Man, right, Child1, Child2, right)),
    writenlist(['Woman moves alone to the right']).

% Base case: when all are on the right side
path(state(right, right, right, right, right), []) :-
    write('Everyone has crossed the river!'),
    nl,
   !.  

% Recursive case: find a move and continue
path(CurrentState, [_|Moves]) :-
    move(CurrentState, NextState),
    path(NextState, Moves).

% Start the problem
solve :-
    InitialState = state(left, left, left, left, left),
    path(InitialState, Solution),
    !.


