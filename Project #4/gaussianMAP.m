function Y_hat = gaussianMAP( X, A, boundary )
    
    % Choose H_1 when above the boundary
    Y_hat = X > boundary;
    Y_hat = Y_hat * A;

end