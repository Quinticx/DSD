function gaiteracion(gaDat)
%  Optional user task executed at the end of each iteration
%

% For instance, results of the iteration
%  disp('------------------------------------------------')
%  disp(['Iteration: ' num2str(gaDat.gen)])
%  disp(['   xmin: ' mat2str(gaDat.xmin) ' -- f(xmin): ',num2str(gaDat.fxmin)])
%% --------------------------------------------------------


fprintf(gaDat.fileID,'------------------------------\n');
fprintf(gaDat.fileID,'%s %d\n', 'Iteration:', gaDat.gen);
fprintf(gaDat.fileID,'%s %f %f %f %s %f\n', 'xmin:', gaDat.xmin(1), ...
        gaDat.xmin(2), gaDat.xmin(3), '-- f(xmin):', gaDat.fxmin );
