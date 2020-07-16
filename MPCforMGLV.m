function [sys,x0,str,ts] = MPCforMGLV(t,x,u,flag,cs,ps)

switch flag
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes(cs);
  case 2
    sys=mdlUpdate(t,x,u,cs,ps);
  case 3
    sys=mdlOutputs(t,x,u);
  case {1,4,9}
      sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end


function [sys,x0,str,ts]=mdlInitializeSizes(cs)
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = cs;   %
sizes.NumOutputs     = 1;  
sizes.NumInputs      = 11;   %
sizes.DirFeedthrough = 0;   
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = zeros(cs,1);     %
str = [];
Ts=0.005;     % sample time 5ms
ts  = [Ts 0];





function sys=mdlUpdate(t,x,u,cs,ps)
alpha=0.9;
U=u(9:11)'; % u(9-11) is the past MPC(this model) control signal
r=u(8);             % u(8) is the reference signal
%Yr=zeros(1,10);      % Yr is the reference trajectory
Y=u(1:7)'; % u(1-7) is the delayed plant model outputs,as inputs to this model
% if Y(1)>0.65
%     alpha=0.99999;
% end
% for j=1:10
%     Yr(1,j)=u(1)*alpha^j+(1-alpha^j)*r;
% end
% error=0.5*u(12);
Yr=u(1)*alpha.^(1:ps)+(1-alpha.^(1:ps))*r;
% xf0=[x(2) x(3) x(3)];   % x(1),x(2),x(3) store the past optimized constrol step
xf0=[x(2:cs)' x(cs)];                     % xf0, as the initial value to run optimization
% model=evalin('base','model');
% lb=[0 0 0];        % the constraint of control signal
% ub=[1 1 1];
lb=zeros(1,cs);
ub=ones(1,cs);
% options = optimset('LargeScale','off','MaxIter',10,'TolFun',1e-4,'TolPCG',0.0001,'TolX',1e-10,'Display','off');
options = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',15,'Display','off');                                      
% tic
optix = fmincon(@MPCOBJ,xf0,[],[],[],[],lb,ub,[],options,Yr,U,Y,cs,ps);
% toc
sys=optix';      % update states

function sys=mdlOutputs(t,x,u)
sys = x(1);     % output the first control signal










