mdl_puma560;
p560.links(2).a = 100;
p560.links(3).a = 10;
p560.links(3).d = 20;
p560.links(4).d = 100;
plotcube([200 30 100],[0  -15  -25],1,[1 0 0]);
hold on;
q1 = p560.ikine6s(transl(100, 100, 10));
q2 = p560.ikine6s(transl(50, 50, 150));
q3 = p560.ikine6s(transl(50, -50, 150));
q4 = p560.ikine6s(transl(100, -100, 10));
t1 = [0:0.05:2];
t2 = [0:0.05:2];
t3 = [0:0.05:2];
q1 = mtraj(@tpoly, q1, q2, t1);
q2 = mtraj(@tpoly, q2, q3, t2);
q3 = mtraj(@tpoly, q3, q4, t3);
q = [q1; q2; q3];
path=[100 100 10;50 50 150;50 -50 150;100 -100 10];
plot3(path(:,1),path(:,2),path(:,3),'LineWidth',2,'color','g');
p560.plot(q);

%% plot q
figure(5)
t_list=1:length(q);
plot(t_list,q);
legend('q1','q2','q3','q4',"q5","q6");