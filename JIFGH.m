function [threeMI] = JIFGH(ak, B, L, MuInf_Pre, ThreeMuInf_Pre)

threeMI = MuInf_Pre(ak, L) + MuInf_Pre(B, L) - ThreeMuInf_Pre;
% threeMI = IFGH(similarity_ak, similarity_L, ak, L) + IFGH(similarity_B, similarity_L, B, L) - IFGH(similarity_B, similarity_L, [ak B], L);
end

