%%%% Before starting, split the dataset based on subjects, providing %80 train-%20 test. In train, %80 train-%20 validation. (Random subject selection)

% Define the root directory containing subject-based folders. Change HC to PD for PD audios and train-test-validation folders.
clear all;
rootDirectory = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Original\Validation\HC';

% Get a list of subject folders
subjectFolders = dir(fullfile(rootDirectory));

% Order the subject folders by name
subjectFolders = natsortfiles({subjectFolders.name});

% Loop through each subject folder
for i = 1:numel(subjectFolders)
    % Get the current subject folder
    currentSubjectFolder = fullfile(rootDirectory, subjectFolders{i});
    
    % Get a list of audio files in the current subject folder
    audioFiles = dir(fullfile(currentSubjectFolder, '*.wav'));
    
    % Loop through each audio file in the subject folder
    for j = 1:numel(audioFiles)
        % Load the audio file
        currentAudioFile = fullfile(currentSubjectFolder, audioFiles(j).name);
        [voiceSignal, Fs] = audioread(currentAudioFile);
        
        % Apply wavelet denoising
        threshold = 's';  % Soft thresholding
        if Fs==44100
            level = 3;
        else
            level=2;
        end  % Adjust the level of decomposition as needed
        wavelet = 'db4';  % Choose a wavelet (e.g., 'db4')
        
        denoisedSignal = wdenoise(voiceSignal, level, 'Wavelet', wavelet, 'DenoisingMethod', 'UniversalThreshold', 'ThresholdRule', threshold);
        
        % Save the denoised audio with a new filename
        [~, audioName, audioExt] = fileparts(currentAudioFile);
        newSubjectFolder = fullfile('C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Filtered\Validation\HC',subjectFolders{i}) ;
        if ~exist(newSubjectFolder, 'dir')
            mkdir(newSubjectFolder);
        end
        denoisedAudioFile = fullfile(newSubjectFolder, [audioName '_denoised' audioExt]);
        audiowrite(denoisedAudioFile, denoisedSignal, Fs);
    end
end