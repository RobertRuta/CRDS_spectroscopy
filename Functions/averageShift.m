function y = averageShift(S)

    peaks = peakPositions(S);
    
    dt = 0;
    
    peaksT = peaks.T_s_;

    numofPeaks = numel(peaksT);
    
    T = S.T_s_;
    V = S.inverted_V_;
    
    V_o = V( peaksT(1)+dt*10^(-6) <= T & T < peaksT(2)+dt*10^(-6));
    V_sum = V_o;
    if isequal(class(S),'struct')        

        count = 0;
        count1 = 0;
        count2 = 0;
        
        for i = 2:1:numofPeaks-1
            tRange = peaksT(i)+dt*10^(-6) <= T & T < peaksT(i+1)+dt*10^(-6);
            V_new = V(tRange);
            
            if numel(V_new) == numel(V_sum)
                V_sum = V_sum + V_new;
                count = count + 1;
            
            else
                if numel(V_new) > numel (V_sum)
                    d = abs( numel(V_new) - numel(V_sum) );
                    V_new(end-d+1:end) = [];
                    V_sum = V_sum + V_new;
                    count1 = count1 + 1;
                else
                    d = abs( numel(V_new) - numel(V_sum) );
                    V_new = [V_new; zeros(d,1)]
                    V_sum = V_sum + V_new;
                    count2 = count2 + 1;                    
                end
            end    
        end
        V_ave = V_sum / numofPeaks;        
        V_ave = timifyDomain(V_ave,20e-9,0);
        y.T_s_ = V_ave(:,1);
        y.ave_V_ = V_ave(:,2);
        plot(y.T_s_,y.ave_V_);
    end
end
