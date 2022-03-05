clear;
clc;
collect_taylor=[];
min_avg_Taylor_factor=5000;
e22=0;
prompt = 'Enter your file name with extension with extension in apostrophe(''myfile.txt''):-';

%For calculation of Lankford parameter parallel to rolling direction enter the file '0.txt'.
%For calculation of Lankford parameter 15 degree to rolling direction enter the file '15.txt'.
%For calculation of Lankford parameter 30 degree to rolling direction enter the file '30.txt'.
%For calculation of Lankford parameter 45 degree to rolling direction enter the file '45.txt'.
%For calculation of Lankford parameter 60 degree to rolling direction enter the file '60.txt'.
%For calculation of Lankford parameter 75 degree to rolling direction enter the file '75.txt'.
%For calculation of Lankford parameter 90 degree to rolling direction enter the file '90.txt'.

name_of_file = input(prompt);
all_euler = dlmread(name_of_file);
for rho=0:0.01:1
    sum_of_all_Taylor_factor=0;
    strain_external=[1 0 0;0 -1*rho 0;0 0 rho-1];
    for j=1:1:size(all_euler,1)
        euler_angle = all_euler(j,:);
        phi1 = degtorad(euler_angle(1));
phi = degtorad(euler_angle(2));
phi2 = degtorad(euler_angle(3));

g11 = ((cos(phi1)*cos(phi2))-sin(phi1)*sin(phi2)*cos(phi));
g12 = (sin(phi1)*cos(phi2))+(cos(phi1)*sin(phi2)*cos(phi));
g13 = sin(phi2)*sin(phi);

g21 = (-cos(phi1)*sin(phi2) - sin(phi1)*cos(phi2)*cos(phi));
g22 = (-sin(phi1)*sin(phi2) + cos(phi1)*cos(phi2)*cos(phi));
g23 = cos(phi2)*sin(phi);

g31 = sin(phi1)*sin(phi);
g32 = (-cos(phi1)*sin(phi));
g33 = cos(phi);

g = [g11 g12 g13;g21 g22 g23;g31 g32 g33];

g_trans = g';
s_in= g*strain_external*g_trans;

bh = [1.00	-1.00	0.00	0.00	0.00	0.00
0.00	1.00	-1.00	0.00	0.00	0.00
-1.00	0.00	1.00	0.00	0.00	0.00
0.00	0.00	0.00	1.00	0.00	0.00
0.00	0.00	0.00	0.00	1.00	0.00
0.00	0.00	0.00	0.00	0.00	1.00
0.50	-1.00	0.50	0.00	0.50	0.00
0.50	-1.00	0.50	0.00	-0.50	0.00
-1.00	0.50	0.50	0.50	0.00	0.00
-1.00	0.50	0.50	-0.50	0.00	0.00
0.50	0.50	-1.00	0.00	0.00	0.50
0.50	0.50	-1.00	0.00	0.00	-0.50
0.50	0.00	-0.50	0.50	0.00	0.50
0.50	0.00	-0.50	-0.50	0.00	0.50
0.50	0.00	-0.50	0.50	0.00	-0.50
0.50	0.00	-0.50	-0.50	0.00	-0.50
0.00	-0.50	0.50	0.00	0.50	0.50
0.00	-0.50	0.50	0.00	-0.50	0.50
0.00	-0.50	0.50	0.00	0.50	-0.50
0.00	-0.50	0.50	0.00	-0.50	-0.50
-0.50	0.50	0.00	0.50	0.50	0.00
-0.50	0.50	0.00	-0.50	0.50	0.00
-0.50	0.50	0.00	0.50	-0.50	0.00
-0.50	0.50	0.00	-0.50	-0.50	0.00
0.00	0.00	0.00	0.50	0.50	-0.50
0.00	0.00	0.00	0.50	-0.50	0.50
0.00	0.00	0.00	-0.50	0.50	0.50
0.00	0.00	0.00	0.50	0.50	0.50
-1.00	1.00	0.00	0.00	0.00	0.00
0.00	-1.00	1.00	0.00	0.00	0.00
1.00	0.00	-1.00	0.00	0.00	0.00
0.00	0.00	0.00	-1.00	0.00	0.00
0.00	0.00	0.00	0.00	-1.00	0.00
0.00	0.00	0.00	0.00	0.00	-1.00
-0.50	1.00	-0.50	0.00	-0.50	0.00
-0.50	1.00	-0.50	0.00	0.50	0.00
1.00	-0.50	-0.50	-0.50	0.00	0.00
1.00	-0.50	-0.50	0.50	0.00	0.00
-0.50	-0.50	1.00	0.00	0.00	-0.50
-0.50	-0.50	1.00	0.00	0.00	0.50
-0.50	0.00	0.50	-0.50	0.00	-0.50
-0.50	0.00	0.50	0.50	0.00	-0.50
-0.50	0.00	0.50	-0.50	0.00	0.50
-0.50	0.00	0.50	0.50	0.00	0.50
0.00	0.50	-0.50	0.00	-0.50	-0.50
0.00	0.50	-0.50	0.00	0.50	-0.50
0.00	0.50	-0.50	0.00	-0.50	0.50
0.00	0.50	-0.50	0.00	0.50	0.50
0.50	-0.50	0.00	-0.50	-0.50	0.00
0.50	-0.50	0.00	0.50	-0.50	0.00
0.50	-0.50	0.00	-0.50	0.50	0.00
0.50	-0.50	0.00	0.50	0.50	0.00
0.00	0.00	0.00	-0.50	-0.50	0.50
0.00	0.00	0.00	-0.50	0.50	-0.50
0.00	0.00	0.00	0.50	-0.50	-0.50
0.00	0.00	0.00	-0.50	-0.50	-0.50];
for i=1:1:56
     m(i) = sqrt(6)*( (bh(i,1)*s_in(2,2)) - ((bh(i,2)*s_in(1,1))) + ((bh(i,4)*2*s_in(2,3))) + ((bh(i,5)*2*s_in(3,1))) +((bh(i,6)*2*s_in(1,2))));
     
end
Taylor_factor = max(m);

sum_of_all_Taylor_factor=Taylor_factor+sum_of_all_Taylor_factor;

    end
    avg_Taylor_factor=sum_of_all_Taylor_factor/size(all_euler,1);
    collect_taylor = [collect_taylor;avg_Taylor_factor];

    
    if min_avg_Taylor_factor>avg_Taylor_factor
        min_avg_Taylor_factor=avg_Taylor_factor;
        e22=rho;
    end

end
e22 %Rho
min_avg_Taylor_factor


