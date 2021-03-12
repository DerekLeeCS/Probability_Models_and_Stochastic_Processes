function est = MMSE_two_Y( X_1, X_2, mu_y, var_y, var_r )

    est = ( 1/(2*var_y + var_r) ) * ( var_r*mu_y + var_y*X_1 + var_y*X_2 );

end