function y = calcPoisson( x, lambda )
    y = lambda.^x .* exp( -lambda ) ./ factorial(x);
end
