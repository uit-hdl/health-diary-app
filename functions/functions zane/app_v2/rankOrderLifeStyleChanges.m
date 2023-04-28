function NewOrder = rankOrderLifeStyleChanges(clusters,potSRHarray,textArray)
% Computes new order for the suggested lifestyle modifications. Reorders on
% two levels: Within each cluster of modifications (grouped by type), and
% between clusters, according to SRH effect and maximum SRH effect for each
% group respectively.
%% Code
Nchanges = numel(clusters);
healthFactors = unique(clusters);
Nfactors = numel(healthFactors);

% ¤¤¤ Change Order Internally within each Cluster ¤¤¤
clusterInd = cell(1,Nfactors);  % saves index for each cluster
clusterMax = zeros(1,Nfactors); % saves maximum SRH for each cluster
for i=1:Nfactors
    
    I = strcmp(clusters, healthFactors{i});
    [S, S_index] = sort(potSRHarray(I));
    potSRHarray(I) = S;
    txt = textArray(I);
    textArray(I) = txt(S_index);
    
    clusterMax(i) = S(end);
    clusterInd{i} = I;
end

[~, J_clusters] = sort(clusterMax);
% ¤¤¤ Reorder the Clusters by Cluster Maximum ¤¤¤
NewOrder.textArray = cell(1,Nchanges);
NewOrder.clusters     = cell(1,Nchanges);
NewOrder.SRHarray  = zeros(1,Nchanges);

k0 = 0;
for i=1:Nfactors
    Icluster_i = clusterInd{J_clusters(i)};
    k1 = sum(Icluster_i) + k0;
    
    NewOrder.textArray(k0+1:k1) = textArray(Icluster_i);
    NewOrder.SRHarray(k0+1:k1)  = potSRHarray(Icluster_i);
    NewOrder.clusters(k0+1:k1)  = clusters(Icluster_i);
    
    k0 = k1;
end

end