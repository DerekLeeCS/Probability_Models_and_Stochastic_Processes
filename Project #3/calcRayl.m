function y = calcRayl( x, lambda )
    y = x./(lambda.^2) .* exp( -(x.^2)./(2*lambda.^2) );
end