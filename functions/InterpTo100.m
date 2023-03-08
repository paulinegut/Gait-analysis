function [ Data100 ] = InterpTo100_New( Data )
            Ratio = (1/100)*(size(Data,1)-1);
            Data100(1,:) = interp1(1:size(Data,1),Data,1:Ratio:size(Data,1)-1) ;
            
    
            
            if length(Data100) < 99
                Data100(1,99) = Data100(1,98);
            end
            
            if length(Data100) < 100
                Data100(1,100) = Data100(1,99);
            end
end
