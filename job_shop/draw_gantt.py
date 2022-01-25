import plotly.express as px
import pandas as pd


# indexed as (i_job, j_task)
start_times = [
    [267,   363,   461,   555,   654,   774,   863,   940,   1056,   1142],
    [0,    72,   171,   355,   430,   719,   903,   995,   1077,   1171],
    [0,    83,   144,   230,   397,   469,   772,   850,    949,   1065],
    [0,    94,   457,   527,   626,   686,   761,   827,    940,   1167],
    [0,    98,   186,   268,   363,   524,   591,   686,    850,   1148],
    [0,   186,   267,   331,   524,   604,   703,   798,    860,   1146],
    [94,   144,   430,   527,   624,   785,   883,   949,   1048,   1100],
    [0,    98,   171,   253,   304,   375,   477,   562,    624,    719],
    [0,   240,   311,   392,   518,   684,   774,   850,    908,   1003],
    [1253,   303,   375,   457,   562,   618,   761,   935,   1079,   1138],
]

proc_times = [
    [88,   68,   94,   99,   67,   89,   77,   99,   86,   92],
    [72,   50,   69,   75,   94,   66,   92,   82,   94,   63],
    [83,   61,   83,   65,   64,   85,   78,   85,   55,   77],
    [94,   68,   61,   99,   54,   75,   66,   76,   63,   67],
    [69,   88,   82,   95,   99,   67,   95,   68,   67,   86],
    [99,   81,   64,   66,   80,   80,   69,   62,   79,   88],
    [50,   86,   97,   96,   95,   97,   66,   99,   52,   71],
    [98,   73,   82,   51,   71,   94,   85,   62,   95,   79],
    [94,   71,   81,   85,   66,   90,   76,   58,   93,   97],
    [50,   59,   82,   67,   56,   96,   58,   81,   59,   96],
]

machines = [
    [4,   8,   6,   5,   1,   2,   9,   7,   0,   3],
    [5,   3,   6,   4,   2,   8,   0,   1,   7,   9],
    [9,   8,   0,   1,   6,   5,   7,   4,   2,   3],
    [7,   2,   1,   4,   3,   6,   5,   0,   9,   8],
    [3,   4,   9,   8,   0,   2,   6,   5,   7,   1],
    [1,   4,   5,   6,   8,   2,   7,   9,   3,   0],
    [7,   1,   4,   3,   0,   8,   2,   5,   6,   9],
    [4,   6,   3,   2,   1,   5,   7,   0,   8,   9],
    [0,   6,   3,   7,   1,   2,   4,   5,   8,   9],
    [3,   0,   1,   8,   7,   9,   6,   4,   5,   2],
]


plot_data = []
for i, job_info in enumerate(zip(start_times, proc_times, machines), start=1):
    for j, (j_start_time, j_proc_time, j_machine) in enumerate(zip(*job_info), start=1):
        plot_data.append(
            dict(job=str(i), task=str(j), machine=j_machine, start=j_start_time, finish=(
                j_start_time + j_proc_time), name=str((i, j)), proc_time=j_proc_time)
        )

plot_data = pd.DataFrame(plot_data)

fig = px.timeline(plot_data, x_start='start', x_end='finish', y='machine',
                  color='job', hover_data=['name', 'proc_time'], height=600)


fig.update_traces(mode='lines', line_color='black', selector=dict(fill='toself'))
# Allows for plotting integer-indexed data instead of datetime

fig.layout.xaxis.type = 'linear'
for i in range(len(fig.data)):
    row_filter = plot_data['job'].astype(str) == fig.data[i].name
    fig.data[i].x = plot_data.loc[row_filter, 'proc_time'].tolist()

fig.show()
