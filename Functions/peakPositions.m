function y = peakPositions(S)
    if isequal(class(S),'struct')
        T = S.T_s_;
        V = S.inverted_V_;
        n = 28;
        peaksLogic = islocalmax(V,'MinSeparation',4650);
        peaksID = find(peaksLogic);
        peaksV = V(peaksID);
        peaksT = T(peaksID);
        peaks = [peaksT peaksV];
        y.T_s_ = peaksT;
        y.peaks_V_ = peaksV;
    end    
end