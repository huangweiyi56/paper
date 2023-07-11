function [output,index] = getMissLabel(data, alpha)

[m,n] = size(data);
data = sortrows(data,n);          
Label = data(:,n);              
classNum = unique(Label);       
missCount = zeros(1,length(classNum));       
missSum = zeros(1,length(classNum));      
for i = 1:length(missSum)
   missSum(i) =  floor(alpha * sum(Label == classNum(i)));
end
k = 1;
for i = 1:m
   if missCount(k) < missSum(k) && data(i,n) == classNum(k)
       missCount(k) = missCount(k) + 1;
       data(i,n) = 999;
   elseif data(i,end) ~= classNum(k)
           k = k + 1;
           if missSum(k) ~= 0
               missCount(k) = missCount(k) + 1;
               data(i,n) = 999;
           end
   end
end
index = find(data(:,n)~=999);
output = sortrows(data,n);     

end


