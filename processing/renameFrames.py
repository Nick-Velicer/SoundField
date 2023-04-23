import os

imageDir = "genArtProg/frames/"
ext = ".png"

files = os.listdir(imageDir)
files.sort()

for file in files:
    if (not file.endswith(ext)):
        continue
    filename = file.split(".")[0]
    print(str(int(filename)+1).zfill(5) + ".png")
    newfn = str(int(filename)+1).zfill(5) + ".png"
    oldfp = imageDir + file
    newfp = imageDir + newfn
    os.rename(oldfp, newfp)