% State Variable Filter Implementation in MATLAB

% Sampling frequency (Hz)
fs = 44100; 
% Filter cutoff frequency (Hz)
f_cutoff = 1000; 
% Quality factor (Q)
Q = 1 / sqrt(2);  % Standard value for Butterworth response

% Calculate tuning coefficients
F1 = 2 * sin(pi * f_cutoff / fs); 

% Initialize state variables
y1 = 0; % Lowpass output
y2 = 0; % Bandpass output
y3 = 0; % Highpass output

% Read input signal from .wav file
[input_signal, fs] = audioread('Caramitru44kScurt.wav');
input_signal = input_signal(:, 1); % Use only the first channel if stereo

% Prepare output signals
lowpass_output = zeros(size(input_signal));
bandpass_output = zeros(size(input_signal));
highpass_output = zeros(size(input_signal));

% Process the input signal sample by sample
for n = 1:length(input_signal)
    x = input_signal(n); % Current input sample
    
    % Highpass calculation
    y3 = x - y1 - Q * y2;
    
    % Bandpass calculation
    y2 = y2 + F1 * y3;
    
    % Lowpass calculation
    y1 = y1 + F1 * y2;
    
    % Store the results
    lowpass_output(n) = y1;
    bandpass_output(n) = y2;
    highpass_output(n) = y3;
end

T = length(input_signal) / fs;
t = linspace(0, T, length(input_signal));

figure;
subplot(4,1,1);
plot(t, input_signal);
title('Input Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,2);
plot(t, lowpass_output);
title('Lowpass Output');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,3);
plot(t, bandpass_output);
title('Bandpass Output');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(4,1,4);
plot(t, highpass_output);
title('Highpass Output');
xlabel('Time (s)'); ylabel('Amplitude');

% Save output signals to .wav files
audiowrite('lowpass_output.wav', lowpass_output, fs);
audiowrite('bandpass_output.wav', bandpass_output, fs);
audiowrite('highpass_output.wav', highpass_output, fs);

% Play output signals
fprintf('Playing original input...\n');
sound(input_signal, fs);
pause(T + 1);

fprintf('Playing lowpass output...\n');
sound(lowpass_output, fs);
pause(T + 1);

fprintf('Playing bandpass output...\n');
sound(bandpass_output, fs);
pause(T + 1);

fprintf('Playing highpass output...\n');
sound(highpass_output, fs);
pause(T + 1);