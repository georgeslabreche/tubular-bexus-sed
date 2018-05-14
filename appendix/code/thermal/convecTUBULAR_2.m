%% Reynolds Number for Forced Convection

Re_v = 6;
Re_D = 0.4;
Re_rho = 1.225;
Re_mu = 1.764e5;

Re = (Re_v * Re_D * Re_rho)/Re_mu;

if Re < 2300
    n = 0.25
else
    n = 0.333333
end


%% Forced Convection

n = 0.25;
rho_sea = 1.225;
rho_alt = 0.0400; %At 25 km
k_alt = 0.02281; 
k_sea = 0.02436; 
beta_sea = 0.00369;
mu_sea = 1.710e-05;
mu_alt = 1.610e-05;
cp_alt = 1006.0;
cp_sea = 1003.7;
T_sea_cold = 263;
T_sea_exp = 273;
T_sea_hot = 283;
T_5_cold = 228;
T_5_exp = 263;
T_5_hot = 273;
T_10_cold = 193;
T_10_exp = 223;
T_10_hot = 238;
T_15_cold = 193;
T_15_exp = 233;
T_15_hot = 253;
T_20_cold = 213;
T_20_exp = 243;
T_20_hot = 268;
T_alt_cold = 223; % 25 km
T_alt_exp = 253;
T_alt_hot = 273;

F = ((k_alt/k_sea)^(1-n)) * ((beta_alt/beta_sea)*(mu_sea/mu_alt)*(cp_alt/cp_sea)*(((T_alt_exp)/(T_sea_exp))^2))^n

P_sea = 101300;
deltaT_sea = 10;
P_alt = 2549; %at 25 km
P_5 = 54050;
P_10 = 26500;
P_15 = 12110;
P_20 = 5529;
deltaT_alt = 20; % Assumed from surface temperature at 25000 km from previous main Thermal script.

h_ratio = (((P_alt)/(P_sea))^(2*n)) * ((deltaT_alt/deltaT_sea)^n) * F
