
clc
ax= standing2;
ay = VarName30;
az = VarName31;

t= 0:160;
plot(t,ax,t,ay,t,az);
legend('X', 'Y', 'Z');
xlabel('Relative time (s)');
ylabel('Acceleration (m/s^2)');

mag = sqrt(sum(ax.^2 + ay.^2 + az.^2, 2));

figure
plot(t,mag);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

magNoG = mag - mean(mag);
figure
plot(t,magNoG);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

G = fft(magNoG);

figure
plot(abs(G));
xlabel('frequency')
ylabel('magnitude')
legend


minPeakHeight = std(magNoG); %% MINIMUM PEAK HEIGHT IS DETERMINED from the standard deviation

[pks,locs] = findpeaks(magNoG,'MINPEAKHEIGHT',minPeakHeight);
numSteps = numel(pks);
hold on;
figure
plot(t(locs), pks, 'r', 'Marker', 'v', 'LineStyle', 'none');
title('Counting Steps');
xlabel('Time (s)');
ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
hold off;

%%swing and standing times

heelStrikes = find(magNoG > minPeakHeight);
toeOffs = find(magNoG < -minPeakHeight);

% Ensure the arrays have compatible sizes
minSize = min(length(toeOffs), length(heelStrikes));
toeOffs = toeOffs(1:minSize);
heelStrikes = heelStrikes(1:minSize);

% Calculate swing time
swingTime = toeOffs - heelStrikes;

% Display swing time
disp('Swing Time (in seconds):');
disp(swingTime);