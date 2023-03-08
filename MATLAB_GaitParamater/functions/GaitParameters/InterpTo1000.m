function [ Data1000 ] = InterpTo1000( Data )
            Ratio = 0.001*(size(Data,1)-1);
            Data1000(1,1:1001) = interp1(1:size(Data,1),Data,1:Ratio:(size(Data,1))) ;
end