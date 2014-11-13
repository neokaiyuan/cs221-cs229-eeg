#!/usr/bin/python

import sys, math
from matplotlib.mlab import PCA
import numpy as np
from matplotlib import pyplot as plt
import scipy.io


def main():
    matCont = scipy.io.loadmat('Dog_5_interictal_segment_0001.mat')
    vals = matCont['interictal_segment_1']
    struct = vals[0,0]
    data = struct[0]
    data_length_sec = struct[1]
    sampling_frequency = struct[2]
    channels = struct[3]
    sequence = struct[4]

    print data
    print data_length_sec
    print sampling_frequency
    print channels
    print sequence

    print data[0][0]

if __name__=="__main__":
    main()