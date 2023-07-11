function [Accrucy, STD] = CARTAccrucy(Red, fea_original, gnd_original)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
rng(0,'twister');

condition_attribute = fea_original(:,Red);
desicion_attribute = gnd_original;
acc_result = zeros(1,10);

for i = 1:10
MdlDefault = fitctree(condition_attribute,desicion_attribute,'CrossVal','on');
% 求分类的错误率
    classErrorDefault = kfoldLoss(MdlDefault);
% 求分类的精度
    acc_result(i) = (1 - classErrorDefault)*100;
end
Accrucy = mean(acc_result);
STD = std(acc_result);
end


