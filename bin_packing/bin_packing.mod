param M integer;
param num_items integer >0;
param num_bins integer >0 = num_items;	
param bin_capacity integer >0;

param item_sizes {1..num_items} >0;


var bin_used {j in 1..num_bins} binary;
var bin_assignment {i in 1..num_items, j in 1..num_bins} binary;
minimize objective: sum {j in 1..num_bins} bin_used[j];

subject to one_bin_per_item{i in 1..num_items}:
	 sum {j in 1..num_bins} bin_assignment[i,j] = 1;

subject to max_capacity{j in 1..num_bins}:
	sum {i in 1..num_items} item_sizes[i]*bin_assignment[i,j] <= bin_capacity;

subject to no_free_items{j in 1..num_bins}:
	sum{i in 1..num_items} bin_assignment[i, j] <= M*bin_used[j];
