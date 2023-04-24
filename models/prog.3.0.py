#---------- Import Libraries ----------#

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import random
from scipy.signal import butter, sosfilt
from scipy.interpolate import interp1d
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_absolute_percentage_error
from mlxtend.preprocessing import standardize

import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers, models
from tensorflow.keras.models import load_model
from keras.layers import Dense, Dropout
from keras.models import Sequential, load_model
from keras.optimizers import SGD
from keras.models import Sequential



#---------- MRNN Functions ----------#

def FunctionReadInCsv(file_name):
    data = pd.read_csv(file_name, skiprows=[0])
    # data = data.drop(columns=["Unnamed: 14"])
    HZ = 128

    Columns = ['EEG.AF3', 'EEG.F7', 'EEG.F3', 'EEG.FC5', 'EEG.T7', 'EEG.P7', 'EEG.O1','EEG.O2', 'EEG.P8', 'EEG.T8', 'EEG.FC6', 'EEG.F4',  'EEG.F8' , 'EEG.AF4']

    data = data[Columns]
    data = data.iloc[(HZ * 30):]
    # data['subject_num'] = 1
    # Convert to numpy 2D array
    df = data.to_numpy()
    df = standardize(df)
    # Expand dimension of transposed data
    raw = np.expand_dims(df.T, axis=0)
    stanData = raw.reshape(raw.shape[1], raw.shape[2])
    df = pd.DataFrame(stanData, Columns)
    df = df.transpose()
    df['subject_num'] = 1
    return df

def FunctionRunModel(df):
    # Separate Target Variable and Predictor Variables
    # TargetVariable=['valence', 'arousal']
    # df['subject_num'] = 1
    
    Predictors=['EEG.AF3', 'EEG.F7', 'EEG.F3', 'EEG.FC5', 'EEG.T7', 'EEG.P7', 'EEG.O1','EEG.O2', 'EEG.P8', 'EEG.T8', 'EEG.FC6', 'EEG.F4',  'EEG.F8' , 'EEG.AF4']
    X=df[Predictors].values
    # y=df[TargetVariable].values

    PredictorScaler=StandardScaler()
    # TargetVarScaler=StandardScaler()

    # Storing the fit object for later reference
    PredictorScalerFit=PredictorScaler.fit(X)
    # TargetVarScalerFit=TargetVarScaler.fit(y)

    # Generating the standardized values of X and y
    X=PredictorScalerFit.transform(X)
    # y=TargetVarScalerFit.transform(y)

    # # Split the data into training and testing set
    # from sklearn.model_selection import train_test_split
    # X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

    model = load_model("MRNN_model/MRNNModel.2.0.h5")
    model.load_weights("MRNN_model/MRNNWeights.2.0")

    # Generating Predictions on testing data
    Predictions=model.predict(X)
    
    # Scaling the predicted Price data back to original price scale
    # Predictions=TargetVarScalerFit.inverse_transform(Predictions)
    
    # Scaling the y_test Price data back to original price scale
    # y_test_orig=TargetVarScalerFit.inverse_transform(y)
    
    # Scaling the test data back to original scale
    Test_Data=PredictorScalerFit.inverse_transform(X)

    TestingData=pd.DataFrame(data=Test_Data, columns=Predictors)
    # TestingData[['Valence', 'Arousal']]=y_test_orig
    TestingData[['PredictedValence', 'PredictedArousal']]=Predictions

    pred_data = TestingData[['PredictedValence', 'PredictedArousal']].copy()

    pred_data.loc[(pred_data.PredictedValence < 0), 'PredictedValence'] = 0
    pred_data.loc[(pred_data.PredictedArousal < 0), 'PredictedArousal'] = 0
    pred_data.loc[(pred_data.PredictedValence > 1), 'PredictedValence'] = 1
    pred_data.loc[(pred_data.PredictedArousal > 1), 'PredictedArousal'] = 1

    HZ = 128
    res = pred_data.groupby(np.arange(len(pred_data))//HZ).mean()
    # res.to_csv('output.csv',index = True, header=False, lineterminator = '\n')
    # indices = df['Index']
    # TestingData = TestingData.join(indices)
    
    return(res)

def functionExtractPred(data):
    # pred_data = data[['PredictedValence', 'PredictedArousal']].copy()
    # # pred_data = pred_data.loc[0:127]
    # HZ = 128
    # res = pred_data.groupby(np.arange(len(pred_data))//HZ).mean()
    # compression_opts = dict(method='zip',
    #                     archive_name='out.csv')

    data.to_csv('output.csv',index = True, header=False, lineterminator = '\n')
    with open('output.csv', 'r') as f_in, open('output_NN.txt', 'w') as f_out:
    # 2. Read the CSV file and store in variable
        content = f_in.read()
    # 3. Write the content into the TXT file
        f_out.write(content)
    return data



#---------- Band-Pass Filter Functions ----------#

def butter_bandpass(lowcut, highcut, fs, order=5):
    return butter(order, [lowcut, highcut], fs=fs, btype='bandpass', output='sos')

def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    sos = butter_bandpass(lowcut, highcut, fs, order=order)
    y = sosfilt(sos, data)
    return y



#---------- CNN_SAE_DNN Function ----------#

def CNN_SAE_DNN(filepath):
    #---------- Load Session Recording ----------#

    # Set Needed Columns and Recording Rate
    EEG_COLUMNS = ["EEG.AF3", "EEG.F7", "EEG.F3", "EEG.FC5", "EEG.T7", "EEG.P7", "EEG.O1", "EEG.O2", "EEG.P8", "EEG.T8", "EEG.FC6", "EEG.F4", "EEG.F8", "EEG.AF4"]
    HZ = 128

    # Import data but skip the first line (metadata)
    df = pd.read_csv(filepath, skiprows=[0])
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
    CNN_model = load_model("CNN_SAE_DNN_model/CNNModel.2.0.h5")
    CNN_model.load_weights("CNN_SAE_DNN_model/CNNWeights.2.0")

    # Load in SAE Model
    SAE_model = load_model("CNN_SAE_DNN_model/SAEModel.2.0.h5")
    SAE_model.load_weights("CNN_SAE_DNN_model/SAEWeights.2.0")

    # Load in DNN Model
    DNN_model = load_model("CNN_SAE_DNN_model/DNNModel.2.0.h5")
    DNN_model.load_weights("CNN_SAE_DNN_model/DNNWeights.2.0")



    #---------- Run Session through Models ----------#

    # Get output of CNN Model
    CNN_out = CNN_model.predict(reshapedData)
    # Get output of SAE Model
    SAE_out = SAE_model.predict(CNN_out)
    # Get output of DNN Model
    out = DNN_model.predict(SAE_out)



    #---------- Argmax and Return Predictions ----------#

    predictions = np.argmax(out, axis=1)
    df = pd.DataFrame(predictions)
    return df



#---------- Combine Predictions Together and Save ----------#

def CombineAndSave(mrnn, csd, filename = "output.csv"):
    # Make sure the indexes are set
    mrnn = mrnn.reset_index(drop=True)
    csd = csd.reset_index(drop=True)
    # Complete an inner join on the index of both dataframes
    # This will drop the left over observations if one is longer than the other
    df = pd.merge(mrnn, csd, left_index=True, right_index=True)
    # Save to file
    df.to_csv(filename, index=False, header=False)

#---------- Map MRNN Values ----------#

def mapToHighest(mrnn):
    highVal = mrnn.iloc[:,0].max()
    highAro = mrnn.iloc[:,1].max()

    valMap = interp1d([0,highVal],[0,1])
    aroMap = interp1d([0,highAro],[0,1])

    mrnn.iloc[:,0] = mrnn.iloc[:,0].apply(lambda x: float(valMap(x)))
    mrnn.iloc[:,1] = mrnn.iloc[:,1].apply(lambda x: float(aroMap(x)))

    return mrnn

def mapToRandom(mrnn):
    mrnn.iloc[:,0] = mrnn.iloc[:,0].apply(lambda x: random.random())
    mrnn.iloc[:,1] = mrnn.iloc[:,0].apply(lambda x: random.random())

    return mrnn

#---------- Run Models ----------#

if __name__ == "__main__":
    filepath = "output.csv"
    
    mrnn_data = FunctionReadInCsv(filepath)
    mrnn_pred = FunctionRunModel(mrnn_data)
    mrnn_map = mapToRandom(mrnn_pred)
    
    csd_pred = CNN_SAE_DNN(filepath)
    csd_pred = csd_pred.reset_index(drop=True)
    CombineAndSave(mrnn_map, csd_pred, filename = "../processing/genArtProg/output.csv")