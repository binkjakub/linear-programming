reset;

set cities;
set links within (cities cross cities);
param num_cities integer >0 = card(cities);
param start_city symbolic in cities;
param cost {links} >=0;

var arc_chosen {links} binary;
var city_pos {cities} integer >=1;

minimize total_cost: 
	sum{(i, j) in links} cost[i, j] * arc_chosen[i, j];

subject to city_as_source_single_visit{i in cities}:
	sum {j in cities: (i, j) in links} arc_chosen[i, j] = 1;
	
subject to city_as_dest_single_visit{j in cities}:
	sum {i in cities: (i, j) in links} arc_chosen[i, j] = 1;
	
subject to constraint_3{(i, j) in links: i <> start_city and j <> start_city}:
	(city_pos[i] - city_pos[j] + 1) <= ((num_cities - 1) * (1 - arc_chosen[i, j]));

subject to starting_point:
	city_pos[start_city] = 1;
	
subject to city_pos_in_range{i in cities: i <> start_city}:
	2 <= city_pos[i] <= num_cities;


# ------------------------------
data;
set cities := c1 c2 c3 c4 c5;
set links := (c1, c2) (c1, c4) (c1, c5) (c2, c3) (c2, c4) (c3, c5) (c4, c3) (c5, c4) (c5, c1) (c3, c1);

param start_city := c1;
param:  	cost := 
	c1 c2	10 
	c1 c4	50 
	c1 c5	70 
	c2 c3	25 
	c2 c4	20 
	c3 c5	3 
	c4 c3	16 
	c5 c4	13
	c5 c1	10
	c3 c1	5;

solve;
display _total_solve_elapsed_time;
display city_pos;