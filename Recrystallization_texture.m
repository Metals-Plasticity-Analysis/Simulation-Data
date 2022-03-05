 %Simulate Rex texture
 
 CS = crystalSymmetry('m-3m');
     
 % Transform the deformation texture by 40o <111> relationship
 r1 = normalize(vector3d(1,1,1));
 rot1 = rotation.byAxisAngle(r1,40*degree);
 F_g_growth_variant_1=rotate(odf_rolling_texture_regionE,rot1);
 
 r2 = normalize(vector3d(1,1,-1));
 rot2 = rotation.byAxisAngle(r2,40*degree);
 F_g_growth_variant_2=rotate(odf_rolling_texture_regionE,rot2);
 
 r3 = normalize(vector3d(1,-1,1));
 rot3 = rotation.byAxisAngle(r3,40*degree);
 F_g_growth_variant_3=rotate(odf_rolling_texture_regionE,rot3);
 
 r4 = normalize(vector3d(-1,1,1));
 rot4 = rotation.byAxisAngle(r4,40*degree);
 F_g_growth_variant_4=rotate(odf_rolling_texture_regionE,rot4);
 
 odf_growth=0.25*F_g_growth_variant_1+0.25*F_g_growth_variant_2+0.25*F_g_growth_variant_3+0.25*F_g_growth_variant_4;
 
 plot(odf_growth,'phi2',[0 45 65]*degree,'contour','antipodal','linewidth',3);
 setColorRange('equal');  
 mtexColorbar ('FontSize',25,'Fontweight','bold')
 set(gcf, 'units','normalized','outerposition',[0 0 1 1]);   
 
 figure()
 
 %Define nucleation probability near Cube bands
 SS = specimenSymmetry('orthorhombic');
 cube_RD = orientation('Euler',[0,0,0]*degree,CS,SS);
 odf_cube_RD = unimodalODF(cube_RD,'halfwidth',20*degree);
 plot(odf_cube_RD,'phi2',[0 45 65]*degree,'contour','antipodal','linewidth',3);
 setColorRange('equal');  
 mtexColorbar ('FontSize',25,'Fontweight','bold')
 set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
 odf_cube= 1.0*odf_cube_RD;
 
figure()
 %Predict REX texture
[g12, g23, g31] = meshgrid(2.5:5:357.5);
g = [reshape(g12,[],1) reshape(g23,[],1) reshape(g31,[],1) ];
% g of euler angle phi1 phi and phi2 created.
I = orientation('Euler',g*degree,CS); 
d = eval( odf_cube,I);
% dlmwrite('out.txt',[e d])
f = eval(odf_growth,I);
R = d.*f;
odf_calculated = calcDensity(I,'weights',R);
plot(odf_calculated,'phi2',[0 45 65]*degree,'contour','antipodal','linewidth',3);
setColorRange([1 14]); 
mtexColorbar ('FontSize',25,'Fontweight','bold')
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
