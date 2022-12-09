"""
Script used to parse the timings at the end of
Yambo reports file.

Usage: parse_ytimings.py head_calc_dir
head_calc_dir = first characters of the names of directories containing reports

Output:
- scaling plots
"""
from glob import glob
import sys

def parse_timing_data(separator1=" : ",separator2 ="s P",separator3 = "s C",separator4 = "m-"):
    """
    Read timing sections of a list of report files
    """
    # Get report files
    n_runs    = len(glob(sys.argv[1]+'*.out'))
    reports   = glob(sys.argv[1]+'*/r-*')
    n_reports = len(reports)
    if n_reports != n_runs:
        raise ValueError("[ERR] report (%d) and run (%d) numbers are different"%(n_reports,n_runs))
    # Produce a dictionary for each output
    # Key: timing section name, Value: timing in seconds
    time_dicts = []
    n_tasks = []
    for report in reports:
        with open(report) as r:
            lines = r.readlines()
        # Find Timing Overview in the report
        for il,line in enumerate(lines):
            if "Threads total" in line: n_tasks.append(int(line.split(":")[1].strip()))
            if "Timing Overview" in line: l0 = il
            if "Memory Overview" in line: l1 = il
        lines=lines[l0:l1]
        time_dict = {}
        for line in lines:
            if separator1 in line:
                aux   = line.split(separator1)
                key   = aux[0].strip()
                # Use separator2 for parallel runs, separator3 for serial
                if separator2 in aux[1]: value = aux[1].split(separator2)[0].strip()
                if separator3 in aux[1]: value = aux[1].split(separator3)[0].strip()
                # Convert in seconds if minutes format found
                if separator4 in value: value = float(value.split(separator4)[0])*60.+\
                                                float(value.split(separator4)[1])
                else:                   value = float(value)
                time_dict[key]=value
        time_dicts.append(time_dict)
    # Last check
    n_dicts = len(time_dicts)
    if n_dicts!=n_reports:
        raise ValueError("[ERR] Parsing problem (number of dicts. %d different from number of reports %d)"%(n_dicts,n_reports))
    return n_tasks,time_dicts

def get_global_time(separator1="m-"):
    """
    Read global time (MAX) from list of report files
    """
    # Get report files
    n_runs    = len(glob(sys.argv[1]+'*.out'))
    reports   = glob(sys.argv[1]+'*/r-*')
    n_reports = len(reports)
    if n_reports != n_runs:
        raise ValueError("[ERR] report and run number are different: ",n_reports,n_runs)
    time_total = []
    for report in reports:
        with open(report) as r:
            lines = r.readlines()
        for line in lines:
            if "[Time-Profile]" in line:
                time= line.split(':')[1].strip('s\n')
                if separator1 in time: time = float(time.split(separator1)[0])*60.+\
                                              float(time.split(separator1)[1])
                else:                  time = float(time)
                time_total.append(time)
                break
    n_times = len(time_total)
    if n_times!=n_reports:
        raise ValueError("[ERR] Parsing problem (number of times %d different from number of reports %d)"%(n_times,n_reports))
    return time_total

def plot_scaling(n_tasks,time_total):
    """
    Plot scaling figure: times (s) vs n_tasks
    """
    import matplotlib.pyplot as plt
    import numpy as np
    n_tasks  = np.array(n_tasks)
    time_total = np.array(time_total)
    x = sorted(n_tasks)
    y = time_total[np.argsort(n_tasks)]
    plt.xticks(x)
    plt.xlabel("N tasks")
    plt.ylabel("Time (s)")
    plt.plot(x,y, '.-', c='teal',markersize=10)
    plt.savefig('gw_scaling.png')
    #plt.show()

if __name__=="__main__":
    if len(sys.argv)!=2:
        print("Usage: > python parse_ytimings.py header_dir")
        print("with argument being head chars of report directory i.e. 'header_dir'='run_MPI'")
        exit()

    n_tasks, time_dicts = parse_timing_data()
    time_total = get_global_time()
    plot_scaling(n_tasks,time_total)