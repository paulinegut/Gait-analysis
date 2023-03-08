function S = extractCoM(S)

for dim = 1:3
    S.points.CoM(:,dim) = mean([S.points.RASI(:,dim) S.points.LASI(:,dim) S.points.SACR(:,dim)] , 2);
end 

for i = 1:length(S.R)
    for dim = 1:3
        S.R(i).points.CoM(:,dim) = mean([S.R(i).points.RASI(:,dim) S.R(i).points.LASI(:,dim) S.R(i).points.SACR(:,dim)] , 2);
    end 
end

for i = 1:length(S.L)
    for dim = 1:3
        S.L(i).points.CoM(:,dim) = mean([S.L(i).points.RASI(:,dim) S.L(i).points.LASI(:,dim) S.L(i).points.SACR(:,dim)] , 2);
    end 
end

end

