function [output] = ICI(similarity_ak, ak, L, MuInf_Pre)

sum = 0;
for i = 1:length(L)
    sum = sum + FGH(similarity_ak, ak) - MuInf_Pre(ak, L(i));
%     sum = sum + FGH(similarity_ak, ak) - IFGH(similarity_ak, similarity_L, ak, L(i));
end

output = sum / length(L);
end

