% Clear workspace and command window
clear;
clc;

% Define the source and destination folders
sourceFolder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Filtered\Validation\HC'; % Change this to your source folder path
destinationFolder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Resampled\Validation\HC'; % Change this to your destination folder path

% Ensure the destination folder exists
if ~exist(destinationFolder, 'dir')
    mkdir(destinationFolder);
end

subjectFolders = dir(fullfile(sourceFolder));
subjectFolders = subjectFolders([subjectFolders.isdir] & ~startsWith({subjectFolders.name}, '.'));

% Target sampling frequency
targetFs = 16000;

% Loop through each subject folder
for i = 1:numel(subjectFolders)
    subjectFolder = fullfile(sourceFolder, subjectFolders(i).name);
    
    % Get a list of all audio files in the subject folder
    audioFiles = dir(fullfile(subjectFolder, '*.wav'));

    % Loop through each audio file
    for j = 1:length(audioFiles)
        % Get the full path of the current audio file
        sourceFilePath = fullfile(subjectFolder, audioFiles(j).name);
        
        % Read the audio file
        [audioData, originalFs] = audioread(sourceFilePath);
        
        % Resample the audio to the target sampling frequency
        if originalFs ~= targetFs
            audioDataResampled = resample(audioData, targetFs, originalFs);
        else
            audioDataResampled = audioData;
        end
        
        % Create the full path for the resampled audio file
        [~, name, ext] = fileparts(audioFiles(j).name);
        subjectDestFolder = fullfile(destinationFolder, subjectFolders(i).name);
        if ~exist(subjectDestFolder, 'dir')
            mkdir(subjectDestFolder);
        end
        destinationFilePath = fullfile(subjectDestFolder, [name ext]);
        
        % Write the resampled audio to the destination folder
        audiowrite(destinationFilePath, audioDataResampled, targetFs);
        
        % Display progress
        fprintf('Resampled and saved: %s\n', audioFiles(j).name);
    end
end