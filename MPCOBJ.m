function J=MPCOBJ(x,Yr,U,Y,cs,ps)

y_future=zeros(1,ps);
% u_future=y_future;
% 
% for j=1:10
%     if j<=3
%         u_future(j)=x(j);
%     else
%         u_future(j)=u_future(3);
%     end
% end
model=evalin('base','model');
u_future=[x x(cs)*ones(1,ps-cs)];

u_active=[0 U(1) U(2)];
y_active=Y;
W=ARXModel([y_active(1) y_active(2)],model);

for k=1:ps
    u_active(1)=u_future(k);
    inputvector=[1 y_active u_active];
%     W=ARXModel([y_active(1) y_active(2)],model);  % update model parameters
    y_future(k)=sum(inputvector.*W);
    
    u_active(2)=u_active(1);       % update u_active
    u_active(3)=u_active(2);
    
    y_active(2:7)=y_active(1:6);  % update y_active
    y_active(1)=y_future(k);
end

J=Yr-y_future;
J=J*J';         % a simple objective function

    


