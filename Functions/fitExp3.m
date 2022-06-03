function fun = fitExp3(S,cutoff)
    
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
    
    ft = fit(xnorm,y,'a*exp(b*x)+c*exp(d*x)+e*exp(f*x)');
    %ft = fit(xnorm,y,'exp2');
    
    a = ft.a * exp(-ft.b*x_/sd);
    b = ft.b/sd;
    c = ft.c * exp(-ft.d*x_/sd);
    d = ft.d/sd;
    e = ft.e * exp(-ft.f*x_/sd);
    f = ft.f/sd;
    
    y_fit = a*exp(b*x) + c*exp(d*x) + e*exp(f*x);
    
    plot (x,y,'.k');
    hold on;
    plot (x,y_fit,'-r','linewidth',1);
    hold off;
    
    fun.cutoff = cutoff;
    fun.a = a;
    fun.b = b;
    fun.c = c;
    fun.d = d;
    fun.e = e;
    fun.f = f;
    fun.x = x;
    fun.y = y;
    fun.yft = y_fit;
end