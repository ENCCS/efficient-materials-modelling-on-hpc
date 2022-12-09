import numpy as np
import matplotlib.pyplot as plt

list_of_files = ['summary_02_noBG.txt']
#list_of_files = ['summary_02_noBG.txt','summary_03_BG.txt']

list_of_data = []
for _file in list_of_files:
 data = np.loadtxt(_file,comments='G b')
 list_of_data.append(data)


for _file,data in zip(list_of_files,list_of_data):
 X=data[:,0]
 Y=data[:,2]-data[:,1]
 _label=_file.split('.')[0].split('_')[2]
 plt.plot(X,Y,marker='.',label=_label)

plt.ylabel('Direct Gap [eV]')
plt.xlabel('G bands')
plt.legend()
plt.savefig('fig-02.png')