function est = MMSE_multiple_Y( X, mu_x, mu_y, a )

    est = mu_y + ( sum(a.*X, 1) - mu_x );

end