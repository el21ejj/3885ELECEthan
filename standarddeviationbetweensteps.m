
%% different data from different trials can be uploaded and added here
Data = sqrt(sum(walkingax1.^2 + walkingay1.^2 + walkingaz1.^2, 2));
Datag = sqrt(sum(walkinggx1.^2 + walkinggy1.^2 + walkinggz1.^2, 2));

DataNoG = Data - mean(Data); 
figure
plot(DataNoG)
figure
plot(Datag)

G =fft(Data);
figure
plot(abs(G))
xlabel('Frequency')
ylabel('Magnitude')
w

minPeakHeight = 0.25; 
[pks,locs] = findpeaks(DataNoG,'MINPEAKHEIGHT',minPeakHeight);

timings = diff(locs);


meanTimings = mean(timings);
stdTimings = std(timings);
numSteps = numel(pks); %% nummber of steps


meanTimings = mean(timings);
stdTimings = std(timings);

symmetry_score = max(0, 1 - stdTimings);

disp(['Symmetry score: ', num2str(symmetry_score)]);
