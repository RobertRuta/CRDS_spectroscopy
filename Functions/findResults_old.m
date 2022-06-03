function Results = findResults(fit,fitN,crossSec)

    if(fit.b < 0)
        b = fit.b;
    else
        b = -1e30;
    end
    coefs = [b];
    if(isfield(fit,'c'))
        if(fit.d<0)
            d = fit.d;
            coefs = [b d];    
        end
    end
    if(isfield(fit,'f'))
        if(fit.f < 0)
            f = fit.f;
            coefs = [b d f];
        end
    end
    
    bN = fitN.b;
    coefsN = [bN];
    if(isfield(fitN,'d'))
        if(fitN.d < 0)
            dN = fitN.d;
            coefsN = [bN dN];
        end
    end
    if(isfield(fitN,'f'))
        if(fitN.f < 0)
            fN = fitN.f;
            coefsN = [bN dN fN];
        end
    end
    
    coef = max(coefs);
    coefN = max(coefsN);    

    tau = -1/coef;
    tau_o = -1/coefN;
    %absorption coefficient in cm^-1
    absorption = (1/299792458e2) * ((1/tau) - (1/tau_o));
    %NO2 cross section associated with 411nm laser in cm^2
    N = absorption / crossSec;
    Results.tau = tau;
    Results.absorption = absorption;
    Results.N = N;
end