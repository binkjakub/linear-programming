# implementation for full adjacency cost matrix (tsp.mod implements for valid links only)

param num_cities integer >0;
set cities = {1..num_cities};
set links within (cities cross cities) = cities cross cities;

param start_city in cities integer default 1;
param cost {links} >=0 default 1e+08;

var arc_chosen {links} binary;
var city_pos {cities} integer >=1;

minimize total_cost: 
	sum{(i, j) in links: cost[i,j]} cost[i, j] * arc_chosen[i, j];

subject to city_as_source_single_visit{i in cities}:
	sum {j in cities: (i, j) in links} arc_chosen[i, j] = 1;
	
subject to city_as_dest_single_visit{j in cities}:
	sum {i in cities: (i, j) in links} arc_chosen[i, j] = 1;
	
subject to subtour_constraint{(i, j) in links: i <> start_city and j <> start_city}:
	(city_pos[i] - city_pos[j] + 1) <= ((num_cities - 1) * (1 - arc_chosen[i, j]));

subject to starting_point:
	city_pos[start_city] = 1;
	
subject to city_pos_in_range{i in cities: i <> start_city}:
	2 <= city_pos[i] <= num_cities;