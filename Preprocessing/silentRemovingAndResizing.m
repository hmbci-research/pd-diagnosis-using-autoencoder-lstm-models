clear all;
rootDirectory = 'C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Resampled\Validation\HC';

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
        [audio, Fs] = audioread(currentAudioFile);

        cutOff1= Fs*2;
        cutOff2= Fs/2;
        cutOff3=Fs/2;
        audio2= audio(cutOff1+1:length(audio)-cutOff2);
        sizeControl= floor(length(audio2)/cutOff3);
        newSize=length(audio2);
        control=1;
        for(k=1:sizeControl)
            newAudio=audio2(cutOff3*(k-1)+1:k*cutOff3);
            [~, audioName, audioExt] = fileparts(currentAudioFile);
            %Save
            newSubjectFolder = fullfile('C:\Users\AYSENUR\OneDrive\Masaüstü\Audios\Resized\Validation\HC',subjectFolders{i}) ;
            if ~exist(newSubjectFolder, 'dir')
                mkdir(newSubjectFolder);
            end

            resizedAudio = fullfile(newSubjectFolder, [audioName '_' num2str(k) audioExt]);
                audiowrite(resizedAudio, newAudio, Fs);
        end
    end
end
