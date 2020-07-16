function [sys,x0,str,ts] = test(t,x,u,flag)

switch flag
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 2
    sys=mdlUpdate(t,x,u);
  case 3
    sys=mdlOutputs(t,x,u);
  case {1,4,9}
      sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end


function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 1;   %
sizes.NumOutputs     = 1;  
sizes.NumInputs      = 3;   %
sizes.DirFeedthrough = 0;   
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = 1;     %
str = [];

Ts=0.005;     % sample time 5ms
ts  = [Ts 0];




function sys=mdlUpdate(t,x,u)
u';
x=1;
sys=[];

function sys=mdlOutputs(t,x,u)
x
sys = 1;










