function [output] = objectiveFunction2(similarity_ak, ak, B, L, MuInf_Pre, similarityFuzzy)

sum1 = 0;
Llength = length(L);
Bsize = length(B);

[m,~,~] = size(similarity_ak);
allSet = ones(m,m);
ThreeMuInf = 0;

if isempty(B)
    for i = 1:Llength
        sum1 = sum1 + MuInf_Pre(ak, L(i));
%         sum = sum + IFGH(similarity_ak, similarity_L, ak, L(i));
    end
    output = sum1 * (Llength + 1) / Llength - FGH(similarity_ak, ak);
    
else
    for i = 1:Llength
        for j = 1:Bsize
%             sum = sum + conIFGH(ak, B(j), L(i), MuInf_Pre, ThreeMuInf_Pre) - JIFGH(ak, B(j), L(i), MuInf_Pre, ThreeMuInf_Pre)/Bsize;
            temp = min(similarity_ak(:,:,ak), similarity_ak(:,:,B(j)));
            similarity_D_c = similarityFuzzy(:,:, L(i));
            Dtmp_matrix = allSet - similarity_D_c;
            temp1 = allSet - temp;
            ThreeSimilrity = min(temp1,Dtmp_matrix);
            for k = 1:m
               similarClass2 = sum(ThreeSimilrity(k,:));
               ThreeMuInf = ThreeMuInf + similarClass2/m;
           end
           ThreeMuInf = ThreeMuInf/m;
           sum1 = sum1 + MuInf_Pre(ak, L(i)) - JIFGH(ak, B(j), L(i), MuInf_Pre, ThreeMuInf)/Bsize;
        end
    end
    output = sum1 - ICI(similarity_ak, ak, L, MuInf_Pre);
    
end


end

