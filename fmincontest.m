AA=1;
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
nonlcon = [];
x0 = [0,0];
x = fmincon(@objfun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options,AA);


function y=objfun(x,AA)

y=100*(x(2)-x(1)^2)^2 + AA * (1-x(1))^2;

end