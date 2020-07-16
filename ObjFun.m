function fun=ObjFun(X,us,ys)
% the objective function of optimization
% including the LSM so that SNPOM
% can be achieved.
%% initialization of gamma0
global gamma0
gamma0=ones(2,1);
global D_Center
E=0.0001;
for i=1:2
    expsum=0;
    for j=1:D_Center
        expsum=expsum+(max(abs(ys-X(D_Center*(i-1)+j))))^2;
    end
    gamma0(i)=-log(E)/expsum;
end

%% LSM
global beta
[X_LSM,Y_LSM]=LSM_Data(ys,us,X);
beta=pinv(X_LSM)*Y_LSM;
fun=Y_LSM-X_LSM*beta;