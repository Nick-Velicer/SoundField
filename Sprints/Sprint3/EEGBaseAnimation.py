import pandas
import matplotlib.pyplot as plt
from matplotlib import animation

VISUALIZE = True

RAW_DATA_PATH = '../../Data/GAMEEMO/(S01)/Raw EEG Data/.csv format/S01G1AllRawChannels.csv'
PREPROCESSED_DATA_PATH = '../../Data/GAMEEMO/(S01)/Preprocessed EEG Data/.csv format/S01G1AllChannels.csv'

df = pandas.read_csv(PREPROCESSED_DATA_PATH)

time_frame = 60 * 128 # = 7680
time_series = range(time_frame)
step_size = 128

electrode_names = df.columns[:-1]

fig, ax = plt.subplots(1, 1, figsize = (30, 10))
tx = ax.set_title('Frame 0')

def animate(i):
    ax.cla()
    ax.set_title('Frame {0}'.format(i))
    i = i * step_size
    offset = 0
    time_series = range(i, time_frame + i)
    for electrode in electrode_names:
        ax.plot(time_series, df[electrode][i:time_frame+i]+offset, label=electrode)
        offset -= 200
    ax.axvline(i + (50 * 128), color="red", linestyle="--")
    ax.legend()

anim = animation.FuncAnimation(
    fig, 
    animate, 
    frames = int((len(df) - time_frame) / step_size),
    interval = step_size)
FFwriter = animation.FFMpegWriter(fps=10)
anim.save("EEGBaseAnimation.mp4", writer = FFwriter)
print("EEGBaseAnimation.mp4 has been saved...")
plt.show()