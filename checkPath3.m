%% checkPath3.m	
function feasible=checkPath3(n,newPos,origin, size)
feasible=true;
size=size/2;
% disp(size);
movingVec = [newPos(1)-n(1),newPos(2)-n(2),newPos(3)-n(3)];
movingVec = movingVec/sqrt(sum(movingVec.^2)); %单位化
% 判断是否与障碍物矩形相交
if  (n(1) < (origin(1)+size(1)) && n(1) > (origin(1)-size(1))) && (n(2) < (origin(2)+size(2)) && n(2) > (origin(2)-size(2))) && (n(3) < (origin(3)+size(3)) && n(3) > (origin(3)-size(3)))
    feasible=false;
    return;
elseif  (newPos(1) < (origin(1)+size(1)) && newPos(1) > (origin(1)-size(1))) && (newPos(2) < (origin(2)+size(2)) && newPos(2) > (origin(2)-size(2))) && (newPos(3) < (origin(3)+size(3)) && newPos(3) > (origin(3)-size(3)))
    feasible=false;
    return;
else
    t=(origin(1)+size(1)-n(1))/movingVec(1);
    y=n(2)+movingVec(2)*t;
    z=n(3)+movingVec(3)*t;
    if (y < (origin(2)+size(2)) && y > (origin(2)-size(2))) && (z < (origin(3)+size(3)) && z > (origin(3)-size(3)))
        feasible=false;
        return;
    end
    t=(origin(1)-size(1)-n(1))/movingVec(1);
    y=n(2)+movingVec(2)*t;
    z=n(3)+movingVec(3)*t;
    if (y < (origin(2)+size(2)) && y > (origin(2)-size(2))) && (z < (origin(3)+size(3)) && z > (origin(3)-size(3)))
        feasible=false;
        return;
    end
    t=(origin(2)+size(2)-n(2))/movingVec(2);
    x=n(1)+movingVec(1)*t;
    z=n(3)+movingVec(3)*t;
    if (x < (origin(1)+size(1)) && x > (origin(1)-size(1))) && (z < (origin(3)+size(3)) && z > (origin(3)-size(3)))
        feasible=false;
        return;
    end
    t=(origin(2)-size(2)-n(2))/movingVec(2);
    x=n(1)+movingVec(1)*t;
    z=n(3)+movingVec(3)*t;
    if (x < (origin(1)+size(1)) && x > (origin(1)-size(1))) && (z < (origin(3)+size(3)) && z > (origin(3)-size(3)))
        feasible=false;
        return;
    end
    t=(origin(3)+size(3)-n(3))/movingVec(3);
    x=n(1)+movingVec(1)*t;
    y=n(2)+movingVec(2)*t;
    if (x < (origin(1)+size(1)) && x > (origin(1)-size(1))) && (y < (origin(2)+size(2)) && y > (origin(2)-size(2)))
        feasible=false;
        return;
    end
    t=(origin(3)-size(3)-n(3))/movingVec(3);
    x=n(1)+movingVec(1)*t;
    y=n(2)+movingVec(2)*t;
    if (x < (origin(1)+size(1)) && x > (origin(1)-size(1))) && (y < (origin(2)+size(2)) && y > (origin(2)-size(2)))
        feasible=false;
        return;
    end
end
end