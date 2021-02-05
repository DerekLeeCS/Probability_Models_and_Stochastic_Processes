clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #1
% Brian Doan, Derek Lee


%% Constants

NUM_TRIALS = 1e6;
NUM_ROLLS = 3;
NUM_FUN = 3;
NUM_ABILITIES = 6;
MAX_VAL = 6;


%% Question 1 Part A

% Theoretical
q1aTheoretical = (1/MAX_VAL)^NUM_ROLLS;

% Run trials
q1aTrials = genQ1A( MAX_VAL, NUM_ROLLS, NUM_TRIALS );

% Calculate ability scores
q1aAbilityScore = sum( q1aTrials );

% Get matches
q1aExperimental = calcExperimental( q1aAbilityScore, 18 );


%% Question 1 Part B

% Theoretical
q1bTheoretical = 1-( 1-q1aTheoretical )^NUM_FUN;

% Run trials
q1bTrials = genQ1B( MAX_VAL, NUM_FUN, NUM_ROLLS, NUM_TRIALS );

% Calculate ability scores
q1bAbilityScore = calcAbility( q1bTrials );

% Get matches
q1bExperimental = calcExperimental( q1bAbilityScore, 18 );


%% Question 1 Part C

% Theoretical
q1cTheoretical = q1bTheoretical^NUM_ABILITIES;

% Run trials
q1cTrials = genQ1C( MAX_VAL, NUM_ABILITIES, NUM_FUN, NUM_ROLLS, NUM_TRIALS );

% Calculate ability scores
q1cAbilityScore = squeeze( calcAbility( q1cTrials ) );

% Get matches
q1cExperimental = calcExperimentalVec( q1cAbilityScore, 18*ones(1,NUM_ABILITIES) );


%% Question 1 Part D

% Theoretical
% P( all rolls <= 9 )^NUM_FUN - P( all rolls <= 8 )^NUM_FUN
q1dTheoretical = (((81/216)^NUM_FUN - ((81-25)/216)^NUM_FUN))^NUM_ABILITIES;

% Run trials
q1dTrials = genQ1C( MAX_VAL, NUM_ABILITIES, NUM_FUN, NUM_ROLLS, NUM_TRIALS );

% Calculate ability scores
q1dAbilityScore = squeeze( calcAbility( q1dTrials ) );

% Get matches
q1dExperimental = calcExperimentalVec( q1dAbilityScore, 9*ones(1,NUM_ABILITIES) );


%% Question 2 Part A

% Theoretical
q2aTrollTheoretical = 2.5;
q2aFireTheoretical = 3;
q2aGreaterTheoretical = 0.25;

% Run trials
q2aTrollTrials = genTroll( NUM_TRIALS );
q2aFireTrials = genFire( NUM_TRIALS );

% Calculate averages
q2aTrollExperimental = mean( q2aTrollTrials );
q2aFireExperimental = mean( q2aFireTrials );

% Calculate bound
q2aGreaterExperimental = sum( q2aFireTrials > 3 ) / NUM_TRIALS;


%% Question 2 Part B

% Get PMF values
q2bFire = zeros(4,1);
q2bTroll = zeros(4,1);
for i = 1:4
    q2bFire(i) = pmfFire(i);
    q2bTroll(i) = pmfTroll(i);
end

% Plot
tiledlayout( 1,2 );
nexttile();
stem( q2bFire );
title( 'Fireball' );
xlabel( 'Damage' );
ylabel( 'Probability' );
nexttile();
stem( q2bTroll );
title( 'Troll' );
xlabel( 'HP' );
ylabel( 'Probability' );


%% Question 2 Part C

% Constants
NUM_TROLLS = 6;

% Theoretical
% 1/4 chance to kill everything
% 1/2 chance to get 3 dmg fireball
    % 1,2,3 health for 2 trolls out of 4 HP options
% 1/4 chance to get 2 dmg fireball
    % 1,2 health for 2 trolls out of 4 HP options
q2cTheoretical = (1/4) + (1/2) * (3/4)^NUM_TROLLS + (1/4) * (2/4)^NUM_TROLLS;

% Run trials
q2cFire = genFire( NUM_TRIALS );
q2cTrolls = createTrolls( NUM_TROLLS, NUM_TRIALS );

% Determine if a troll died
q2cDead = q2cFire >= q2cTrolls;

% Count number of times all trolls died
q2cAllDead = sum( sum( q2cDead, ndims(q2cDead)-1 ) == NUM_TROLLS );

% Calculate probability
q2cExperimental = q2cAllDead / NUM_TRIALS;


%% Question 2 Part D

% Constants
NUM_SURVIVING = NUM_TROLLS-1;

% Theoretical
% Case 1: Fireball = 2; Surviving troll = 3; Others <= 2
% Case 2: Fireball = 2; Surviving troll = 4; Others <= 2
% Case 3: Fireball = 3; Surviving troll = 4; Others <= 3
q2dTheoretical_case1 = (pmfFire(2) * (pmfTroll(2) + pmfTroll(1))^NUM_SURVIVING * pmfTroll(3));
q2dTheoretical_case2 = (pmfFire(2) * (pmfTroll(2) + pmfTroll(1))^NUM_SURVIVING * pmfTroll(4));
q2dTheoretical_case3 = (pmfFire(3) * (pmfTroll(3) + pmfTroll(2) + pmfTroll(1))^NUM_SURVIVING * pmfTroll(4));
q2dTheoretical_total =  q2dTheoretical_case1 + q2dTheoretical_case2 + q2dTheoretical_case3;
q2dTheoretical = 3 * (q2dTheoretical_case1/q2dTheoretical_total) + 4 * (q2dTheoretical_case2/q2dTheoretical_total) +  4 * (q2dTheoretical_case3/q2dTheoretical_total);

% Run trials
q2dFire = genFire( NUM_TRIALS );
q2dTrolls = createTrolls( NUM_TROLLS, NUM_TRIALS );

% Determine if a troll died
q2dDead = q2dFire >= q2dTrolls;

% Get trials with one surviving troll
q2dAllDead = sum( q2dDead, ndims(q2dDead)-1 ) == NUM_SURVIVING;
q2dSurvivingTroll = max( q2dTrolls, [], 1 ) .* q2dAllDead;

% Calculate probability
q2dExperimental = mean( q2dSurvivingTroll( q2dSurvivingTroll>0 ) );


%% Question 2 Part E

% Theoretical
q2eTheoretical = .5*((10/20)^1 * ((4+1)/2)) + (10/20)^1 * ((6+1)/2)*2;

% Roll damage
q2eDmgSword = unidrnd( 6, 2, NUM_TRIALS );
q2eDmgSword = sum( q2eDmgSword, ndims( q2eDmgSword )-1 );
q2eDmgHammer = unidrnd( 4, 1, NUM_TRIALS );

% Determine if attack will hit
q2eAttackSword = tryAttack( NUM_TRIALS );
q2eDmgSword = q2eDmgSword .* q2eAttackSword;

% Determine if the hammer attack will hit
q2eAttackHammer = q2eAttackSword .* tryAttack( NUM_TRIALS );
q2eDmgHammer = q2eDmgHammer .* q2eAttackHammer;

% Calculate expected damage
q2eExperimental = mean( q2eDmgSword + q2eDmgHammer );


%% Question 2 Part F

% Theoretical
q2fTheoretical = 1;

