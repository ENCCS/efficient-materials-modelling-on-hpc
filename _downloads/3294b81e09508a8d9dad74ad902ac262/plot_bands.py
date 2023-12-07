import numpy as np
import matplotlib.pyplot as plt
import sys


def plot_bands(data1,data2):
    """
    Plot bands (DFT vs GW)
    """
    def get_high_sym_indices(Npts):
        den=3.+np.sqrt(3.)
        x,y,z=[np.sqrt(3.)/den,1./den,2./den]
        return [0,int(x*Npts)-1,int((x+y)*Npts)-1,int(Npts)-1]
    ax = plt.axes()
    ax.set_ylabel("Energy (eV)")
    Spts = get_high_sym_indices(len(data1))
    Svals= [ data1[pt,0] for pt in Spts ]
    ax.set_xticks(Svals)
    ax.set_xticklabels(['G','M','K','G'])
    for v in Svals: ax.axvline(v,c='black')
    Nb = data1.shape[1]-1
    for ib in range(Nb):
        if ib==0:
            ax.plot(data1[:,0],data1[:,ib+1], '-', c='red',label='dft')
            ax.plot(data2[:,0],data2[:,ib+1], '-', c='blue',label='gw')
        else:
            ax.plot(data1[:,0],data1[:,ib+1], '-', c='red')
            ax.plot(data2[:,0],data2[:,ib+1], '-', c='blue')
    plt.legend()
    plt.savefig('gw_bands.png')
    plt.show()

if __name__=="__main__":
    if len(sys.argv)!=4:
        print("Usage: > python plot_bands.py DFT_bands_file GW_bands_file N_b")
        print("with argument being name of interpolated bands file: DFT, GW")
        print("and N_b the bands number")
        exit()

Nb = int(sys.argv[3])
cols = [ i for i in range(Nb+1) ]
dft_bands = np.genfromtxt(sys.argv[1],usecols=(cols))
gw_bands = np.genfromtxt(sys.argv[2],usecols=(cols))
plot_bands(dft_bands,gw_bands)