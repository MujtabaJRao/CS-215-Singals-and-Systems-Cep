fs = 44100;

% --- Frequencies Map ---
notes = containers.Map(...
    {'A2', 'E2', 'F2', 'G2', 'C3', 'E3', 'G3', 'G#3', 'A3', 'B3', 'C4', 'D4', 'E4', 'G4', 'A4'}, ...
    [110.0, 82.4, 87.3, 98.0, 130.8, 164.8, 196.0, 207.6, 220.0, 246.9, 261.6, 293.6, 329.6, 392.0, 440.0]);

% --- The Score ---
% {Note, Start, Duration, Volume}
full_song = {
    'A2', 0.0, 2.5, 0.8; 'E4', 0.2, 1.2, 0.5; 'C4', 0.4, 1.2, 0.4; 'B3', 0.8, 1.2, 0.6;
    'F2', 2.5, 2.5, 0.8; 'C4', 2.7, 1.2, 0.5; 'A3', 2.9, 1.2, 0.4; 'E4', 3.3, 1.8, 0.7;
    'A2', 5.0, 2.5, 0.8; 'E4', 5.2, 1.2, 0.5; 'G4', 5.4, 1.2, 0.4; 'B3', 5.8, 1.2, 0.6;
    'F2', 7.5, 2.5, 0.8; 'A3', 7.7, 1.2, 0.5; 'C4', 8.0, 1.2, 0.4; 'E4', 8.5, 2.0, 0.7;
    'C3', 10.0, 1.5, 0.7; 'G3', 10.02, 1.5, 0.6; 'C4', 10.04, 1.5, 0.5; 'E4', 10.06, 1.5, 0.5;
    'G2', 11.5, 1.5, 0.7; 'B3', 11.52, 1.5, 0.6; 'D4', 11.54, 1.5, 0.5; 'G4', 11.56, 1.5, 0.5;
    'A2', 15.0, 3.0, 0.8; 'A4', 13.2, 2.0, 0.7; 'G4', 13.5, 2.0, 0.6; 'E4', 13.8, 2.0, 0.5;
    'E2', 15.0, 3.0, 0.9; 'G#3', 15.02, 3.0, 0.6; 'B3', 15.04, 3.0, 0.5; 'D4', 15.06, 3.0, 0.5;
    'A2', 17.5, 5.0, 1.0; 'E3', 17.52, 5.0, 0.7; 'A3', 17.54, 5.0, 0.6; 'C4', 17.56, 5.0, 0.5; 'E4', 17.58, 5.0, 0.5
};

% Calculate total duration + padding
max_time = 0;
for i = 1:size(full_song, 1)
    max_time = max(max_time, full_song{i, 2} + full_song{i, 3});
end
total_samples = floor((max_time + 3.0) * fs);
canvas = zeros(1, total_samples);

% --- Synthesis Loop ---
for i = 1:size(full_song, 1)
    note_name = full_song{i, 1};
    start_time = full_song{i, 2};
    duration = full_song{i, 3};
    volume = full_song{i, 4};
    
    wave = pluck_matlab(notes(note_name), duration, volume, fs);
    
    start_idx = floor(start_time * fs) + 1;
    end_idx = start_idx + length(wave) - 1;
    
    % Add to master canvas
    canvas(start_idx:end_idx) = canvas(start_idx:end_idx) + wave;
end

% Normalize and Save Song
canvas = canvas / max(abs(canvas));
audiowrite('riff_sustain_fixed.wav', canvas, fs);

% --- Export Individual Unique Notes ---
unique_notes = unique(full_song(:, 1));
for i = 1:length(unique_notes)
    n_name = unique_notes{i};
    % We use a standard 2s duration for individual previews
    n_wave = pluck_matlab(notes(n_name), 2.0, 0.8, fs);
    n_wave = n_wave / max(abs(n_wave));
    audiowrite(['note_', n_name, '.wav'], n_wave, fs);
end

fprintf('Synthesis complete. Song and individual notes saved.\n');

% --- Helper Function ---
function output = pluck_matlab(freq, duration, volume, sample_rate)
    if freq <= 0
        output = zeros(1, floor(duration * sample_rate));
        return;
    end
    
    N = floor(sample_rate / freq);
    ring_time = max(duration, 1.5);
    total_samples = floor(ring_time * sample_rate);
    
    % Initial noise burst
    ring_buffer = (rand(1, N) * 2 - 1) * volume;
    output = zeros(1, total_samples);
    
    decay = 0.998;
    
    % Karplus-Strong Loop
    for i = 1:total_samples
        output(i) = ring_buffer(mod(i-1, N) + 1);
        
        idx = mod(i-1, N) + 1;
        next_idx = mod(i, N) + 1;
        
        avg = 0.5 * (ring_buffer(idx) + ring_buffer(next_idx));
        ring_buffer(idx) = avg * decay;
    end
    
    % Smooth fade-out (300ms)
    fade_len = floor(sample_rate * 0.3);
    if length(output) > fade_len
        fade = linspace(1, 0, fade_len);
        output(end-fade_len+1:end) = output(end-fade_len+1:end) .* fade;
    end
end
