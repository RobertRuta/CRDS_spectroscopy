function f = fitExp2(S,cutoff)
    
    x = S.T_s_;
    y = S.ave_V_;
    
    base = mean(y(floor(0.3*end) : floor(0.7*end) ));
    
    x(1) = [];
    y(1) = [];

    y = y(1:floor(cutoff*end));
    x = x(1:floor(cutoff*end));
    
    
    y = y - base;
    
    x_ = mean(x);
    sd = std(x);
    
    xnorm = (x - x_)/sd;
    
    %ft = fit(xnorm,y,'a*exp(b*x)+c');
    [ft,goodness] = fit(xnorm,y,'exp2');
    
    a = ft.a * exp(-ft.b*x_/sd);
    b = ft.b/sd;
    c = ft.c * exp(-ft.d*x_/sd);
    d = ft.d/sd;
    
    y_fit = a*exp(b*x) + c*exp(d*x);
    
    plot (x,y,'.k');
    hold on;
    plot (x,y_fit,'-r','linewidth',1);
    hold off;
    
    f.cutoff = cutoff;
    f.a = a;
    f.b = b;
    f.c = c;
    f.d = d;
    f.x = x;
    f.y = y;
    f.yft = y_fit;
    f.sse = goodness.sse;
end