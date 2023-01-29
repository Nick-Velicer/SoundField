import math
import random

import numpy as np

from PyQt5.QtGui import QColor, QPen
from PyQt5.QtCore import QPointF

import painter
from utils import QColor_HSV, save, Perlin2D

def draw(width, height, color=200, backgroundColor=(0,0,0), perlinFactorW=2, perlinFactorH=2, step=0.001):
    seed = random.randint(0, 100000000)

    # Set the random seed for repeatability
    np.random.seed(seed)

    p = painter.Painter(width, height)

    # Allow smooth drawing
    p.setRenderHint(p.Antialiasing)

    # Draw the background color
    p.fillRect(0, 0, width, height, QColor( *backgroundColor ))

    # Set the pen color
    p.setPen(QPen(QColor(150, 150, 225, 5), 2))
    
    print('Creating Noise...')
    p_noise = Perlin2D(width, height, perlinFactorW, perlinFactorH)
    print('Noise Generated!')

    MAX_LENGTH = 2 * width
    STEP_SIZE = step * max(width, height)
    NUM = int(width * height / 1000)
    POINTS = [(random.randint(0, width - 1), random.randint(0, height - 1)) for i in range(NUM)]

    for k, (x_s, y_s) in enumerate(POINTS):
        print(f'{100 * (k + 1) / len(POINTS):.1f}'.rjust(5) + '% Complete', end='\r')

        # The current line length tracking variable
        c_len = 0

        # Actually draw the flow field
        while c_len < MAX_LENGTH:
            # Set the pen color for this segment
            sat = 200 * (MAX_LENGTH - c_len) / MAX_LENGTH
            # hue = (color + 130 * (height - y_s) / height) % 360
            hue = (color + 50 * (height - y_s) / height) % 360
            p.setPen(QPen(QColor_HSV(hue, sat, 255, 20), 2))

            # angle between -pi and pi
            angle = p_noise[int(x_s), int(y_s)] * math.pi

            # Compute the new point
            x_f = x_s + STEP_SIZE * math.cos(angle)
            y_f = y_s + STEP_SIZE * math.sin(angle)

            # Draw the line
            p.drawLine(QPointF(x_s, y_s), QPointF(x_f, y_f))

            # Update the line length
            c_len += math.sqrt((x_f - x_s) ** 2 + (y_f - y_s) ** 2)

            # Break from the loop if the new point is outside our image bounds
            # or if we've exceeded the line length; otherwise update the point
            if x_f < 0 or x_f >= width or y_f < 0 or y_f >= height or c_len > MAX_LENGTH:
                break
            else:
                x_s, y_s = x_f, y_f

    save(p, fname=f'image_{seed}', folder='Images/', overwrite=True)

draw(3000, 2000, color=63, perlinFactorW=2, perlinFactorH=2, step=0.001)
