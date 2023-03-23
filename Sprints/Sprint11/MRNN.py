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



def FunctionReadInCsv(file_name):
    data = pd.read_csv(file_name)
    # data = data.drop(columns=["Unnamed: 14"])
    return data


def FunctionRunModel(df):
    # Separate Target Variable and Predictor Variables
    TargetVariable=['valence', 'arousal']
    
    Predictors=['AF3', 'AF4', 'F3', 'F4', 'F7', 'F8' ,'FC5', 'FC6', 'O1', 'O2', 'P7', 'P8', 'T7', 'T8', 'subject_num']
    X=df[Predictors].values
    y=df[TargetVariable].values

    PredictorScaler=StandardScaler()
    TargetVarScaler=StandardScaler()

    # Storing the fit object for later reference
    PredictorScalerFit=PredictorScaler.fit(X)
    TargetVarScalerFit=TargetVarScaler.fit(y)

    # Generating the standardized values of X and y
    X=PredictorScalerFit.transform(X)
    y=TargetVarScalerFit.transform(y)

    # # Split the data into training and testing set
    # from sklearn.model_selection import train_test_split
    # X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

    model = keras.models.load_model('MRNN_model')

    # Generating Predictions on testing data
    Predictions=model.predict(X)
    
    # Scaling the predicted Price data back to original price scale
    Predictions=TargetVarScalerFit.inverse_transform(Predictions)
    
    # Scaling the y_test Price data back to original price scale
    y_test_orig=TargetVarScalerFit.inverse_transform(y)
    
    # Scaling the test data back to original scale
    Test_Data=PredictorScalerFit.inverse_transform(X)

    TestingData=pd.DataFrame(data=Test_Data, columns=Predictors)
    TestingData[['Valence', 'Arousal']]=y_test_orig
    TestingData[['PredictedValence', 'PredictedArousal']]=Predictions
    
    return(TestingData)

def functionExtractPred(data):
    pred_data = data[['PredictedValence', 'PredictedArousal',]].copy()
    # compression_opts = dict(method='zip',
    #                     archive_name='out.csv')

    pred_data.to_csv('output.csv',index = True, header=False, lineterminator = '\n')
    with open('output.csv', 'r') as f_in, open('output_file.txt', 'w') as f_out:
    # 2. Read the CSV file and store in variable
        content = f_in.read()
    # 3. Write the content into the TXT file
        f_out.write(content)
    return

def main():
    file_name = input("Enter csv name: ")
    data = FunctionReadInCsv(file_name)
    predictions = FunctionRunModel(data)
    functionExtractPred(predictions)

if __name__ == "__main__":
    main()