# The demands - read from dat file
param d1;
param d2;
param d3;
# The shortage penalty multiplier - read from dat file
param l1;
param l2;
param l3;
# The cost coefficient for each of the 20 edges - read from dat file
param cost{i in 1..20};
# The flow variable - one for each of the 20 edges
var f{i in 1..20} integer;
# The flow variables from original sinks to super sink
var f1 integer;
var f2 integer;
var f3 integer;

# The optimization objective - first three terms are penalty multiplier * shortage, last term is sum of link costs
minimize COSTS: (l1*(d1-f1)) + (l2*(d2-f2)) + (l3*(d3-f3)) + 
sum{i in 1..20} (f[i]*f[i]*cost[i]);

# Total flow in network is always less than sum of demands 
subject to initflow: (f[1] + f[2]) <= (d1 + d2 + d3);

# capacities of edges between original sinks and super sink
subject to flow1: f1 <= d1;
subject to flow2: f2 <= d2;
subject to flow3: f3 <= d3;

# flow positive constraints for all edges
subject to flowpositive {i in 1..20}: f[i] >= 0;
subject to flowpositive1: f1 >= 0;
subject to flowpositive2: f2 >= 0;
subject to flowpositive3: f3 >= 0;

# flow conservation constraints for all nodes between edges - cs1, bc1, etc. denote nodes from the example in the paper
subject to cs1: f[1] = f[3] + f[4];
subject to cs2: f[2] = f[5] + f[6];
subject to bc1: f[3] + f[5] = f[7];
subject to bc2: f[4] + f[6] = f[8];
subject to cl1: f[7] = f[9];
subject to cl2: f[8] = f[10];
subject to sf1: f[9] = f[11] + f[12];
subject to sf2: f[10] = f[13] + f[14];
subject to dc1: f[11] + f[13] = f[15] + f[16] + f[17];
subject to dc2: f[12] + f[14] = f[18] + f[19] + f[20];

subject to new1: f[15] + f[18] = f1;
subject to new2: f[16] + f[19] = f2;
subject to new3: f[17] + f[20] = f3;