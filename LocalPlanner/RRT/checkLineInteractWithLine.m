function [isCollide] = checkLineInteractWithLine(point1_1,point1_2,point2_1,point2_2)
isCollide=0;
isOnLine=0;
line1=[point1_1;point1_2];
line2=[point2_1;point2_2];
isOnLine=isOnLine|checkPointOnLine(point1_1,line2);
isOnLine=isOnLine|checkPointOnLine(point1_2,line2);
isOnLine=isOnLine|checkPointOnLine(point2_1,line1);
isOnLine=isOnLine|checkPointOnLine(point2_2,line1);
if(isOnLine)
    isCollide=1;
    return;
end

side_point21_line1 = (point1_1(2)-point2_1(2))*(point1_2(1)-point2_1(1))-(point1_2(2)-point2_1(2))*(point1_1(1)-point2_1(1));
side_point22_line1 = (point1_1(2)-point2_2(2))*(point1_2(1)-point2_2(1))-(point1_2(2)-point2_2(2))*(point1_1(1)-point2_2(1));
side_point11_line2 = (point2_1(2)-point1_1(2))*(point2_2(1)-point1_1(1))-(point2_2(2)-point1_1(2))*(point2_1(1)-point1_1(1));
side_point12_line2 = (point2_1(2)-point1_2(2))*(point2_2(1)-point1_2(1))-(point2_2(2)-point1_2(2))*(point2_1(1)-point1_2(1));
if (sign(side_point21_line1)~=sign(side_point22_line1) && sign(side_point11_line2)~=sign(side_point12_line2)) 
    isCollide = 1;
end

end