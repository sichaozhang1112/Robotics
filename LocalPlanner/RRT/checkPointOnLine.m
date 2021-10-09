function [isOnLine] = checkPointOnLine(point,line)

isOnLine=0;

side = (line(2,2)-point(2))*(line(1,1)-point(1))-(line(1,2)-point(2))*(line(2,1)-point(1));
if (side==0)
    if (point(2)<=max(line(1,2),line(2,2)) && point(2)>=min(line(1,2),line(2,2)))
        if (point(1)<=max(line(1,1),line(2,1)) && point(1)>=min(line(1,1),line(2,1)))
            isOnLine = 1;
            return;
        end
    end
end

end