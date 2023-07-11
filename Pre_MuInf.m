function [MuInf, ThreeMuInf] = Pre_MuInf(similarity_C, similarity_D, C, D)
[m,~,~] = size(similarity_C);
MuInf = 0;
ThreeMuInf = zeros(1, C);
% Ctmp_matrix = ones(m,m);
allSet = ones(m,m);                    

similarity_C_c = ones(m,m);
similarity_D_c = ones(m,m);

for i = 1:size(C,2)
    similarity_C_c = min(similarity_C_c, similarity_C(:,:,C(i)));
end
for i = 1:size(D,2)
    similarity_D_c = min(similarity_D_c, similarity_D(:,:,D(i)));
end


Ctmp_matrix = allSet - similarity_C_c;  
Dtmp_matrix = allSet - similarity_D_c;  

% MuSimilrity = min(Ctmp_matrix(:,:,C), Dtmp_matrix(:,:,D));
MuSimilrity = min(Ctmp_matrix, Dtmp_matrix);

for i = 1:m
    similarClass1 = sum(MuSimilrity(i,:));
    MuInf = MuInf + similarClass1/m;
end
MuInf = MuInf / m;

%%%%%%%%%%%%%%%%%%%%%%%

% for j = 1:C
%    temp = min(similarity_C_c, similarity_C(:,:,j));
%    temp1 = allSet - temp;
%    ThreeSimilrity = min(temp1,Dtmp_matrix);
% %    ThreeSimilrity = min(MuSimilrity,similarity_C(:,:,j));
%    for i = 1:m
%        similarClass2 = sum(ThreeSimilrity(i,:));
%        ThreeMuInf(j) = ThreeMuInf(j) + similarClass2/m;
%    end
%    ThreeMuInf(j) = ThreeMuInf(j)/m;
% end

end

