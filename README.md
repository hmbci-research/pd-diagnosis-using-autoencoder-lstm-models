# pd-diagnosis-using-autoencoder-lstm-models
# 🧠 Speech Signals-Based Parkinson’s Disease Diagnosis using Hybrid Autoencoder-LSTM Models

This repository contains the codebase for a pipeline aimed at detecting **Parkinson's Disease (PD)** through the analysis of **speech signals**. The system includes a MATLAB-based preprocessing stage and a Google Colab-based deep learning model for training and prediction.

> **This project was developed as part of the research study:**
> **"Speech Signals-Based Parkinson’s Disease Diagnosis using Hybrid Autoencoder-LSTM Models"**

---

## 🎯 Project Aim

The primary goal of this project is to automatically identify Parkinson’s Disease from speech recordings using hybrid AE-LSTM models. The pipeline includes denoising, resampling, silence removal, segmentation, and class balancing before feeding the data into autoencoder-LSTM hybrid models, and training these models.

---

## 📁 Folder Structure

├── Preprocessing/ # MATLAB preprocessing scripts 
    - signalDenoising.m 
    - signalResampling.m
    - silentRemovingAndResizing.m 
    - datasetBalancing.m │ 
├── Models/ # Colab notebook for training and prediction
    - AeLstmModels.ipynb 


---

## 📊 Dataset Preparation & Splitting

1. **Start with a subject-based dataset** of voice recordings.
2. **Split the subjects** as follows:
   - **80% Train**, **20% Test**
   - Then split the **Train** set again:
     - **80% Train**, **20% Validation**

This results in a **Train / Validation / Test** partitioning at the subject level.

---

## 🎧 Audio Folder Format

Each subject must have a dedicated folder, and audio paths should follow similar format:
├── AudioDataset/ 
    ├── Train/  
        ├── HC/ 
            ├── Angela P/ 
                - Audio1.wav
                - Audio2.wav 
        └── PD/ 
            ├── John R/ 
                - Audio1.wav  
    ├── Validation/ 
    ├── Test/

---

## ⚙️ Preprocessing Steps (MATLAB)

All preprocessing steps are located in the `/Preprocessing/` folder. You must update the directory paths (`rootDirectory`, `newSubjectFolder`, etc.) in each script based on the dataset split and class (HC or PD).

### 1. `signalDenoising.m`
- Applies signal denoising to each audio recording.
- Parameters to update:
  - `rootDirectory`: Input folder path
  - `newSubjectFolder`: Output folder path

### 2. `signalResampling.m`
- Downsamples audio from **44.1 kHz to 16 kHz**.
- Parameters to update:
  - `sourceFolder`: Original denoised folder
  - `destinationFolder`: Resampled output folder

### 3. `silentRemovingAndResizing.m`
- Removes the first **2 seconds** and last **0.5 seconds** of each audio signal.
- Segments signals into **500 ms non-overlapping windows** (will be re-segmented into **25 ms** just before training).
- Parameters to update:
  - `rootDirectory`: Input folder
  - `newSubjectFolder`: Output folder

After this step, export all segmented audio files into **flat** class-based folders similar to:
├── Train/  
    ├── HC/ 
        - Audio1.wav
        - Audio2.wav 


### 4. `datasetBalancing.m`
- Balances the dataset by **undersampling the majority class (PD)** to match the number of samples in the minority class (HC).
- Parameters to update:
  - `sourceFolder`
  - `destinationFolder`
  - `majority_class_folder`
  - `minority_class_folder`
  - `output_folder`

---

## 🧠 Model Training (Google Colab)

Once preprocessing is complete, use the Colab notebook to train and evaluate the models:

> 📘 `Models/AeLstmModels.ipynb`

This notebook:
- Loads the audio train, validation, test signals
- Re-segments the signals to 25 ms
- Constructs the autoencoder-LSTM hybrid models
- Trains and validates the models
- Performs prediction and evaluation on the test set

## 📄 Citation

If you use this project in your research, please cite:

> **"Speech Signals-Based Parkinson’s Disease Diagnosis using Hybrid Autoencoder-LSTM Models"**  
> [DOI]

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 💬 Contact

For questions, contributions, or issues, feel free to open a GitHub issue or reach out to the maintainers.


