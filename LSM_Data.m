function [X,Y]=LSM_Data(ys,us,centers)
% to produce data for LSM
% given the nonlinear parameters
% the X in (X*Beta=Y) can be calcaulated.

global N_lag
global Order_y
global Order_u
global N_Center
global D_Center
global N_S
global gamma0
%% calcaute the data for LSM
Y=ys(N_lag+1:N_lag+N_S,1);                           %consider the order of the system
X=zeros(size(Y,1),(N_Center+1)*(Order_y+Order_u+1));  % linear parameter vector: weights
% each RBF has m+1 (centers + one offset) linear paremeters.
% there are 1+p+q RBFs (one offset RBF + order_y+ order_u).
% In total, there are (m+1)(1+p+q) linear parameters need to be optimized.

% the following code omits the calculation of each RBF in the Kernel calculating process,
% since when RBFs have the same nonlinear paramters, their Kernel results have no difference.
for t=N_lag+1:N_lag+N_S
    Ker=ones(1,(N_Center+1)*2);                 % Kernels intialized
    for k=1:2                                                % for different kinds of RBFs
        for i=1:N_Center                                % for each center
            norm=0;                                % the distance
            for j=1:D_Center
                norm=norm+(ys(t-j)-centers((k-1)*N_Center*D_Center+(i-1)*D_Center+j))^2; 
            end
            Ker((k-1)*(N_Center+1)+i+1)=exp(-gamma0((k-1)*N_Center+i)*norm);  % Kernels' results, only even terms are calculated.
        end                                                                   % other terms are valued 1.
    end
    
    X1=zeros(1,Order_y*(N_Center+1));      % values representing Ker*y when the system is thought as linear system       
    for i=1:Order_y
        X1((i-1)*(N_Center+1)+1:i*(N_Center+1))=Ker(1:N_Center+1).*ys(t-i,1);
    end
    
    X2=zeros(1,Order_u*(N_Center+1));      % values representing Ker*u when the system is thought as linear system       
    for i=1:Order_u
        X2((i-1)*(N_Center+1)+1:i*(N_Center+1))=Ker(N_Center+2:2*N_Center+2).*us(t-i,1);
    end
    
    X(t-N_lag,:)=[Ker(1:N_Center+1),X1,X2];   % notice that the value of the term(offset) has the same value of y_kinds
    
end
                
                
                