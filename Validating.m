clc;
clear;
load 'modelparas'

%% for traning data
[X,Y]=LSM_Data(yst,ust,optimcenter);
y_pre=X*beta;
error=Y-y_pre;
figure(1);
subplot(3,1,1)
hold on
plot(Y,'k-')
plot(y_pre,'b--')
axis([0 4000 0 1])
legend('实际输出','RBF-ARX模型输出')
title('系统输出')
subplot(3,1,2)
stem(error)
title('辨识误差')
subplot(3,1,3)
plot(ust,'r-')
axis([0 4000 0 1])
figure(2)
hold on
histogram(error,101)
MSE=sum(error.^2)/size(y_pre,1);
['Training MSE = ' num2str(MSE)]

%% for validating data
[X,Y]=LSM_Data(ysv,usv,optimcenter);
y_pre=X*beta;
error=Y-y_pre;
figure(3);
subplot(3,1,1)
hold on
plot(Y,'k-')
plot(y_pre,'b--')
axis([0 4000 0 1])
legend('实际输出','RBF-ARX模型输出')
title('系统输出')
subplot(3,1,2)
stem(error)
title('辨识误差')
subplot(3,1,3)
plot(usv,'r-')
axis([0 4000 0 1])
figure(4)
histogram(error);
MSE=sum(error.^2)/size(y_pre,1);
['Validating MSE = ' num2str(MSE)]
'End Validating'

