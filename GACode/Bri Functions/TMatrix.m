% Create TMatrix class for easier Forward/Backward Matricies
classdef TMatrix 
    properties 
        fa
        fb
    end
    methods
        function obj=TMatrix(filename)
            % Load in T Matrix .dat file and return fa and fb. This is generalized
            % for both Ku forward/backward and Ka forward/backward
            fid = fopen(filename);
            % Because Headers are first row, skip to next row in data
            fgetl(fid);
            % Load in TMatrix file as a matrix
            % Has 6 values: Dia, Axis, Re(fa), Im(fa), Re(fb), Im(fb)
            matrix = textscan(fid, '%f%f%f%f%f%f');
            fclose(fid);
            
            % Convert cell array to normal array and transpose
            matrix = cell2mat(matrix).';
            
            % Calculate fa and fb from T matrix
            obj.fa = matrix(3, :) + j*matrix(4, :);
            obj.fb = matrix(5, :) + j*matrix(6, :);
        end
    end
end
