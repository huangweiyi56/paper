function [ent] = FGH(similarity_matrix, R)

m=size(similarity_matrix,1);
tmp_matrix = ones(m,m);
for i = 1:size(R,2) 
    tmp_matrix = min(tmp_matrix, similarity_matrix(:,:,R(i)));
end
ent = 0;

for i = 1:m
    similarClass = sum(tmp_matrix(i,:));
    ent = ent + similarClass/m;
end

ent = 1 - ent / m;

end

