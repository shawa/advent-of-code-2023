:- set_prolog_flag(double_quotes, chars).
:- set_prolog_flag(answer_write_options, [max_depth(0)]).


contiguous(Term, Length) --> {Length > 0, NewLength is Length - 1}, [Term],
                            contiguous(Term, NewLength).

contiguous(_, 0) 
    --> [].

dummy(1).

zero_or_more(Term) 
    --> [Term], zero_or_more(Term).

zero_or_more(_)
     --> [].

one_or_more(Term) 
    --> [Term], one_or_more(Term).

one_or_more(Term) 
    --> [Term].


block(L) -->
    contiguous('#', L).


blocks([T]) --> 
    block(T).

blocks([H|T]) -->
    block(H),
    one_or_more('.'),
    blocks(T).

dcg(Ns) --> 
    zero_or_more('.'), blocks(Ns), zero_or_more('.').


parse([], []).
parse(['?'|T], [_X|Parsed]) :- 
    parse(T, Parsed).
parse([H|T], [H|Parsed]) :- 
    H \= '?',
    parse(T, Parsed).

find_all_solutions(Solutions) :-
    findall(R, (parse("?###????????", R), phrase(dcg([3,2,1]), R)), Solutions).

place_springs(InPattern, Spec, R) :-
    findall(Pattern, (parse(InPattern, Pattern), phrase(dcg(Spec), Pattern)), R).

count_solutions(InPattern, Spec, Length) :-
    place_springs(InPattern, Spec, Solutions),
    length(Solutions, Length).
