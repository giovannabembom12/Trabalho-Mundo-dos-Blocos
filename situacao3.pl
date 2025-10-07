:- [mundodosblocos].

% Situação 3

initial([
    pos(d, table(0)),     
    pos(b, on(d)),        
    pos(a, on(b)),        
    pos(c, on(a)),        
    clear(c)
]).

goal([
    pos(b, table(2)),     
    pos(a, on(b)),        
    pos(c, on(a)),        
    pos(d, on(c)),        
    clear(d)
]).

% Query
% ?- initial(I), goal(G), plan(I, G, Plan).

