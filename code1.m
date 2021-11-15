mdl_puma560;
p560.links(2).a = 100;
p560.links(3).a = 10;
p560.links(3).d = 20;
p560.links(4).d = 100;
N=10000;                                              
theta1 = -90/180*pi+(90/180*pi+90/180*pi)*rand(N,1); 
theta2 = -90/180*pi+(90/180*pi+90/180*pi)*rand(N,1);   
theta3 = -90/180*pi+(90/180*pi+90/180*pi)*rand(N,1);
theta4 = 0;
theta5 = 0;
theta6 = 0;
points=zeros(N,3);
parfor n=1:N
	p560_point=p560.fkine([theta1(n) theta2(n) theta3(n) theta4 theta5 theta6]);
	tran_point = p560_point.t;
    points(n,:)=tran_point;
end
scatter3(points(:,1), points(:,2), points(:,3), 5, 'g', 'filled')

