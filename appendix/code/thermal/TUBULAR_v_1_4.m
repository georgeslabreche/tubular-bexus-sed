%Erik test earlier version
clear all
close all
%{
%EXIST version
%{

%% Variables and equations
%Variables
Area_without_bar = 4*(0.5-0.04)*(0.4-0.04) + 2*(0.4-0.04)*(0.4-0.04);
Area_tot = 4*0.5*0.4 + 2*0.4*0.4;
S = 1362; %Solar constant
alpha = 0.3; %aluminium  %absorbation
albedo = 0.37; %fraction of sunlight reflected by the Earth
e = 0.09; %aluminium %emissivity 
IR = 220; %(W/m^2) %Infrared flux of Earth
sigma = 5.67051*10^-8; %Stefan-Boltzmann constant
K = 6.7; %factor which decreases the amount of convection at high altutudes
h = 18; %(W/K*m^2) %convective heat transfere coefficient 

%Power equations
%T1 is unknow, T2 you should know (e.x. ambient temp)
%P_Sun_radiation = alpha*S*Area*(1+Albedo);
%P_Earth_IR = e*Area*IR;
%P_Conduction = (k*Area*(T1-T2))/x;
%P_Convection = (h*Area*(T1-T2))/K;
%P_Radiation = e*sigma*Area(T1^4 - T2^4);

P=2*3.668; %only heater generate this
Area_outside = Area_tot;
Area_inside = Area_without_bar;
i=1;

for T1=linspace(193,283,200)
%% Coldest case (No heat from the sun and the temperature outside is T=193K=-80degrees)
%Solving the inner temperature for the coldest case with the same formula as EXIST 
%T1 = 193; %(K) %Ambient temperature outside 
syms x positive
outside_temperature = P + e*IR*Area_outside/2 == e*sigma*Area_outside*((x^4)-(T1^4)) + (h*Area_outside*(x-T1))/K;
solx = solve(outside_temperature, x);
T_out=vpa(solx);

Lal = 0.02; %thickness aluminium
Lps = 0.1; %thickness polystyrene foam
Lpe = 0.1; %thickness polyethylene foam

kal = 205; %thermal conductivity aluminium
kps = 0.03; %thermal conductivity polystyrene foam
kpe = 0.47; %%thermal conductivity polyethylene foam

%T_in represents
T_in_cold_case(i) = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + T_out -273;

%% Hotcase (Sun is taken into account and Temperature outside is T=223K=-50degrees)
%Solving the inner temperature for the hot case with the same formula as EXIST
%T1 = 223; %(K) %Ambient temperature outside 
syms x positive
outside_temperature = P + e*IR*Area_outside/2 == e*sigma*Area_outside*((x^4)-(T1^4)) + (h*Area_outside*(x-T1))/K - cosd(45)*(1+albedo)*alpha*S*Area_outside/2;
solx = solve(outside_temperature, x);
T_out=vpa(solx);

Lal = 0.02; %thicknes aluminium
Lps = 0.1; %thicknes polystyrene foam
Lpe = 0.1; %thicknes polyethylene foam

kal = 205; %thermal conductivity aluminium
kps = 0.03; %thermal conductivity polystyrene foam
kpe = 0.47; %%thermal conductivity polyethylene foam

%T_in represents
T_in_hot_case(i) = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + T_out -273;

i=i+1;
end
T1=linspace(-80,10,200);
plot(T1,T_in_cold_case,'b-',T1,T_in_hot_case,'r-')
xlabel('Temperature in Celcius')
ylabel('Cold/Hot Case in Celcius')
legend('Cold case','Hot Case')
%}


%New SMED very high Temperature values
%{
S = 1366; %Solar constant
Ap = 2; %Projected area of the plate towards the sun
Ar = 6; %Radiating surface are of the plate
e = 0.09; %Emissivity of the surface
alpha = 0.3; %Absorptivity of the surface
sigma = 5.67051*10^-8; %Stefan-Boltzmann constant
Area_inside = 4*(0.5-0.04)*(0.4-0.04) + 2*(0.4-0.04)*(0.4-0.04);
Area_outside = 4*0.5*0.4 + 2*0.4*0.4;

%Radiant Energy Heat Balance in Space
T=((S*(alpha/e)*(Ap/Ar)*cosd(45))/sigma)^(1/4);

%Not sure which beta angle to use in table 22-11 SMED and the alltitude
%used is 500km (it is very far off) doing for Nadir and Sun.

%For both cases
Q_internal = 2*3.668; %only heater generate this

%Cold case
S = 1317; %Solar constant
Earth_IR_45 = 186.8; %Nadir
Earth_IR_75 = 186.7; %Nadir
Q_env_45 = alpha*S*(cosd(45)*(0.4*0.5+0.4*0.4) + 0.26*Area_outside/2) + e*Earth_IR_45*Area_outside/2;
Q_env_75 = alpha*S*(cosd(75)*(0.4*0.5+0.4*0.4) + 0.34*Area_outside/2) + e*Earth_IR_75*Area_outside/2;
T_cold_45 = ((Q_env_45 + Q_internal)/(sigma*e*Area_outside))^(1/4) -273
T_cold_75 = ((Q_env_75 + Q_internal)/(sigma*e*Area_outside))^(1/4) -273

%Hot case
S = 1419; %Solar constant
Earth_IR_45 = 224.7; %Nadir
Earth_IR_75 = 224.6; %Nadir
Q_env_45 = alpha*S*(cosd(45)*(0.4*0.5+0.4*0.4) + 0.36*Area_outside/2) + e*Earth_IR_45*Area_outside/2;
Q_env_75 = alpha*S*(cosd(75)*(0.4*0.5+0.4*0.4) + 0.44*Area_outside/2) + e*Earth_IR_75*Area_outside/2;
T_hot_45 = ((Q_env_45 + Q_internal)/(sigma*e*Area_outside))^(1/4) -273
T_hot_75 = ((Q_env_75 + Q_internal)/(sigma*e*Area_outside))^(1/4) -273
%}
%}

%Trial v1.2 ,Erik

%Variables:
Area_outside=4*0.5*0.4 + 2*0.4*0.4;
Area_inside=4*(0.5-0.04)*(0.4-0.04) + 2*(0.4-0.04)*(0.4-0.04);
alpha_al = 0.3; %Absorbity of aluminium
S = 1362*cosd(15); %Solar constant
A_sun = (0.5*0.4+0.4*0.4)*cosd(45); %Area affectd by the sun
Albedo = 0.15; %The albedo coefficient of earth
A_albedo = Area_outside/2; %Area affected by the alebedo reflection
e_earth = 0.95; %emissivity of earth
IR = 220; %Earth IR 
A_IR = Area_outside/2; %Area affected by the IR
P = 0; %Worst Disapated power
P2 = 0; %Average Disapated power
h = 18; %Convection heat transfere constant
A_convect = Area_outside; %Area affected by convection
K = 1;%6.7; %Factor which decrease convection at high altitude
%TO = ; %Temperature wall outside
%TI = ; %Temperature wall inside
Ta = 263; %Ambient temperature outside
sigma = 5.67051*10^-8; %Stefan-Boltzmann constant
A_tot = Area_outside; %Whole outer area
e_Al = 0.09; %Emissivity of aluminium

%Scaling factors IR flux Tground=10C 
Qir=e_earth*sigma*273^4;
tau=1.716-0.5*(exp(-0.65*(2.8/101.33))+exp(-0.95*(2.8/101.33)));
Qir_25k=tau*Qir

%Equations:
%{
Q_sun_Albedo = alpha_al*S*(A_sun+Albedo*A_albedo); 
Q_conduction = P; %Assumed steady heat flow through wall
Q_IR = e_earth*A_IR*IR;
Q_radiation = sigma*e_AL*A_tot*(TO^4 - Ta^4);
Q_convection = (h*A_convect*(TO-Ta))/K;
%}

%Sides with no sun
syms x positive
outside_temperature = P + e_earth*IR*A_IR == e_Al*sigma*A_tot*((x^4)-(Ta^4)) + (h*A_convect*(x-Ta))/K;
solx = solve(outside_temperature, x);
T_no_sun = vpa(solx);

%Solving TO
syms x positive
outside_temperature = P + e_earth*IR*A_IR + alpha_al*S*(A_sun+Albedo*A_albedo) == e_Al*sigma*A_tot*((x^4)-(Ta^4)) + (h*A_convect*(x-Ta))/K;
solx = solve(outside_temperature, x);
TO = vpa(solx);

%Solving TI
%Assume TI is a uniform temperature inside
Lal = 0.002; %thicknes aluminium
Lps = 0.01; %thicknes polystyrene foam
Lpe = 0.01; %thicknes polyethylene foam

kal = 205; %thermal conductivity aluminium
kps = 0.03; %thermal conductivity polystyrene foam
kpe = 0.47; %%thermal conductivity polyethylene foam

TI = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + TO;
TI_no_sun = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + T_no_sun;

%Sides with no sun
syms x positive
outside_temperature = P2 + e_earth*IR*A_IR == e_Al*sigma*A_tot*((x^4)-(Ta^4)) + (h*A_convect*(x-Ta))/K;
solx = solve(outside_temperature, x);
T_no_sun2 = vpa(solx);

%Solving TO
syms x positive
outside_temperature = P2 + e_earth*IR*A_IR + alpha_al*S*(A_sun+Albedo*A_albedo) == e_Al*sigma*A_tot*((x^4)-(Ta^4)) + (h*A_convect*(x-Ta))/K;
solx = solve(outside_temperature, x);
TO2 = vpa(solx);

%Solving TI
%Assume TI is a uniform temperature inside
Lal = 0.002; %thicknes aluminium
Lps = 0.01; %thicknes polystyrene foam
Lpe = 0.01; %thicknes polyethylene foam

kal = 205; %thermal conductivity aluminium
kps = 0.03; %thermal conductivity polystyrene foam
kpe = 0.47; %%thermal conductivity polyethylene foam

TI2 = P2*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + TO2;
TI_no_sun2 = P2*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + T_no_sun2;

%Results
TO=TO-273;
TI=TI-273;
Ta=Ta-273;
T_no_sun=T_no_sun-273;
TI_no_sun=TI_no_sun-273;
T_wall_average=(T_no_sun+TO)/2;
T_in_average=(TI_no_sun+TI)/2;
TO2=TO2-273;
TI2=TI2-273;
T_no_sun2=T_no_sun2-273;
TI_no_sun2=TI_no_sun2-273;
T_wall_average2=(T_no_sun2+TO2)/2;
T_in_average2=(TI_no_sun2+TI2)/2;

Results = [Ta T_wall_average T_in_average ; Ta T_wall_average2 T_in_average2] %TO TI T_no_sun TI_no_sun

%Testing bexus 25 flight data, Erik 

Allti='Alltitude.txt';
Alltitude=csvread(Allti);
for i=2:1:length(Alltitude)
    if Alltitude(i) < 20
        Alltitude(i)=Alltitude(i-1);
    elseif Alltitude(i) > 30000
        Alltitude(i)=Alltitude(i-1);
    end
end
Alltitude(41948)=Alltitude(41947);
Alltitude(41949)=Alltitude(41947);
Alltitude(41950)=Alltitude(41947);

M='test.txt';
T1=csvread(M);

T1(41948)=T1(41947);
T1(41949)=T1(41947);
T1(41950)=T1(41947);

j=length(T1)/25
ty=1;
for r=25:25:length(T1)
    T12(ty)=T1(r);
    Alltitude2(ty)=Alltitude(r);
    ty=ty+1;
end

for i=1:1:length(T12)
    h=18;
    if Alltitude2(i) < 400
        h=h*1;
        P=5.083;
    elseif Alltitude2(i) > 400 && Alltitude2(i) < 5000
        h=h*1;
        P=8.993;
    elseif Alltitude2(i) > 5000 && Alltitude2(i) < 10000
        h=h*0.7962;
        P=8.993;
    elseif Alltitude2(i) > 10000 && Alltitude2(i) < 15000
        h=h*0.5134;
        P=13.397;
    elseif Alltitude2(i) > 15000 && Alltitude2(i) < 20000
        h=h*0.3392;
        P=13.397;
    elseif Alltitude2(i) > 20000 && Alltitude2(i) < 23500
        h=h*0.2292;
        P=13.397;
    elseif Alltitude2(i) > 23500
        h=h*0.1592;
        P=8.993;
    end

    
%Solving TO
syms x positive
outside_temperature = P + e_earth*IR*A_IR + alpha_al*S*(A_sun+Albedo*A_albedo) == e_Al*sigma*A_tot*((x^4)-(T12(i)^4)) + (h*A_convect*(x-T12(i)))/K;
solx = solve(outside_temperature, x);
TO(i) = vpa(solx);

%Solving TI
%Assume TI is a uniform temperature inside
Lal = 0.002; %thickness of aluminium
Lps = 0.01; %thickness of polystyrene foam
Lpe = 0.01; %thickness of polyethylene foam

kal = 205; %thermal conductivity aluminium
kps = 0.03; %thermal conductivity polystyrene foam
kpe = 0.47; %%thermal conductivity polyethylene foam

TI(i) = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + TO(i);

syms x positive
outside_temperature = P + e_earth*IR*A_IR == e_Al*sigma*A_tot*((x^4)-(T12(i)^4)) + (h*A_convect*(x-T12(i)))/K;
sol = solve(outside_temperature, x);
TO2(i) = vpa(sol);

TI2(i) = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + TO2(i);

TI(i)=TI(i)-273;
T12(i)=T12(i)-273;
TI2(i)=TI2(i)-273;
if Alltitude2(i) < 10000
    Tmid(i)=(TI(i)+TI2(i))/2;
else
    Tmid(i)=TI2(i);
end
i
end

figure(1)
plot(TI,Alltitude2,'b',T12,Alltitude2,'k',TI2,Alltitude2,'g')
xlabel('Temperature (Kelvin)');
ylabel('Altitude (m)')
legend('Sun all the way','Bexus 25 flight data','No sun all the way')
figure(2)
plot(TI,Alltitude2,'b',T12,Alltitude2,'k',TI2,Alltitude2,'g')
xlabel('Temperature (Celsius)');
ylabel('Altitude (m)')
legend('Sun all the way','Bexus 25 flight data','No sun all the way')
figure(3)
plot(Tmid,Alltitude2,'b',T12,Alltitude2,'k')
xlabel('Temperature (Celcius)');
ylabel('Altitude (m)')
legend('TUBULAR test flight','Bexus 25 flight data')
%}