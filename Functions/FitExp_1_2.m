function [f1,f2] = FitExp_1_2(dataStructure,cutoff)

    x = dataStructure.T_s_;
    y = dataStructure.ave_V_;
    
    base = mean(y(floor(0.3*end) : floor(0.7*end) ));
    
    x(1) = [];
    y(1) = [];

    y = y(1:floor(cutoff*end));
    x = x(1:floor(cutoff*end));
    
    
    y = y - base;
    
    x_ = mean(x);
    sd = std(x);
    
    xnorm = (x - x_)/sd;
    
    %Start of 1 term exponential fitting process
    
    [ft1,gof1] = fit(xnorm,y,'exp1');
    
        a1 = ft1.a * exp(-ft1.b*x_/sd);
        b1 = ft1.b/sd;
        
        y_fit1 = a1*exp(b1*x);
    
    figure;    
    plot (x,y,'.k');
    hold on;
    plot (x,y_fit1,'-r','linewidth',1);
    hold off;
    %End of 1 term exponential fit
    
    %Start of 2 term exponential fit
    
    [ft2,gof2] = fit(xnorm,y,'exp2');
    
    a2 = ft2.a * exp(-ft2.b*x_/sd);
    b2 = ft2.b/sd;
    c2 = ft2.c * exp(-ft2.d*x_/sd);
    d2 = ft2.d/sd;
    
    y_fit2 = a2*exp(b2*x) + c2*exp(d2*x);
    
    figure;
    plot (x,y,'.k');
    hold on;
    plot (x,y_fit2,'-r','linewidth',1);
    hold off;
    
    f1.cutoff = cutoff;
    f1.a = a1;
    f1.b = b1;
    f1.x = x;
    f1.y = y;
    f1.yft = y_fit1;
    f1.sse = gof1.sse;
    f1.rsquare = gof1.adjrsquare;
    
    f2.cutoff = cutoff;
    f2.a = a2;
    f2.b = b2;
    f2.c = c2;
    f2.d = d2;
    f2.x = x;
    f2.y = y;
    f2.yft = y_fit2;
    f2.sse = gof2.sse;
    f2.rsquare = gof2.adjrsquare;
    

    
    