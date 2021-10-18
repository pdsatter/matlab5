function sortedM = SortColumns(M)
% Purpose: Sorts each column of the given matrix in ascending order.
%
% Inputs:
%   M = a matrix
% Outputs:
%   sortedM = a matrix with columns sorted in ascending order
%
% Remember that the above function header is only a template and the names of any input and/or
% output variables can be changed, if desired.

% Take pivot and move all numbers greater to right and all numbers smaller
% to left, then take the pivot of smaller and greater numbers until array
% is sorted

% Quick sort
    function [sorted] = quicksort(arr)
        if length(arr) <= 1  % length is 1 means only 1 number left, already sorted
            sorted = arr;  % sorted is the sorted array, since only 1 number then array is sorted, so return
            return
        end
        pivot = arr(1);  % pivot is number to check
        lesser = [];  % numbers smaller than pivot
        greater = [];  % numbers greate than pivot
        equal = [];  % nums equal to pivot
        
        for i = 1:length(arr)  % iterates through array
            if arr(i) < pivot  % adds value to lesser if < pivot
                lesser = [lesser, arr(i)];
            elseif arr(i) > pivot  % adds value to greater if > pivot
                greater = [greater, arr(i)];
            else
                equal = [equal, arr(i)];
            end
        end
        
        % now sort the lesser and greater arrays
        if length(lesser) == 1 && length(greater) ==1 % if length ==1 then nothing left to sort
            sorted = [lesser, equal, greater];  
        elseif length(greater) == 1  % sorts lesser
            sorted = [quicksort(lesser), equal, greater];
        elseif length(lesser) == 1  % sorts greater
            sorted = [lesser, equal, quicksort(greater)];
        else
            sorted = [quicksort(lesser), equal, quicksort(greater)];
        end
        
    end


    sortedM = M;  % initiate to set correct size
    [~, col] = size(M);  % gets number of cols to sort

    for j = 1:col  % sorts every column
        sortedM(:,j) = quicksort(M(:,j));
    end
end