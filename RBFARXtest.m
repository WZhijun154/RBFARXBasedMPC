%% to test whether the 'ARXModel.m' is correct.
clc
clear
load 'themodel'
load 'modelparas'

y_pre_by_arx=zeros(1,N_S);
inputvector=zeros(1,Order_u+Order_y+1);
inputvector(1)=1;
for t=N_lag+1:N_lag+N_S
    W=ARXModel([yst(t-1),yst(t-2)],model);
    for i=1:Order_y
        inputvector(i+1)=yst(t-i);
    end
    for i=1:Order_u
        inputvector(i+Order_y+1)=ust(t-i);
    end
    y_pre_by_arx(t)=sum(inputvector.*W);
end
y_pre_by_arx=y_pre_by_arx(N_lag+1:N_lag+N_S);
plot(y_pre_by_arx);
axis([0 4000 0 1])
save 'y_pre_by_arx' y_pre_by_arx;

'End Testing'