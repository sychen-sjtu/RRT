%% 绘制障碍物(以球为例，主要是方便计算)
origin = [100,0,50];
rectsize=[200,30,150];
%下面开始画
figure(1);
plotcube([200 30 100],[0  -15  -25],1,[1 0 0]);
axis equal
%% 参数
source=[100 100 10];
goal=[100 -100 10];
stepsize = 5;
threshold = 5;
maxFailedAttempts = 10000;
display = true;
searchsize = [200 400 200];      %探索空间六面体
%% 绘制起点和终点
hold on;
scatter3(source(1),source(2),source(3),"filled","g");
scatter3(goal(1),goal(2),goal(3),"filled","b");

tic;  % tic-toc: Functions for Elapsed Time
RRTree = double([source -1]);
failedAttempts = 0;
pathFound = false;

%% 循环
while failedAttempts <= maxFailedAttempts  % loop to grow RRTs
    %% chooses a random configuration
    if rand < 0.5
        sample = (rand(1,3)-[0 0.75 0.2]);   % random sample
        sample = sample .* searchsize;
    else
        sample = goal; % sample taken as goal to bias tree generation to goal
    end
    %% selects the node in the RRT tree that is closest to qrand
    [A, I] = min( distanceCost(RRTree(:,1:3),sample) ,[],1); % find the minimum value of each column
    closestNode = RRTree(I(1),1:3);
    %% moving from qnearest an incremental distance in the direction of qrand
    movingVec = [sample(1)-closestNode(1),sample(2)-closestNode(2),sample(3)-closestNode(3)];
    movingVec = movingVec/sqrt(sum(movingVec.^2));  %单位化
    if rand < 0.5
        newPoint=closestNode + stepsize * movingVec;
    else
        newPoint=goal;
    end
    if ~checkPath3(closestNode, newPoint, origin,rectsize) % if extension of closest node in tree to the new point is feasible
        failedAttempts = failedAttempts + 1;
        continue;
    end

    if distanceCost(newPoint,goal) < threshold, pathFound = true; break; end % goal reached
    [A, I2] = min( distanceCost(RRTree(:,1:3),newPoint) ,[],1); % check if new node is not already pre-existing in the tree
    if distanceCost(newPoint,RRTree(I2(1),1:3)) < threshold, failedAttempts = failedAttempts + 1; continue; end 
    
    RRTree = [RRTree; newPoint I(1)]; % add node
    failedAttempts = 0;
    if display, plot3([closestNode(1);newPoint(1)],[closestNode(2);newPoint(2)],[closestNode(3);newPoint(3)],'LineWidth',1); end
    pause(0.05);
end

if display && pathFound, plot3([closestNode(1);goal(1)],[closestNode(2);goal(2)],[closestNode(3);goal(3)]); end

% if display, disp('click/press any key'); waitforbuttonpress; end
if ~pathFound, error('no path found. maximum attempts reached'); end

%% retrieve path from parent information
path = goal;
prev = I(1);
while prev > 0
    path = [RRTree(prev,1:3); path];
    prev = RRTree(prev,4);
end

pathLength = 0;
for i=1:length(path(:,1))-1, pathLength = pathLength + distanceCost(path(i,1:3),path(i+1,1:3)); end % calculate path length
fprintf('processing time=%d \nPath Length=%d \n\n', toc, pathLength); 
figure(2)
plotcube([200 30 100],[0  -15  -25],1,[1 0 0]);
axis equal
hold on;
scatter3(source(1),source(2),source(3),"filled","g");
scatter3(goal(1),goal(2),goal(3),"filled","b");
plot3(path(:,1),path(:,2),path(:,3),'LineWidth',2,'color','y');

mdl_puma560;
p560.links(2).a = 100;
p560.links(3).a = 10;
p560.links(3).d = 20;
p560.links(4).d = 100;
figure(3);
plotcube([200 30 100],[0  -15  -25],1,[1 0 0]);
hold on;
plot3(path(:,1),path(:,2),path(:,3),'LineWidth',2,'color','y');
q=[];
for i=1:length(path)-1
    distance=distanceCost(path(i,1:3),path(i+1,1:3));
    t1=[0:0.5:distance/5.0];
    q_start=p560.ikine6s(transl(path(i,:)));
    q_end=p560.ikine6s(transl(path(i+1,:)));
    q=[q;mtraj(@tpoly, q_start, q_end, t1)];
end
p560.plot(q);


%% plot q
figure(5)
t_list=1:length(q);
plot(t_list,q);
legend('q1','q2','q3','q4',"q5","q6");