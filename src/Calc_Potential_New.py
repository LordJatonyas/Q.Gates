# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import time
from numba import jit
from skimage.io import imread

@jit
def g(u, v, d):
    # g function as defined in Davis7 paper
    R = np.sqrt(u**2 + v**2 + d**2)
    frac = (u * v) / (d * R)
    return (1 / (2 * np.pi)) * np.arctan(frac)

@jit
def finitewire(Vg, rectangle, d, x, y, scale_x, scale_y):

    # Regular spacing
    delta_x = 0.5
    delta_y = 0.5

    # Define corners of rectangle/wire
    T = (rectangle[-1][0] + delta_y) * scale_y
    B = (rectangle[0][0] - delta_y) * scale_y
    L = (rectangle[0][1] - delta_x) * scale_x
    R = (rectangle[-1][1] + delta_x) * scale_x

    # Calculate potential
    phi = Vg * (g(x-B,y-L,d) + g(x-B,R-y,d) + g(T-x,y-L,d) + g(T-x,R-y,d))
    return phi

def orientation(k, y_range, x_range, separation):

    horizontal = 0
    r_max_vert = 0
    # Loop over columns
    for j in range(y_range):
        rectangle = list()
        for i in range(x_range):
            # Detect presence of gate
            if separation[i,j,k] != 1.:
                # Create strip
                rectangle.append([i,j])
        if len(rectangle) != 0:
            horizontal += 1
            rectangle = np.array(rectangle)
            r_max_vert = max(r_max_vert, rectangle.shape[0])
    vertical = 1 * (horizontal <= r_max_vert)
    return vertical

@jit
def calc_pot(rectangle, data, d, Vg, scale_x, scale_y):
    y_range, x_range = data.shape

    # Convert to numpy array
    rectangle = np.array(rectangle)
    # Scale coordinates of rectangle
    rectangle = rectangle #* 1E-9
    #print('Rectangle',j,rectangle.shape)
    # Potential from each strip
    pot_temp = np.zeros(data.shape)
    # For every spatial coordinate
    for i in range(y_range):
        for j in range(x_range):
            x = i * scale_y
            y = j * scale_x
            pot_temp[i,j] = finitewire(Vg, rectangle, d, x, y, scale_x, scale_y)
    return pot_temp


def calc_potential_eachgate(separation, data):
    lx, ly, n_gates = separation.shape
    #print(separation.shape)
    dummy = separation#[int(lx/6):int(5*lx/6),int(ly/6):int(5*ly/6)]
    x_range, y_range = dummy.shape[0], dummy.shape[1]
    #print(dummy.shape)
    # scale in nanometers
    #scale_y = (2298/y_range)
    #scale_x = (1260/x_range)
    """This is scale between SEM image of gates and physical distance ie nanometers"""
    factor = 1
    scale_x_nm = 1.5 * factor #1780/x_range
    scale_y_nm = 1.5 * factor #1242/y_range
    # scale in metres
    scale_x = scale_x_nm * 1E-9
    scale_y = scale_y_nm * 1E-9
    scale = {'x_nm' : scale_x, 'y_nm' : scale_y}
    # Distance from centre of grid point to edge of point
    #delta = 0.5*scale
    #print('\nLength Scale x:\t%e m ' %scale_x)
    #print('Length Scale y:\t%e m \n' %scale_y)

    #Potential
    potential = np.zeros(separation.shape)
    # Voltage (10V)
    Vg = 10000
    # Depth from gates
    d = 10E-9

    # Find optimal scanning direction, rows or columns
    scan_columns = np.zeros(n_gates)
    for k in range(n_gates):
        scan_columns[k] = orientation(k, y_range, x_range, separation)

    #scan_columns = np.ones(n_gates)

    #################################################################
    # Loop over gates
    #################################################################

    def split_rectangles(in_rect, col):
        z = int(not col)
        start = 0
        output = list()
        for i in range(len(in_rect)):
            if i > start and in_rect[i][z] > in_rect[i-1][z] + 1:
                output.append(in_rect[start:i])
                start = i

            if i == len(in_rect) - 1:
                output.append(in_rect[start * (len(output) == 0) : ])

        return output

    gate_list = [9]
    for k in range(n_gates):
        col = scan_columns[k]
        if col==1:
            # Loop over columns
            for j in range(ly):
                rectangle = list()
                for i in range(lx):
                    # Detect presence of gate
                    if separation[i,j,k] != 1.:
                        # Create strip
                        rectangle.append([i,j])

                if len(rectangle)!=0:

                    output = split_rectangles(rectangle,col)

                    for c in range(len(output)):
                        #print(len(output),c,output[c][0],output[c][-1])
                        pot_temp = calc_pot(output[c],data,d,Vg,scale_x,scale_y)
                        potential[:,:,k] = potential[:,:,k] + pot_temp
        else:
            # Loop over rows
            for i in range(lx):
                rectangle = []
                for j in range(ly):
                    # Detect presence of gate
                    if separation[i,j,k]!=1.:
                        # Create strip
                        rectangle.append([i,j])

                if len(rectangle)!=0:
                    output = split_rectangles(rectangle,col)
                    for c in range(len(output)):
                        #print(output)
                        #print(len(output),c,output[c][0], output[c][-1])
                        pot_temp = calc_pot(output[c],data,d,Vg,scale_x,scale_y)
                        potential[:,:,k] = potential[:,:,k] + pot_temp
    
    return potential

def calc_separation(data):
    # Define ranges - x and y are inverted
    x_range = data.shape[0]
    print('Vertical Points:\t%d' %x_range)
    y_range = data.shape[1]
    print('Horizontal Points:\t%d' %y_range)

    # Count number of gates
    colorwave = np.unique(data)
    n_gates = len(colorwave)-1
    colortogate = np.arange(1,n_gates+1)
    print('Number of Gates:\t%d' %n_gates)
    for i in range(n_gates):
        if colorwave[i]==1.:
            colortogate[i]=0
     # Create array to hold one gate in each layer
    separation = np.ones((x_range,y_range,n_gates))
    # Add each gate to a layer of separation
    for k in range(n_gates):
        for i in range(separation.shape[0]):
            for j in range(separation.shape[1]):
                if data[i][j]==colorwave[k]:
                    separation[i,j,k]=data[i][j]
    return separation, n_gates

def load_gates():
    SEM_c = True
    SEM = ""
    if SEM_c:
        SEM = "../gate_images/SEM_"
    else:
        SEM = ""
    img0 = np.where(imread(SEM+"gate_0.png")[:,:,3] > 50, 255, 0)
    img1 = np.where(imread(SEM+"gate_1.png")[:,:,3] > 50, 255, 0)
    img2 = np.where(imread(SEM+"gate_2.png")[:,:,3] > 50, 255, 0)
    img3 = np.where(imread(SEM+"gate_3.png")[:,:,3] > 50, 255, 0)
    img4 = np.where(imread(SEM+"gate_4.png")[:,:,3] > 50, 255, 0)
    img5 = np.where(imread(SEM+"gate_5.png")[:,:,3] > 50, 255, 0)
    img6 = np.where(imread(SEM+"gate_6.png")[:,:,3] > 50, 255, 0)
    img7 = np.where(imread(SEM+"gate_7.png")[:,:,3] > 50, 255, 0)
    img8 = np.where(imread(SEM+"gate_8.png")[:,:,3] > 50, 255, 0)
    img9 = np.where(imread(SEM+"gate_9.png")[:,:,3] > 50, 255, 0)

    gates_design = np.array([img0, img1, img2, img3, img4, img5, img6, img7, img8, img9])

    lx = gates_design.shape[1]
    ly = gates_design.shape[2]

    gates_design = gates_design[:, int(lx/6):int(5*lx/6), int(ly/6):int(5*ly/6)]

    l_1 = int(gates_design.shape[1] * 0.5 / 12)
    h_1 = int(gates_design.shape[1] * 12 / 12)
    l_2 = int(gates_design.shape[2] * 2.5 / 10)
    h_2 = int(gates_design.shape[2] * 8 / 10)

    gates_design = gates_design[:, l_1:h_1, l_2:h_2]
    gates_design = gates_design[:, ::2, ::2]

    return gates_design

def main():
    print('Preprocess')
    separation = load_gates()
    separation = np.moveaxis(separation,0,-1)
    separation = np.abs(separation - np.ones_like(separation))

    data = np.sum(separation,axis=2)

    potential = calc_potential_eachgate(separation, data)
    print(potential)

if __name__ == '__main__':
    main()
