function [tableNew] = geneLabelDis(table)
%GENELABELDIS �˴���ʾ�йش˺�����ժҪ
%   ���ɱ�ǩ�ֲ������ݼ�
[m n] = size(table);
decisionClass = arrayfun(@(x) table(table(:,end)==x,:), unique(table(:,end)), 'UniformOutput', false);        %�����ݼ����վ������Է���
multiLabel = zeros(m, length(decisionClass)-1);            %�����Ƿֲ��ľ���
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
        multiLabel(temp, j) = minSim(decisionClass,i,j);        %����ÿһ��ģ��������
    end
    tempSum = sum(multiLabel(temp,:));
    for j = 1:length(decisionClass)-1
        multiLabel(temp, j) = multiLabel(temp, j) / tempSum;        %��һ������
    end
    temp = temp + 1;
end
tableNew = [table(:,1:end-1) multiLabel];
end

