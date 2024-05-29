clc

% Generate two signals
t = 0:160; % Time vector
signal1 = ax1;
signal2 = ax2;
signal3 = ax3;
signal4 = ax4;
signal5 = ax5;
signal6 = ax6;
signal7 = ax7;
signal8 = ax8;
signal9 = ax9;
signal10 = ax10;

signals = {signal1, signal2, signal3, signal4, signal5, signal6, signal7, signal8, signal9, signal10};


correlationMatrix = zeros(10, 10);
for i = 1:10
    for j = 1:10
        correlationMatrix(i, j) = max(xcorr(signals{i}, signals{j}));
    end
end

% Find the pair of signals with the highest correlation
[maxCorr, maxIndex] = max(correlationMatrix(:));
[maxRow, maxCol] = ind2sub(size(correlationMatrix), maxIndex);

% Align the signals based on the lag from the maximum correlation
lagSeconds = (maxCol - numel(signals{maxRow})) * (2*pi/163);
alignedSignals = cell(10, 1);
for i = 1:10
    alignedSignals{i} = circshift(signals{i}, -round(lagSeconds/(2*pi/163)));
end

% Calculate the average of the aligned signals
averageSignal = mean(cat(3, alignedSignals{:}), 3);

% Plot the average signal
figure;
plot(averageSignal);
xlabel('Time');
ylabel('Amplitude');
title('Average Signal');

% Display the average signal
disp('Average Signal:');
disp(averageSignal);