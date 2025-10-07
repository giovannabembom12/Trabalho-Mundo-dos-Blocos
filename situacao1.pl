:- [mundodosblocos]. 
% Situação 1

initial([
    pos(c, table(0)),      
    pos(a, table(3)),      
    pos(b, table(5)),      
    pos(d, on([a,b])),    
    clear(c), clear(d)
]).

goal([
    pos(c, table(1)),     
    pos(d, table(3)),     
    pos(a, table(0)),     
    pos(b, table(6)),     
    clear(a), clear(b)
]).

% Query
% ?- initial(I), goal(G), plan(I, G, Plan).

