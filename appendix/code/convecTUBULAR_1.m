%% Natural Convection

Gr_g = 9.8;
Gr_beta = 0.0042;
Gr_Ts = 277;
Gr_Tinf = 223;
Gr_delta = 0.40;
ni = 3.493613e-04;
Pr_alpha = 616e-06;
k = 205;

Gr = (Gr_g * Gr_beta * (Gr_Ts-Gr_Tinf) * Gr_delta^3)/(ni^2);
Pr = ni/Pr_alpha;

Ra = (Gr * Pr);

Nu = (0.825 + ((0.387*Ra^(1/6))/(1 + (0.492/Pr)^(9/16))^(8/27)))^2;


h_nat = (Nu * k)/Gr_delta;

%% Forced Convection

n = 0.25;
rho_sea = 1.225;
rho_alt = 0.0400; %At 25 km
k_alt = 240; % These are for aluminum, but they are supposed to be for air, I think.
k_sea = 236; % Fortunately, the k for air changes pretty slowly with temperature, so it doesn't matter.
beta_alt = 0.005;
beta_sea = 0.004;
mu_sea = 1.789e-05;
mu_alt = 1.458e-05;
cp_alt = 1.0027;
cp_sea = 1.0040;
T_alt = 223; % 25 km
T_5 = 263;
T_10 = 223;
T_15_cold = 193;
T_15_hot = 213;
T_20 = 213;
T_sea = 278;

%h_ratio between Esrange and sea level is 0.9435
%The following are Esrange ground level parameters
% rho_alt = 1.188; %Ground level at Esrange
% k_alt = 236;
% beta_alt = 0.004;
% mu_alt = 1.779e-05;
% cp_alt = 1.004;
% T_alt = 283;

%F = ((k_alt/k_sea)^(1-n)) * ((beta_alt/beta_sea)*(mu_sea/mu_alt)*(cp_alt/cp_sea)*(((rho_alt*T_alt)/(rho_sea*T_sea))^2))^n

F = ((k_alt/k_sea)^(1-n)) * ((1)*(1)*(1)*(((T_alt)/(T_sea))^2))^n

P_sea = 101300;
deltaT_sea = 10;
P_alt = 2549; %at 25 km
P_5 = 54050;
P_10 = 26500;
P_15 = 12110;
P_20 = 5529;
deltaT_alt = 15; % Assumed from surface temperature at 25000 km from Erik's old matlab script.

%h_ratio = (((rho_alt * P_alt)/(rho_sea * P_sea))^(2*n)) * ((deltaT_alt/deltaT_sea)^n) * F

h_ratio = (((P_alt)/(P_sea))^(2*n)) * ((deltaT_alt/deltaT_sea)^n) * F
