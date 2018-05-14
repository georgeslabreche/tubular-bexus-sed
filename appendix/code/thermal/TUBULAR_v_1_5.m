%Erik test earlier version
clear all

%Trial v1.2 ,Erik
%Variables:
Area_outside=2*0.5*0.4 + 2*0.5*0.5 + 2*0.5*0.4;
Area_inside=2*(0.5-0.04)*(0.4-0.04) + 2*(0.5-0.06)*(0.5-0.06) + 2*(0.5-0.04)*(0.4-0.04);
alpha_al = 0.3;                         %Absorbity of aluminium
S = 1362*cosd(15);                      %Solar constant
A_sun = (0.5*0.4+0.4*0.49)*cosd(45);    %Area affectd by the sun
Albedo = 0.15;                          %The albedo coefficient of earth
A_albedo = Area_outside/2;              %Area affected by the alebedo reflection
e_earth = 0.95;                         %Emissivity of earth
IR = 220;                               %Earth IR 
A_IR = Area_outside/2;                  %Area affected by the IR
P = 11.499;                             %Worst Disapated power
P2 = 8.993;                             %Average Disapated power
h = 27.811*0.3392;                      %Convection heat transfere constant
                                        %h=18 ground h=27.811 ascent h=30.33 descent
A_convect = Area_outside;               %Area affected by convection
K = 1;                                  %Factor which decrease convection at high altitude
%TO = ;                                 %Temperature wall outside
%TI = ;                                 %Temperature wall inside
Ta = 223;                               %Ambient temperature outside
sigma = 5.67051*10^-8;                  %Stefan-Boltzmann constant
A_tot = Area_outside;                   %Whole outer area
e_Al = 0.09;                            %Emissivity of aluminium

%Scaling factors IR flux Tground=10C 
Qir=e_earth*sigma*273^4;
tau=1.716-0.5*(exp(-0.65*(2.8/101.33))+exp(-0.95*(2.8/101.33)));
Qir_25k=tau*Qir;

%Equations that are used:
%{
Q_sun_Albedo = alpha_al*S*(A_sun+Albedo*A_albedo); 
Q_conduction = P; %Assumed steady heat flow through wall
Q_IR = e_earth*A_IR*IR;
Q_radiation = sigma*e_AL*A_tot*(TO^4 - Ta^4);
Q_convection = (h*A_convect*(TO-Ta))/K;
%}

%%%%
%For the Worst dissipated power
%%%%
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
Lal = 0.002;    %thicknes aluminium
Lps = 0.02;     %thicknes polystyrene foam
Lpe = 0.00;     %thicknes polyethylene foam

kal = 205;      %thermal conductivity aluminium
kps = 0.03;     %thermal conductivity polystyrene foam
kpe = 0.47;     %thermal conductivity polyethylene foam

TI = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + TO;
TI_no_sun = P*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + T_no_sun;

%%%%
%For the Average dissipated power
%%%%
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

TI2 = P2*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + TO2;
TI_no_sun2 = P2*((Lal/(kal*Area_inside))+(Lps/(kps*Area_inside))+(Lpe/(kpe*Area_inside))) + T_no_sun2;

%Results
TO=TO-273;
TI=TI-273;
Ta=Ta-273;
T_no_sun=T_no_sun-273;
TI_no_sun=TI_no_sun-273;

TO2=TO2-273;
TI2=TI2-273;
T_no_sun2=T_no_sun2-273;
TI_no_sun2=TI_no_sun2-273;
%only use if it is Launch pad, Early ascent, shutdown descent, landed
T_wall_average2=(T_no_sun2+TO2)/2;
T_in_average2=(TI_no_sun2+TI2)/2;
T_wall_average=(T_no_sun+TO)/2;
T_in_average=(TI_no_sun+TI)/2;

Results = [Ta T_wall_average T_in_average ; Ta T_wall_average2 T_in_average2] %TO TI T_no_sun TI_no_sun

%%%%
%The part to run if a test run with BEXUS 25 data wants to be used.
%%%%
%Testing bexus 25 flight data, Erik 
Area_inside=2*(0.5-0.04)*(0.4-0.04) + 2*(0.5-0.06)*(0.5-0.06) + 2*(0.5-0.04)*(0.4-0.04);

% test CAC
%{
Area_outside=4*0.5*0.25+2*0.5*0.5;
Area_inside=4*(0.5-0.1)*(0.25-0.1)+2*(0.5-0.04)*(0.5-0.1);
A_convect = Area_outside;
A_sun = (0.5*0.5+0.5*0.25)*cosd(45);
A_IR = Area_outside/2;
A_albedo=A_IR;
%}
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
        h=18*1;
        P=0.075+10;
    elseif Alltitude2(i) > 400 && Alltitude2(i) < 5000
        h=27.811*1;
        P=0.075+10;
    elseif Alltitude2(i) > 5000 && Alltitude2(i) < 10000
        h=27.811*0.7962;
        P=0.075+10;
    elseif Alltitude2(i) > 10000 && Alltitude2(i) < 15000
        h=27.811*0.5134;
        P=0.075+10;
    elseif Alltitude2(i) > 15000 && Alltitude2(i) < 20000
        h=27.811*0.3392;
        P=7.5+10+5;
    elseif Alltitude2(i) > 20000 && Alltitude2(i) < 23500
        h=27.811*0.2292;
        P=7.5+10+5;
    elseif Alltitude2(i) > 23500
        h=18*0.1592;
        P=0.075;
    end

    
%Solving TO
syms x positive
outside_temperature = P + e_earth*IR*A_IR + alpha_al*S*(A_sun+Albedo*A_albedo) == e_Al*sigma*A_tot*((x^4)-(T12(i)^4)) + (h*A_convect*(x-T12(i)))/K;
solx = solve(outside_temperature, x);
TO(i) = vpa(solx);

%Solving TI
%Assume TI is a uniform temperature inside
Lal = 0.002; %thicknes aluminium
Lps = 0.02; %thicknes polystyrene foam
Lpe = 0.00; %thicknes polyethylene foam

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
%{
figure(1)
plot(TI,Alltitude2,'b',T12,Alltitude2,'k',TI2,Alltitude2,'g')
xlabel('Temperature (Kelvin)');
ylabel('Altitude (m)')
legend('Sun all the way','Bexus 25 flight data','No sun all the way')
figure(2)
plot(TI,Alltitude2,'b',T12,Alltitude2,'k',TI2,Alltitude2,'g')
xlabel('Temperature (Celcius)');
ylabel('Altitude (m)')
legend('Sun all the way','Bexus 25 flight data','No sun all the way')
%}
figure(3)
plot(Tmid,Alltitude2,'b',T12,Alltitude2,'k')
xlabel('Temperature (Celcius)');
ylabel('Altitude (m)')
legend('TUBULAR test flight','Bexus 25 flight data')
%}