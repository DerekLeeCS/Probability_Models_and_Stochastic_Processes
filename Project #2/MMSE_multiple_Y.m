function est = MMSE_multiple_Y( X, mu_x, mu_y, a )

    a_o = mu_y * ( 1 - sum(a) );
    est = mu_y + ( sum(a.*X, 1) - mu_x );
    est = est + a_o;

end