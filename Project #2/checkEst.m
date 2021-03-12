function checkEst( experimental, theoretical )

    eps = 1e-3;
    assert( abs(experimental-theoretical) < eps, "MSE differs by more than "+eps );

end