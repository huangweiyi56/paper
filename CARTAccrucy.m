function [Accrucy, STD] = CARTAccrucy(Red, fea_original, gnd_original)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
rng(0,'twister');

condition_attribute = fea_original(:,Red);
desicion_attribute = gnd_original;
acc_result = zeros(1,10);

for i = 1:10
MdlDefault = fitctree(condition_attribute,desicion_attribute,'CrossVal','on');
% �����Ĵ�����
    classErrorDefault = kfoldLoss(MdlDefault);
% �����ľ���
    acc_result(i) = (1 - classErrorDefault)*100;
end
Accrucy = mean(acc_result);
STD = std(acc_result);
end


