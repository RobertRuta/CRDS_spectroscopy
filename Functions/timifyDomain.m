function y = setTimeDomain(A,dt,t_o)
    A = A(:);
    n = numel(A);
    X = (0:n-1)*dt;
    X = X(:);
    y = [X A];
end