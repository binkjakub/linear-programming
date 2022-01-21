option solver cplex;
reset;

param M integer;
param num_bins integer >0;	
param bin_capacity integer >0;
set items;
param item_sizes {items} >0;

var bin_used {j in 1..num_bins} binary;
var bin_assignment {i in items, j in 1..num_bins} binary;
minimize objective: sum {j in 1..num_bins} bin_used[j];

# item is packed to only one bin
subject to one_bin_per_item{i in items}:
	 sum {j in 1..num_bins} bin_assignment[i,j] = 1;

# size of all items packed to the i-th bin is at most bin_capacity
subject to capacity{j in 1..num_bins}:
	sum {i in items} item_sizes[i]*bin_assignment[i,j] <= bin_capacity;

# there is no items outside chosen bins
subject to no_items_outside{j in 1..num_bins}:
	sum{i in items} bin_assignment[i, j] <= M*bin_used[j];

# ------------------------------------------------------------------------------------
data;
param M := 100000;
param num_bins := 10;
param bin_capacity := 10;
#set items = {"i1", "i2", "i3", "i4"};
param: items: item_sizes :=
					i1 1
					i2 2
					i3 6
					i4 4
					i5 8
					i6 4
					i7 4;
					
					
solve;
display bin_used;
display bin_assignment;