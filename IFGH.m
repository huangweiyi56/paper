function [MI] = IFGH(similarity_C, similarity_D, C, D)

[m,~,~] = size(similarity_C);
MI = 0;
similarity_C_c = ones(m,m);
similarity_D_c = ones(m,m);

allSet = ones(m,m);                  


for i = 1:size(C,2)
    similarity_C_c = min(similarity_C_c, similarity_C(:,:,C(i)));
end

Ctmp_matrix = allSet - similarity_C_c;  %����
Dtmp_matrix = allSet - similarity_D;  %����

for i = 1:m
    similarClass = sum(min(Ctmp_matrix(i,:),Dtmp_matrix(i,:)));
    MI = MI + similarClass/m;
end

MI = MI / m;

end

