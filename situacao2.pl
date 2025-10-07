:- [mundodosblocos].

% Situação 2

initial([
    pos(c, table(0)),      % c ocupa [0,1]
    pos(d, table(3)),      % d ocupa [3,4,5]
    pos(a, on(c)),         % a sobre c
    pos(b, on(c)),         % b sobre c
    clear(a), clear(b)
]).

goal([
    pos(d, table(3)),      % d em [3,4,5]
    pos(c, on(d)),         % c sobre d
    pos(a, on(c)),         % a sobre c
    pos(b, on(c)),         % b sobre c
    clear(a), clear(b)
]).

% Query
% ?- initial(I), goal(G), plan(I, G, Plan).

