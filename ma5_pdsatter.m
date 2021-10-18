% Name: Preston Satterfield
% UH ID: 1972081
% CougarNet: pdsatter
% Assignment: MA 5 

% Seismic waves effect on buildings.

%% TASK 1:
% Step 1: Load in data

% Step 2: Check data and get user to replace any number <= 0, continue
%   until user gives positive value
%   In prompt include: index (row/col) of value needing replaced

% Step 3: Out put number of values user changed to positive in command
% window

data = load('SeismicData.csv');
row = [];
col = [];
numReplaced = sum(sum(data <= 0));  % sees how many data points need replaced
[row1, col1]= size(data);
for a = 1:row1
    for b = 1:col1
        if data(a,b) <= 0
            row = [row; a];
            col = [col; b];
        end
        
    end
end
for i = 1:length(row)
    newEntry = 0;
    while newEntry <= 0
        prompt = sprintf('Enter a positive value at (%d, %d): ', row(i), col(i));
        newEntry = input(prompt);
    end
    data(row(i),col(i)) = newEntry;
end
fprintf('\nThere were %d values changed from negative/zero to positive. \n\n', numReplaced)

%% TASK 2:
% Max wave velocity is 13500 - 15000(m/s)
% Step 1: Prompt user to define maximum limit

% Step 2: Check user has entered value in acceptable range, 13500 - 15000(m/s)
% continue prompting until correct value is entered

% Step 3: Check dataset for values greater than max.  Replace with limit
% Step 4: Store indices of replaed values in a matrix, 
%   Col 1: Row vals  Col 2: Col values

% Step 5: Export matrix as SeismicData_Changes.csv
% Step 6: Output number of values replaced in command window
maxVel = 0;
while maxVel < 13500 || maxVel > 15000
    maxVel = input('Enter a velocity limit between 13,500 and 15,000 [m/s]: ');
end

%[rowM, colM] = find(maxVel < data);
rowM = [];
colM = [];
for c = 1:row1
    for d = 1:col1
        if data(c, d) > maxVel
            rowM = [rowM; c];
            colM = [colM; d];
        end
    end
end

for j = 1:length(rowM)
    data(rowM(j),colM(j)) = maxVel;
end

maxMatrix = [rowM, colM];

numReplaced_max = length(rowM);
fprintf('There were %d values over the velocity limit. \n\n', numReplaced_max)

writematrix(maxMatrix, 'SeismicData_Changes.csv')


%% TASK 3:
% Step 1: Create funciton SortColumns.m  that sorts all columns in
% ascending order
% inputs: matrix
% outputs: sorted matrix

% Cannot use: sort() sortrows() max() min() find() or equivalents

sortedM = SortColumns(data);
writematrix(sortedM, 'SeismicData_sorted.csv')

%% TASK 4:
% Step 1: Prompt user to choose a location to normalize.
% equation: Vn = (v-vmin)/(vmax-vmin)

% Step 2: Output a formatted table of the original values and the
% normalized values

% Cannot use: functions listed in task 3, cell2table() or equivalent
repeat = 1;
while repeat == 1
    repeat = 0;
    location_normalize = input('Which locations data would you like to normalize? ');
    
    % NORMALIZE FUNCTION
    % Vn = (v-vmin) / (vmax - vmin);
    sortedCol = SortColumns(data(:,location_normalize));
    normalizedCol = zeros(length(sortedCol), 1);  % Initialize with same size
    
    vmin = sortedCol(1);
    vmax = sortedCol(end);
    
    for k = 1:length(sortedCol)
        v = sortedCol(k);
        normalizedCol(k) = (v-vmin)/(vmax-vmin);
    end

    fprintf('Original\t Normalized')
     disp([sortedCol, normalizedCol])
    
    
    
    
    %% TASK 5:
% Step 1: Ask user if they would like to normalize a differnt column of
% sorted data
%   If yes: repeat task 4
%   If no: continue   
    while repeat == 0
        repeat = menu('Would you like to normalize another column?','Yes','No');
    end
    
end



%% TASK 6:
% Step 1: Plot normalized velocity data in 2 ways
%       * measurement number on x-axis, norm on y-axis
%       * norm vel on x-axis, original vel on y-axis
%       * subplotted
% Step 2: Format: x-axis label, y-axis label, Title, Gridlines


subplot(1,2,1); % measurement number on x-axis, norm on y-axis
x1 = 1:length(normalizedCol);
y1 = normalizedCol;
scatter(x1,y1)

xlabel('Measurement (-)[-]')
ylabel('Normalized Velocity (Vn)[-]')
title('Normalized Seismic Velocity Data')
grid on


subplot(1,2,2); % norm vel on x-axis, original vel on y-axis
x2 = normalizedCol;
y2 = sortedCol;
scatter(x2,y2)

xlabel('Normalized Scale (Vn)[-]')
ylabel('Seismic Velocity(v)[m/s]')
title('Scaled Seismic Velocity Data')
% xlim([0,1])
% xticks(0:0.1:1)
grid on
