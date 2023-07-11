function [Accrucy, STD] = knnAccrucy(Red, fea_original, gnd_original)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

rng(0,'twister');   %ʮ�۽�����֤ʱ��ʹ������ӹ̶�
condition_attribute = fea_original(:,Red);
desicion_attribute = gnd_original;
acc_result = zeros(1,10);
for i = 1:10
    KnnModel = fitcknn(condition_attribute,desicion_attribute,'NumNeighbors',5);
    %���㽻����֤��ʧ��������Ϊģ�͵�ָ�꣬ԽСģ��Խ�á�
    KnnCVMdl = crossval(KnnModel);  
    acc_result(i) = (1 - kfoldLoss(KnnCVMdl))*100;
end

Accrucy = mean(acc_result);
STD = std(acc_result);
end

