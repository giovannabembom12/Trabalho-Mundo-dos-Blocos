% ============================================================
% Mundo dos Blocos com tamanhos variáveis e mesa (Prolog)
% ============================================================

% Definição de blocos e tamanhos
block(a). block(b). block(c). block(d).

size(a,1).
size(b,1).
size(c,2).
size(d,3).

% Mesa 
table_slot(0). table_slot(1). table_slot(2).
table_slot(3). table_slot(4). table_slot(5).
table_slot(6).

table_width(7).

% Regras auxiliares 
is_free(Slot, State) :-
+ (member(pos(B, table(X)), State),
size(B, W),
Xend is X + W - 1,
between(X, Xend, Slot)).

valid_block(B) :- block(B).

% Operadores de movimento
can(move(B, on(T)), State) :-
valid_block(B), valid_block(T), B == T,
member(clear(B), State),
member(clear(T), State),
size(B, W1), size(T, W2), W1 =< W2.

can(move(B, table(X)), State) :-
valid_block(B),
member(clear(B), State),
size(B, W),
Xend is X + W - 1,
table_width(Max), Xend < Max,
forall(between(X, Xend, S), is_free(S, State)).

% Atualização de estados
adds(move(B, on(T)), [pos(B, on(T)), clear(B)]).
adds(move(B, table(X)), [pos(B, table(X)), clear(B)]).

deletes(move(B,_), State, [pos(B,Old)]) :-
member(pos(B,Old), State).

apply(State, [Action], NewState) :-
adds(Action, AddList),
deletes(Action, State, DelList),
subtract(State, DelList, Temp),
union(AddList, Temp, NewState).

% Planejador
plan(State, Goals, []) :-
satisfied(State, Goals).

plan(State, Goals, [Action|Plan]) :-
select(Goal, Goals, RestGoals),
achieves(Action, Goal),
can(Action, State),
apply(State, [Action], NewState),
plan(NewState, RestGoals, Plan).

satisfied(State, Goals) :-
forall(member(G, Goals), member(G, State)).

achieves(move(B,D), pos(B,D)).

% Situação 1
initial(1, [
pos(c, table(0)),
pos(a, table(3)),
pos(b, table(5)),
pos(d, on([a,b])),
clear(c), clear(d)
]).

goal(1, [
pos(c, table(1)),
pos(d, table(3)),
pos(a, table(0)),
pos(b, table(6)),
clear(a), clear(b)
]).

% Situação 2
initial(2, [
pos(c, table(0)),
pos(d, table(3)),
pos(a, on(c)),
pos(b, on(c)),
clear(a), clear(b)
]).

goal(2, [
pos(d, table(3)),
pos(c, on(d)),
pos(a, on(c)),
pos(b, on(c)),
clear(a), clear(b)
]).

% Situação 3
initial(3, [
pos(d, table(0)),
pos(b, on(d)),
pos(a, on(b)),
pos(c, on(a)),
clear(c)
]).

goal(3, [
pos(b, table(2)),
pos(a, on(b)),
pos(c, on(a)),
pos(d, on(c)),
clear(d)
]).

% Consulta genérica
% Para executar:
% ?- initial(1, I), goal(1, G), plan(I, G, Plan).
% ?- initial(2, I), goal(2, G), plan(I, G, Plan).
% ?- initial(3, I), goal(3, G), plan(I, G, Plan).