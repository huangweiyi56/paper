function [tableNew] = geneLabelDis(table)
%GENELABELDIS 此处显示有关此函数的摘要
%   生成标签分布的数据集
[m n] = size(table);
decisionClass = arrayfun(@(x) table(table(:,end)==x,:), unique(table(:,end)), 'UniformOutput', false);        %将数据集按照决策属性分类
multiLabel = zeros(m, length(decisionClass)-1);            %定义标记分布的矩阵
temp = 1;
for i = 1:length(decisionClass)-1
    classInnerNum = size(decisionClass{i},1);
    for j = 1:classInnerNum
        multiLabel(temp ,i) = 1;
        temp = temp + 1;
    end
end
for i = 1:size(decisionClass{length(decisionClass)},1)
    for j = 1:length(decisionClass)-1
        multiLabel(temp, j) = minSim(decisionClass,i,j);        %计算每一个模糊隶属度
    end
    tempSum = sum(multiLabel(temp,:));
    for j = 1:length(decisionClass)-1
        multiLabel(temp, j) = multiLabel(temp, j) / tempSum;        %归一化处理
    end
    temp = temp + 1;
end
tableNew = [table(:,1:end-1) multiLabel];
end

