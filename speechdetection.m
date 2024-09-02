[audio, fs] = audioread('Speech In Audio.wav');
frame_length = 0.02;  
frame_overlap = 0.01; 


energies = calcShortTermEnergy(audio, frame_length, frame_overlap, fs);
threshold_factor = 0.02;  % matches when speech detection command is used for this specific threshold
threshold = threshold_factor * median(energies); 

speech_segments = energies > threshold;

speech_duration = sum(speech_segments) * frame_overlap;  

disp(speech_duration)


function energies = calcShortTermEnergy(audio, frame_length, frame_overlap, fs)
    frame_length_samples = frame_length * fs;
    frame_overlap_samples = frame_overlap * fs;
    
    num_frames = floor((length(audio) - frame_length_samples) / frame_overlap_samples) + 1;
    energies = zeros(num_frames, 1);
    
    for i = 1:num_frames
        start_index = 1 + (i-1) * frame_overlap_samples;
        end_index = start_index + frame_length_samples - 1;
        frame = audio(start_index:end_index);
        energies(i) = sum(frame.^2);
    end
end

