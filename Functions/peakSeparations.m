function y = peakSeparations(S)
    if isequal(class(S),'struct')
        T = S.T_s_;
        V = S.inverted_V_;
        n = 28;
        peaksLogic = islocalmax(V,'MinSeparation',4650);
        peaksID = find(peaksLogic);
        peaksV = V(peaksID);
        peaksT = T(peaksID);
        peaks = [peaksT peaksV];
        
        separations = diff(peaks);
        y = separations(:,1);        
    end    
end