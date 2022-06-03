function y = PulseSeparation(S,peakA)

    if isequal(class(S), 'struct') && nargin == 2
        %names = fieldnames(S);           
        T = S.T_s_;
        V = S.inverted_V_;
        
        peakIDs = V > peakA;
        timeIDs = T(peakIDs);
        d = diff(timeIDs);
        
        D = d > 0.01e-3;
        
        timeOIDs = [true; D];
        times = timeIDs(timeOIDs);
        
        y = mean(diff(times));
    
    else
        error('Please provide 2 arguments, and make sure input table is a structure of arrays.');
    end
end