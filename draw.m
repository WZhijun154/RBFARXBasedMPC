%% prepare data for draw1,draw2
load MagData
ust=u(1000:5000,1);          % training data
yst=y(1000:5000,1);
usv=u(5001:10000,1);         % validating data, validated in 'Validating.m'
ysv=y(5001:10000,1);

%% draw1
subplot(2,1,1)
plot(ust,'k')
axis([0 4000 0 1])
ylabel('u(V)','FontSize',12)
title('输入u','FontSize',20)
subplot(2,1,2)
plot(yst,'k')
axis([0 4000 0 1])
ylabel('y(V)','FontSize',12)
title('输出y','FontSize',20)

%% draw2
subplot(2,1,1)
plot(usv,'k')
axis([0 (10000-5000) 0 1])
ylabel('u(V)','FontSize',12)
title('输入u','FontSize',20)
subplot(2,1,2)
plot(ysv,'k')
axis([0 (10000-5000) 0 1])
title('输出y','FontSize',20)
ylabel('y(V)','FontSize',12)

%% prepare data for draw3,draw4
load 'modelparas'

%% draw3
[X,Y]=LSM_Data(yst,ust,optimcenter);
y_pre=X*beta;
error=Y-y_pre;
subplot(2,1,1)
plot(Y,'k')
hold on
plot(y_pre,'r--')
axis([0 4000 0 1])
ylabel('y(V)','FontSize',12)
legend({'实际输出','RBF-ARX模型输出'},'FontSize',15)
title('系统输出','FontSize',20)
subplot(2,1,2)
plot(error,'k')
axis([0 4000 -0.1 0.1])
ylabel('residual(V)','FontSize',12)
title('残差','FontSize',20)

%% draw4
edges = linspace(-0.04,0.04,1000);
h=histogram(error,edges);
h.DisplayStyle='stair';
h.EdgeColor = [1 0 0];
xlabel('residual(V)','FontSize',12)
title('残差分布','FontSize',20)

%% draw5
[X,Y]=LSM_Data(ysv,usv,optimcenter);
y_pre=X*beta;
error=Y-y_pre;
subplot(2,1,1)
plot(Y,'k')
hold on
plot(y_pre,'r--')
axis([0 4000 0 1])
ylabel('y(V)','FontSize',12)
legend({'实际输出','RBF-ARX模型输出'},'FontSize',15)
title('系统输出','FontSize',20)
subplot(2,1,2)
plot(error,'k')
axis([0 4000 -0.1 0.1])
ylabel('residual(V)','FontSize',12)
title('残差','FontSize',20)

%% draw6
edges = linspace(-0.04,0.04,1000);
h=histogram(error,edges);
h.DisplayStyle='stair';
h.EdgeColor = [1 0 0];
xlabel('residual(V)','FontSize',12)
title('残差分布','FontSize',20)