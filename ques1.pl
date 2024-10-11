%A popular children’s riddle is “Brothers and sisters have I none, but that man’s father is my father’s son.” Use the rules of the family domain (Section 8.3.2 on page 301 in the Textbook) to find who that man is using a Prolog program.


% Facts about male individuals
is_male(person1).
is_male(person2).
is_male(father1).
is_male(grandfather1).

% Family relationships among individuals
is_father(father1, person1).
is_father(grandfather1, person2).
is_father(father1, grandfather1).

% Rule to determine if a child is a son of a parent
is_son(Child, Parent) :- is_father(Parent, Child), is_male(Child).

% Solving the riddle for a specific person
solve_riddle(person2) :-
    is_father(grandfather1, person2),
    is_father(father1, person1),
    is_son(grandfather1, father1),
    write('That person is a son to me'), nl.
