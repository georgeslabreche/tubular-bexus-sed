%%-------------------------------------------------------------------------
%   TUBULAR COG (Center Of Gravity)
%%-------------------------------------------------------------------------
%   Date: May 2018               
%%-------------------------------------------------------------------------

clear all 
close all
clc

%% Data
m_CAC_valves = 850; %[g]
m_cub = 10; %[g]
m_aircoil = 5049; %[g]
m_profile = 4; %[g/cm]
m_Tunion = 71; %[g]
d_styro = 0.028; %[g/cm3]
d_al = 2.67; %[g/cm3]
m_brain1 = 687; %[g]
m_brain2 = 1522; %[g]
m_brain3 = 285; %[g]

%% CAC
% X-axis
m1_CAC = 2*m_cub+m_profile*19;
m2_CAC = m1_CAC;
m3_CAC = m1_CAC;
m4_CAC = m1_CAC;
m5_CAC = m_profile*46;
m6_CAC = m5_CAC;
m7_CAC = m5_CAC;
m8_CAC = m5_CAC;
m9_CAC = m_aircoil;
m10_CAC = (22*pi*25^2-15*pi*20^2)*d_styro;
m11_CAC = m_CAC_valves;
mT_CAC = m1_CAC+m2_CAC+m3_CAC+m4_CAC+m5_CAC+m6_CAC+m7_CAC+m8_CAC+m9_CAC+m10_CAC+m11_CAC;

X1_CAC = 1;
X2_CAC = 49;
X3_CAC = 1;
X4_CAC = 49;
X5_CAC = 25;
X6_CAC = 1;
X7_CAC = 49;
X8_CAC = 25;
X9_CAC = 25;
X10_CAC = 25;
X11_CAC = 11.5;

XG_CAC = (m1_CAC*X1_CAC+m2_CAC*X2_CAC+m3_CAC*X3_CAC+m4_CAC*X4_CAC+m5_CAC*X5_CAC+m6_CAC*X6_CAC+m7_CAC*X7_CAC+m8_CAC*X8_CAC+m9_CAC*X9_CAC+m10_CAC*X10_CAC+m11_CAC*X11_CAC)/mT_CAC;

% Y-axis
m1_CAC = 2*m_cub+m_profile*46;
m2_CAC = m1_CAC;
m3_CAC = m1_CAC;
m4_CAC = m1_CAC;
m5_CAC = m_profile*19;
m6_CAC = m5_CAC;
m7_CAC = m5_CAC;
m8_CAC = m5_CAC;
m9_CAC = m_aircoil;
m10_CAC = (22*pi*25^2-15*pi*20^2)*d_styro;
m11_CAC = m_CAC_valves;
mT_CAC = m1_CAC+m2_CAC+m3_CAC+m4_CAC+m5_CAC+m6_CAC+m7_CAC+m8_CAC+m9_CAC+m10_CAC+m11_CAC;

Y1_CAC = 22;
Y2_CAC = 1;
Y3_CAC = 22;
Y4_CAC = 1;
Y5_CAC = 11.5;
Y6_CAC = 22;
Y7_CAC = 1;
Y8_CAC = 11.5;
Y9_CAC = 9.5;
Y10_CAC = 20;
Y11_CAC = 3;

YG_CAC = (m1_CAC*Y1_CAC+m2_CAC*Y2_CAC+m3_CAC*Y3_CAC+m4_CAC*Y4_CAC+m5_CAC*Y5_CAC+m6_CAC*Y6_CAC+m7_CAC*Y7_CAC+m8_CAC*Y8_CAC+m9_CAC*Y9_CAC+m10_CAC*Y10_CAC+m11_CAC*Y11_CAC)/mT_CAC;

% % Z-axis
m1_CAC = 2*m_cub+m_profile*19;
m2_CAC = m1_CAC;
m3_CAC = m1_CAC;
m4_CAC = m1_CAC;
m5_CAC = m_profile*46;
m6_CAC = m5_CAC;
m7_CAC = m5_CAC;
m8_CAC = m5_CAC;
m9_CAC = m_aircoil;
m10_CAC = (22*pi*25^2-15*pi*20^2)*d_styro;
m11_CAC = m_CAC_valves;
mT_CAC = m1_CAC+m2_CAC+m3_CAC+m4_CAC+m5_CAC+m6_CAC+m7_CAC+m8_CAC+m9_CAC+m10_CAC+m11_CAC;

Z1_CAC = 49;
Z2_CAC = 49;
Z3_CAC = 1;
Z4_CAC = 1;
Z5_CAC = 49;
Z6_CAC = 25;
Z7_CAC = 25;
Z8_CAC = 1;
Z9_CAC = 25;
Z10_CAC = 25;
Z11_CAC = 3;

ZG_CAC = (m1_CAC*Z1_CAC+m2_CAC*Z2_CAC+m3_CAC*Z3_CAC+m4_CAC*Z4_CAC+m5_CAC*Z5_CAC+m6_CAC*Z6_CAC+m7_CAC*Z7_CAC+m8_CAC*Z8_CAC+m9_CAC*Z9_CAC+m10_CAC*Z10_CAC+m11_CAC*Z11_CAC)/mT_CAC;


%% AAC
% X-axis
m1_AAC = 2*m_cub+m_profile*46;
m2_AAC = m1_AAC;
m3_AAC = m1_AAC;
m4_AAC = m1_AAC;
m5_AAC = m_profile*46 +3*46*46*d_styro;
m6_AAC = m_profile*36 +3*36*46*d_styro;
m7_AAC = m6_AAC;
m8_AAC = m5_AAC;
m9_AAC = m_brain3;
m10_AAC = m_brain2;
m11_AAC = m_brain1;
m12_AAC = m_Tunion;
m13_AAC = m12_AAC;
m14_AAC = m12_AAC;
m15_AAC = m12_AAC;
m16_AAC = m12_AAC;
m17_AAC = m12_AAC;

mT_AAC = m1_AAC+m2_AAC+m3_AAC+m4_AAC+m5_AAC+m6_AAC+m7_AAC+m8_AAC+m9_AAC+m10_AAC+m11_AAC+m12_AAC+m13_AAC+m14_AAC+m15_AAC+m16_AAC+m17_AAC;

X1_AAC = 1;
X2_AAC = 49;
X3_AAC = 1;
X4_AAC = 49;
X5_AAC = 25;
X6_AAC = 1;
X7_AAC = 49;
X8_AAC = 25;
X9_AAC = 33.5;
X10_AAC = 33.5;
X11_AAC = 33.5;
X12_AAC = 41.67;
X13_AAC = 12.5;
X14_AAC = 33.33;
X15_AAC = 25;
X16_AAC = 16.67;
X17_AAC = 8.33;

XG_AAC = (m1_AAC*X1_AAC+m2_AAC*X2_AAC+m3_AAC*X3_AAC+m4_AAC*X4_AAC+m5_AAC*X5_AAC+m6_AAC*X6_AAC+m7_AAC*X7_AAC+m8_AAC*X8_AAC+m9_AAC*X9_AAC+m10_AAC*X10_AAC+m11_AAC*X11_AAC+m12_AAC*X12_AAC+m13_AAC*X13_AAC+m14_AAC*X14_AAC+m15_AAC*X15_AAC+m16_AAC*X16_AAC+m17_AAC*X17_AAC)/mT_AAC;

% Y-axis
m1_AAC = 2*m_cub+m_profile*46;
m2_AAC = m1_AAC;
m3_AAC = m1_AAC;
m4_AAC = m1_AAC;
m5_AAC = m_profile*46 +3*46*46*d_styro;
m6_AAC = m_profile*36 +3*36*46*d_styro;
m7_AAC = m6_AAC;
m8_AAC = m5_AAC;
m9_AAC = m_brain3;
m10_AAC = m_brain2;
m11_AAC = m_brain1;
m12_AAC = 5*m_Tunion;
m13_AAC = m_Tunion;

mT_AAC = m1_AAC+m2_AAC+m3_AAC+m4_AAC+m5_AAC+m6_AAC+m7_AAC+m8_AAC+m9_AAC+m10_AAC+m11_AAC+m12_AAC+m13_AAC;

Y1_AAC = 1;
Y2_AAC = 49;
Y3_AAC = 1;
Y4_AAC = 49;
Y5_AAC = 25;
Y6_AAC = 1;
Y7_AAC = 49;
Y8_AAC = 25;
Y9_AAC = 7.5;
Y10_AAC = 7.5;
Y11_AAC = 7.5;
Y12_AAC = 31;
Y13_AAC = 17;

YG_AAC = (m1_AAC*Y1_AAC+m2_AAC*Y2_AAC+m3_AAC*Y3_AAC+m4_AAC*Y4_AAC+m5_AAC*Y5_AAC+m6_AAC*Y6_AAC+m7_AAC*Y7_AAC+m8_AAC*Y8_AAC+m9_AAC*Y9_AAC+m10_AAC*Y10_AAC+m11_AAC*Y11_AAC+m12_AAC*Y12_AAC+m13_AAC*Y13_AAC)/mT_AAC;

% Z-axis
m1_AAC = 2*m_cub+m_profile*46;
m2_AAC = m1_AAC;
m3_AAC = m1_AAC;
m4_AAC = m1_AAC;
m5_AAC = m_profile*46 +3*46*46*d_styro;
m6_AAC = m_profile*36 +3*36*46*d_styro;
m7_AAC = m6_AAC;
m8_AAC = m5_AAC;
m9_AAC = m_brain3;
m10_AAC = m_brain2;
m11_AAC = m_brain1;
m12_AAC = 5*m_Tunion;
m13_AAC = m_Tunion;

mT_AAC = m1_AAC+m2_AAC+m3_AAC+m4_AAC+m5_AAC+m6_AAC+m7_AAC+m8_AAC+m9_AAC+m10_AAC+m11_AAC+m12_AAC+m13_AAC;

Z1_AAC = 39;
Z2_AAC = 39;
Z3_AAC = 1;
Z4_AAC = 1;
Z5_AAC = 39;
Z6_AAC = 20;
Z7_AAC = 20;
Z8_AAC = 1;
Z9_AAC = 24.5;
Z10_AAC = 15.5;
Z11_AAC = 6.5;
Z12_AAC = 10;
Z13_AAC = Z12_AAC;

ZG_AAC = (m1_AAC*Z1_AAC+m2_AAC*Z2_AAC+m3_AAC*Z3_AAC+m4_AAC*Z4_AAC+m5_AAC*Z5_AAC+m6_AAC*Z6_AAC+m7_AAC*Z7_AAC+m8_AAC*Z8_AAC+m9_AAC*Z9_AAC+m10_AAC*Z10_AAC+m11_AAC*Z11_AAC+m12_AAC*Z12_AAC+m13_AAC*Z13_AAC)/mT_AAC;

%% TOTAL
m_AAC= 12370;
m_CAC= 12080;
mT_TOTAL= m_AAC+m_CAC;

% X-axis
XG_TOTAL = (m_AAC*XG_AAC+m_CAC*XG_CAC)/mT_TOTAL;
% Y-axis
YG_TOTAL = (m_AAC*(YG_AAC+23)+m_CAC*YG_CAC)/mT_TOTAL;
% Z-axis
ZG_TOTAL = (m_AAC*ZG_AAC+m_CAC*ZG_CAC)/mT_TOTAL;

