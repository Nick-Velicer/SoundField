# TODO: add more cleaning for large data files. possibly averaging the predicted valence/arousal over some amount of time


import numpy as np 
import pandas as pd
import os
import glob
import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow import keras
from sklearn.preprocessing import StandardScaler
from keras.layers import Dense, Dropout
from keras.models import Sequential, load_model
from keras.optimizers import SGD
from keras.models import Sequential
from sklearn.metrics import mean_absolute_percentage_error
from mlxtend.preprocessing import standardize



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
    
    Predictors=['EEG.AF3', 'EEG.F7', 'EEG.F3', 'EEG.FC5', 'EEG.T7', 'EEG.P7', 'EEG.O1','EEG.O2', 'EEG.P8', 'EEG.T8', 'EEG.FC6', 'EEG.F4',  'EEG.F8' , 'EEG.AF4', 'subject_num']
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

    model = keras.models.load_model('MRNN_model')

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
    res.to_csv('output.csv',index = True, header=False, lineterminator = '\n')
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

def main():
    file_name = "../../../TestData/Recordings/S2/NickVelicer_006_3272023_EPOCX_180417_2023.03.27T14.35.25.05.00.md.bp.csv"
    data = FunctionReadInCsv(file_name)
    predictions = FunctionRunModel(data)
    results = functionExtractPred(predictions)

if __name__ == "__main__":
    main()