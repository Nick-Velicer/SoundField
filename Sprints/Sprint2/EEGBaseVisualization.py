import pandas
import matplotlib.pyplot as plt

VISUALIZE = True

RAW_DATA_PATH = '../../Data/GAMEEMO/(S01)/Raw EEG Data/.csv format/S01G1AllRawChannels.csv'
PREPROCESSED_DATA_PATH = '../../Data/GAMEEMO/(S01)/Preprocessed EEG Data/.csv format/S01G1AllChannels.csv'

df = pandas.read_csv(PREPROCESSED_DATA_PATH)

time_limit = 60 * 128 # = 7680
time_series = range(time_limit)

electrode_names = df.columns[:-1]

if VISUALIZE:
    offset = 0
    for electrode in electrode_names:
        plt.plot(time_series, df[electrode][:time_limit]+offset, label=electrode)
        offset -= 200
    plt.legend()
    plt.show()

