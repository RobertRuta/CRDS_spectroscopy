function Results = findResults(fit,fitN,crossSec)

    b = fit.b;
    d = fit.d;
    
    bN1 = fitN.b;
    bN2 = fitN.d

    tau1 = -1/b;
    tau2 = -1/d;    
    tau = max(tau1,tau2);
    
    tau_o1 = -1/bN1;
    tau_o2 = -1/bN2;
    tau_o = max(tau_o1,tau_o2);
    

    %absorption coefficient in cm^-1
    absorption = (1/299792458e2) * ((1/tau) - (1/tau_o));
    %NO2 cross section associated with 411nm laser in cm^2

    N = absorption / crossSec;

    Results.absorption = absorption;
    Results.N = N;
    Results.tau1 = tau1;
    Results.tau2 = tau2;
    
end