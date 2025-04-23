% Before balancing the dataset, export all the audios from subject-based folders to target HC-PD folders
clear all;
% Define source and destination folders
sourceFolder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Resized\Validation\PD'; % Specify the path to the source folder containing subfolders with audios
destinationFolder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\FinalFolder\Validation\PD'; % Specify the path to the destination folder to copy audios


% Get a list of all subfolders in the source folder
subfolders = dir(sourceFolder);
subfolders = subfolders([subfolders.isdir]); % Keep only directories
subfolders = subfolders(~ismember({subfolders.name}, {'.', '..'})); % Remove '.' and '..' entries

% Loop through each subfolder
for i = 1:numel(subfolders)
    subfolder = fullfile(sourceFolder, subfolders(i).name);
    
    % Get a list of audio files in the current subfolder
    audioFiles = dir(fullfile(subfolder, '*.wav')); 
    
    % Loop through each audio file in the current subfolder
    for j = 1:numel(audioFiles)
        % Get the source and destination paths for the current audio file
        sourcePath = fullfile(subfolder, audioFiles(j).name);
        destinationPath = fullfile(destinationFolder, audioFiles(j).name);
        
        % Copy the audio file to the destination folder
        copyfile(sourcePath, destinationPath);
    end
end

%Balancing (do not forget to change train/testvalidation folders)
clear all;
% Define paths to the folders containing audios for each class
majority_class_folder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\FinalFolder\Validation\PD';
minority_class_folder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\FinalFolder\Validation\HC';

% Define the desired number of audios in the minority class
desired_num_minority_audios = 100; % Adjust as needed

% Get a list of audio files in each class folder
majority_audios = dir(fullfile(majority_class_folder, '*.wav'));
minority_audios = dir(fullfile(minority_class_folder, '*.wav'));

% Calculate the number of audios in each class
num_majority_audios = numel(majority_audios);
num_minority_audios = numel(minority_audios);

% Calculate the downsampling ratio
downsampling_ratio = num_minority_audios / num_majority_audios;

% Randomly select a subset of audios from the majority class
selected_majority_audios_indices = randperm(num_majority_audios, round(num_majority_audios * downsampling_ratio));
selected_majority_audios = majority_audios(selected_majority_audios_indices);

% Copy the selected majority class audios to a new folder
output_folder = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Balanced\Validation\PD';

for i = 1:numel(selected_majority_audios)
    % Copy the selected majority class audios to the output folder
    source_file = fullfile(majority_class_folder, selected_majority_audios(i).name);
    destination_file = fullfile(output_folder, selected_majority_audios(i).name);
    copyfile(source_file, destination_file);
end

%%% You can copy HC folder manually from Resized folder to Balanced folder.%%

