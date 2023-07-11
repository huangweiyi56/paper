clear all
clc
% warning('off')
% addpath(genpath(pwd));


filename = {'wine'};
for k=1:size(filename,2)
    load([filename{k} '.mat']);
%     fea = Musk2(:,1:end-1);
%     gnd = Musk2(:,end);
    workVar = whos;
    if length(workVar) == 2
        file = load([filename{k} '.mat']);
        dataTable = getfield(file,filename{k});
        fea = dataTable(:,1:end-1);
        gnd = dataTable(:,end);
    else 
        switch workVar(1).name
            case 'attributes'
                fea = attributes;
                gnd = class;
            case 'X'
                fea = X;
                gnd = Y;
        end
    end
    %
    fea_Granular = fea;
    gnd_Granular = gnd;

    for i = 1:size(fea, 2)
        if length(unique(fea(:,i))) > 9
            disp('Discrete processing')
            fea = discretization(fea, 3);    
            break
        end
    end

    fea_original = fea;
    gnd_original = gnd;
    data = [fea gnd];
    dimen = 1;
    resultReduct = cell(1,6,5);
    resultMatrix = zeros(4,6,5);
    
    
    alpha = 0.2
    
    [table,Granu_index] = getMissLabel(data, alpha);
    [m, n] = size(table);
    tableNew = geneLabelDis(table);

    %Missing labels
    fea = table(:,1:n-1);
    gnd = table(:,n);
    missPoint = m - sum(table(:,n) == 999) + 1;
    rand_vector = missPoint:m;
    
    tic;
    %% Find the similarity matrix
    similarityRough = Similarity_rough(tableNew(:,1:n-1));         %attribute
    similarityFuzzy = Similarity_fuzzy(tableNew(:,n:end));         %label

    %% Store Pre_MuInf ahead of time
    C = 1:n-1;    
    L = 1:size(similarityFuzzy,3);  

    MuInf_Pre = zeros(n-1,length(L));
    ThreeMuInf_Pre = zeros(n-1,n-1,length(L));
    for i = 1:n-1
        for j = 1:length(L)
            [MuInf_Pre(i,j), ThreeMuInf_Pre(i, 1:i, j)] = Pre_MuInf(similarityRough, similarityFuzzy, i, j);
            %ThreeMuInf_Pre(1:i, i, j) = ThreeMuInf_Pre(i, 1:i, j);
        end 
    end

    %% 
    similarity_D_c = ones(m,m);
    for i = 1:size(L,2)
        similarity_D_c = min(similarity_D_c, similarityFuzzy(:,:,L(i)));
    end


    Reduct2 = [];    
    Hdc = IFGH(similarityRough, similarity_D_c, C, L);
    p = 0;
    while p ~= Hdc
       remainAtt = setdiff(C,Reduct2);
       temp = zeros(1,length(remainAtt));
       for i = 1:length(remainAtt)
           temp(i) = objectiveFunction2(similarityRough, remainAtt(i), Reduct2, L, MuInf_Pre, similarityFuzzy);
       end
       [~,index] = max(temp);
       Reduct2 = [Reduct2 remainAtt(index)];
       p1 = IFGH(similarityRough, similarity_D_c, Reduct2, L);
       p = p1;
    end
    time1=toc;

    condition_attribute = fea_original(:,Reduct2);
    [my2_knnaccrucy1, my2_knnstd1] = knnAccrucy(Reduct2, fea_original, gnd_original);
    [my2_CARTaccrucy1, my2_CARTstd1] = CARTAccrucy(Reduct2, fea_original, gnd_original);
    [my2_SVMaccrucy, my2_SVMstd] = classifier_ECOC_SVM(condition_attribute, gnd_original);
    disp(['time',num2str(time1)])

end