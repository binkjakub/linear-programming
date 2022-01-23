set jobs;
set tasks {jobs} ordered;

param machine {i in jobs, j in tasks[i]} integer;
param proc_time {i in jobs, j in tasks[i]} >=0;

set collision_index = {i in jobs, j in tasks[i], k in jobs, l in tasks[k]: 
						i<>k and machine[i,j]=machine[k,l]};
						

var end_time >=0;
var start_time {i in jobs, j in tasks[i]} >=0;
var logical_or {collision_index} binary;

minimize makespan: end_time;

subject to preserve_order{i in jobs, j in tasks[i]: ord(j)>1}:
	start_time[i,j] >= start_time[i, prev(j)] + proc_time[i, prev(j)];

subject to avoid_collision{(i,j,k,l) in collision_index}:
	logical_or[i,j,k,l] ==> start_time[i,j] >= start_time[k,l] + proc_time[k,l]  else
							start_time[k,l] >= start_time[i,j] + proc_time[i,j];
	 
subject to makespan_def{i in jobs, j in tasks[i]}:
	end_time >= start_time[i,j] + proc_time[i,j];
