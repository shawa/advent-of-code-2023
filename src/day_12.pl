:- set_prolog_flag(double_quotes, chars).
:- set_prolog_flag(answer_write_options, [max_depth(0)]).

contiguous(X, L) --> {L > 0, L1 is L - 1}, [X], contiguous(X, L1).
contiguous(_, 0) --> [].

block(L) --> contiguous('#', L).

one_or_more(X) --> [X], one_or_more(X).
one_or_more(X) --> [X].

blocks([T])   --> block(T).
blocks([H|T]) --> block(H), one_or_more('.'), blocks(T).

zero_or_more(X) --> [X], zero_or_more(X).
zero_or_more(_) --> [].

dcg(Ns) --> zero_or_more('.'), blocks(Ns), zero_or_more('.').

pattern([], []).
pattern(['?'|T], [_X|Rest]) :- pattern(T, Rest).
pattern([H|T], [H|Rest]) :- H \= '?', pattern(T, Rest).

place_springs(In, Spec, R) :-
    findall(Pattern, (pattern(In, Pattern), phrase(dcg(Spec), Pattern)), R).

count_solutions(In, Spec, L) :- 
    place_springs(In, Spec, R),
    length(R, L).
