%This script calculates the absolute value of the decompression rate based
%on measurements of the bubble number density (BND) in pyroclasts - see
%Toramaru 2006 in JVGR https://doi.org/10.1016/j.jvolgeores.2006.03.027
%script written by Amelia A. Bain
%%%% v2 utilising 980C as the T
clear all, close all

%load sample data
[num_samples,txt_samples,raw_samples]=xlsread('input_data'); %import tabulated data

%Constants
a0=3.5*10^14; % constant [units?]
a=3*a0; % constant [units?]
R=8.3; % gas constant [J/K]
X1=0.0167*1; %mole fraction of water in the melt on a single oxygen basis for 1wt% H2O
P1=20000*(10^6)*X1^2; %pressure for 1 wt% H2O
T=980+273.15; %constant temperature of 980C assumed [K]

%parameters
Cs=num_samples(:,1); % Silica content of the melt [wt%]
Cw=num_samples(:,2); % initial melt water concentration in [wt%]
rho=num_samples(:,3); %density of the melt [kg/m3] (using T=980C)
%rho=num_samples(:,5); %density of the melt [kg/m3] (using Toramaru's empirical relation for T, using Cs)
BND=num_samples(:,4).*10^9; %bubble number density [m-3]

%Storage vectors (for speed)
D=NaN(1,length(Cs));
abs_DR_1=NaN(1,length(Cs));
abs_DR_2=NaN(1,length(Cs));
%C=NaN(1,length(Cs));
%T=NaN(1,length(Cs));
Pw=NaN(1,length(Cs));
sigma=NaN(1,length(Cs));
X=NaN(1,length(Cs));
P=NaN(1,length(Cs));
m=NaN(1,length(Cs));
m1=NaN(1,length(Cs));
DZB2000_Cw_T_P=NaN(1,length(Cs));
DBZX2004_T_P_Cs=NaN(1,length(Cs));
DZB2000_1wtpc_T_P=NaN(1,length(Cs));

for i=1:length(Cs)

%Equations
%C(i)=Cw(i)*(rho(i)*(0.018/6*10^23)*100); % initial water concentration in molecular number per m3 [molecules of H2O per m3 of silicate melt]
%T(i)=1000/(0.16+0.01*Cs(i)); % Temperature [K] see Toramaru (1995) Note: 0.01*Cs in original equation whereas 0.001*Cs in 2006 paper - probable typo in Toramaru 2006, otherwise the T is too high
Pw(i)=5.6*10^6*Cw(i); % initial saturation pressure [Pa] as a function of water content
%Pw(i)=(C(i)/(4*10^23))^2; % initial saturation pressure [Pa] (Burnham, 1975), as a function of water content and melt density
sigma(i)=0.2366*exp(-0.35*(10^-6)*Pw(i) - 11*(10^3)*((1/T)-(1/1273))/R); % interfacial tension [N/m]

%Equations for the diffusivity of water in silicate melt (D) [m2/s]
X(i)=0.0167*Cw(i); %mole fraction of water in the melt on a single oxygen basis
P(i)=20000*(10^6)*X(i)^2; %pressure that is equal to the pressure at the nucleation climax (i.e. nucleation pressure Pn) but we assume P=Pn=Pw
m(i)=-20.79-(5030/T)-(1.4*(P(i)*10^(-6))/T);
m1(i)=-20.79-(5030/T)-(1.4*(P1*10^(-6))/T); %m for 1 wt% H2O
DZB2000_Cw_T_P(i)= X(i)*exp (m(i)) * (1+ exp(56+m(i)+X(i)*(-34.1+(44620/T)+((57.3*P(i)*10^(-6))/T)) - sqrt(X(i))*(0.091 + (4.77*10^6)/T^2)) ); % Diffusivity as a function of pressure, temperature and water content (Zhang and Behrens, 2000)
DBZX2004_T_P_Cs(i)= 10^( (-0.757-0.0868*Cs(i)) + ((-14785+131.7*Cs(i))/T) + ((3.079-0.049*Cs(i))*(P1*10^(-6))/T) ); % Diffusivity as a function of temperature, saturation pressure and silica content at 1 wt% H2O (Behrens et al. 2004)
DZB2000_1wtpc_T_P(i)= X1*exp(m1(i)) * (1+ exp (56+m1(i)+X1*(-34.1+(44620/T)+((57.3*P(i)*10^(-6))/T)) - sqrt(X1)*(0.091 + (4.77*10^6)/T^2) ) ); % Diffusivity as a function of pressure, temperature and water content for a water content of 1wt% H2O (Zhang and Behrens, 2000)
D(i)= DBZX2004_T_P_Cs(i) * (DZB2000_Cw_T_P(i)/DZB2000_1wtpc_T_P(i)) ; %diffusivity of water in the melt as a function of temperature, pressure, silica content and water content

%Equation for decompression rate %Note abs_DR_2 has values of sigma halved
%to account for effect of CO2
abs_DR_1(i)=a*D(i)*(sigma(i)^2)*(Pw(i)^(-1/3))*(T^(-1/2))*(BND(i)^(2/3)); %absolute value of the decompression rate (Pa/s)
abs_DR_2(i)=a*D(i)*((0.5*sigma(i))^2)*(Pw(i)^(-1/3))*(T^(-1/2))*(BND(i)^(2/3)); %absolute value of the decompression rate (Pa/s)
end