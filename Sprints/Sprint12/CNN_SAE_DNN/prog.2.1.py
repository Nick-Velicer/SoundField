#---------- Import Libraries ----------#

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import butter, sosfilt
from mlxtend.preprocessing import standardize

import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers, models
from tensorflow.keras.models import load_model



#---------- Band-Pass Filter Functions ----------#

def butter_bandpass(lowcut, highcut, fs, order=5):
    return butter(order, [lowcut, highcut], fs=fs, btype='bandpass', output='sos')

def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    sos = butter_bandpass(lowcut, highcut, fs, order=order)
    y = sosfilt(sos, data)
    return y



#---------- Load Session Recording ----------#

# Set Path of Recording
RECORDING_PATH = "../../../TestData/Recordings/S2/NickVelicer_006_3272023_EPOCX_180417_2023.03.27T14.35.25.05.00.md.bp.csv"

# Set Needed Columns and Recording Rate
EEG_COLUMNS = ["EEG.AF3", "EEG.F7", "EEG.F3", "EEG.FC5", "EEG.T7", "EEG.P7", "EEG.O1", "EEG.O2", "EEG.P8", "EEG.T8", "EEG.FC6", "EEG.F4", "EEG.F8", "EEG.AF4"]
HZ = 128

# Import data but skip the first line (metadata)
df = pd.read_csv(RECORDING_PATH, skiprows=[0])
# Select subsection of EEG electrode recordings
df = df[EEG_COLUMNS]
# Drop the first 30 seconds of buffer time
df = df.iloc[(HZ * 23):]
# Convert to numpy 2D array
df = df.to_numpy()
# Standardize 2D array
df = standardize(df)
# Expand dimension of transposed data
raw = np.expand_dims(df.T, axis=0)



#---------- General Band-Pass Filter ----------#

# Filter Params
LOWCUT = 0.1
HIGHCUT = 45.0
ORDER = 9

# Initialize empty matrix to put all filtered data into
filterData = np.zeros_like(raw)

# Iterate through each epoch/recording
for idx in range(raw.shape[0]):
    # Get the epoch of the index
    epoch = raw[idx]
    # Initialize empty matrix to put filtered epoch data into
    filteredEpoch = np.zeros_like(epoch)

    # Iterate through the rows of the epoch/recording
    # Each row is a 1D vector of one electrodes values
    for i in range(epoch.shape[0]):
        # Get the row of the index
        channel = epoch[i]
        # Use the butterworth bandpass filter from 0.1-45 Hz
        filtered = butter_bandpass_filter(channel, LOWCUT, HIGHCUT, HZ, order=ORDER)
        
        # Add filtered channel into the filterEpoch matrix
        filteredEpoch[i] = filtered
    
    # Add filtered epoch into the filterData matrix
    filterData[idx] = filteredEpoch



#---------- Butterworth Band-Pass Filter ----------#

# Filter Params
ALPHA = (1, 7)
BETA = (8, 13)
THETA = (14, 30)
LAMBDA = (30, 45)
ORDER = 9

# Initialize empty list to put all epoched band data into
bandData = []

# Iterate through each filtered epoch/recording
for idx in range(filterData.shape[0]):
    # Get the epoch of the index
    epoch = filterData[idx]
    # Initialize empty matrixs to put band data into
    alphaData = np.zeros_like(epoch)
    betaData = np.zeros_like(epoch)
    thetaData = np.zeros_like(epoch)
    lambdaData = np.zeros_like(epoch)

    # Iterate through the rows of the filtered epoch/recording
    # Each row is a 1D vector of one electrodes values
    for i in range(epoch.shape[0]):
        # Get the row of the index
        channel = epoch[i]
        # Use the butterworth bandpass filter for each band on a channel
        alphaChan = butter_bandpass_filter(channel, ALPHA[0], ALPHA[1], HZ, order=ORDER)
        betaChan = butter_bandpass_filter(channel, BETA[0], BETA[1], HZ, order=ORDER)
        thetaChan = butter_bandpass_filter(channel, THETA[0], THETA[1], HZ, order=ORDER)
        lambdaChan = butter_bandpass_filter(channel, LAMBDA[0], LAMBDA[1], HZ, order=ORDER)

        # Add each band channel vector into its respective matrix
        alphaData[i] = alphaChan
        betaData[i] = betaChan
        thetaData[i] = thetaChan
        lambdaData[i] = lambdaChan
    
    # Initialize list of band data
    epochBandData = [alphaData, betaData, thetaData, lambdaData]
    # Take the list of 2D numpy arrays and
    # convert it to 3D matrix
    epochBandData = np.stack(epochBandData)
    # Append the epochBandData to bandData list
    bandData.append(epochBandData)

# Take the list of 3D numpy arrays and 
# convert it to 4D matrix
bandData = np.stack(bandData)



#---------- Epoch the Epochs ----------#

# Initialize empty lists to put all 8 seconds epochs and new labels into respectively
epochData = []

# Iterate through each filtered band epoch/recording
for idx in range(bandData.shape[0]):
    # Get the epoch of the index
    epoch = bandData[idx]

    # Iterrate through 8 second time intervals 
    for t in range(0, epoch.shape[2], HZ*1):
        # Break if 8 seconds goes past end of recording
        if (t + HZ*8 > epoch.shape[2]):
            break

        # Initialize empty matrix to put 8 s epoch into (4, 14, 1024)
        epoch8 = np.zeros((epoch.shape[0], epoch.shape[1], HZ*8))

        # Iterate through each band in the epoch
        for i in range(epoch.shape[0]):
            # Add the time interval from this
            # band into the epoch8 matrix
            epoch8[i] = epoch[i,:,t:t+HZ*8]

        # Append 8 second epoch to epochData list
        epochData.append(epoch8)


# Take the list of 3D numpy arrays and 
# convert it to 4D matrix
epochData = np.stack(epochData)



#---------- PCC Feature Extraction ----------#

# Initialize empty list to put the PCC data into
pccData = []

# Iterate through each epoch
for idx in range(epochData.shape[0]):
    # Get the epoch of the index
    epoch = epochData[idx]
    # Initialize empty list to put the epoch PCC data into
    pccEpoch = []
    
    # Iterate through each band
    for i in range(epoch.shape[0]):
        # Get the band of the index
        band = epoch[i]
        # Extract PCC from the band
        pcc = np.corrcoef(band)
        # Append PCC features into pccEpoch list
        pccEpoch.append(pcc)

    # Take the list of 2D numpy arrays and
    # convert it to 3D matrix
    pccEpoch = np.stack(pccEpoch)
    # Append the pccEpoch to pccData list
    pccData.append(pccEpoch)
    
# Take the list of 3D numpy arrays and
# convert it to 4D matrix
pccData = np.stack(pccData)



#---------- Reshape to Multi-Image Format ----------#

# Initialize empty list to put reshaped data into
reshapedData = [np.transpose(i, (1, 2, 0)) for i in pccData]
reshapedData = np.stack(reshapedData)



#---------- Load in Trained Models ----------#

# Load in CNN Model
CNN_model = load_model("CNNModel.2.0.h5")
CNN_model.load_weights("CNNWeights.2.0")

# Load in SAE Model
SAE_model = load_model("SAEModel.2.0.h5")
SAE_model.load_weights("SAEWeights.2.0")

# Load in DNN Model
DNN_model = load_model("DNNModel.2.0.h5")
DNN_model.load_weights("DNNWeights.2.0")



#---------- Run Session through Models ----------#

# Get output of CNN Model
CNN_out = CNN_model.predict(reshapedData)
# Get output of SAE Model
SAE_out = SAE_model.predict(CNN_out)
# Get output of DNN Model
out = DNN_model.predict(SAE_out)



#---------- Argmax and Save Predictions ----------#

predictions = np.argmax(out, axis=1)
print(predictions)
pd.DataFrame(predictions).to_csv("output.csv", index=False, header=False)