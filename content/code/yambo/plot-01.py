import numpy as np
import matplotlib.pyplot as plt

list_of_bands = [20,40,60,80]

list_of_data = []
for bands in list_of_bands:
 data = np.loadtxt(f'summary_01_{bands}bands.txt',comments='NGs')
 list_of_data.append(data)


for bands,data in zip(list_of_bands,list_of_data):
 X=data[:,0]
 Y=data[:,2]-data[:,1]
 plt.plot(X,Y,marker='.',label=f'{bands}_bands')

plt.ylabel('Direct Gap [eV]')
plt.xlabel('NGsBlkXp [Ry]')
plt.legend()
plt.savefig('fig-01.png')