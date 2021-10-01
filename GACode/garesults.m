function garesults(gaDat)
% Optional user task executed when the algorithm ends

% For instance, final result
% disp('------------------------------------------------')
% disp('######   RESULT   #########')
% disp(['   Objective function for xmin: ' num2str(gaDat.fxmin)])
% disp(['   xmin: ' mat2str(gaDat.xmin)])
% disp('------------------------------------------------')


fprintf(gaDat.fileID,'------------------------------\n');
fprintf(gaDat.fileID,'######   RESULT   #########\n');
fprintf(gaDat.fileID,'%s %d\n', '   Objective function for xmin: ', gaDat.fxmin);
fprintf(gaDat.fileID,'%s %f %f %f \n', 'xmin:', gaDat.xmin(1), ...
        gaDat.xmin(2), gaDat.xmin(3) );
fprintf(gaDat.fileID,'------------------------------\n');