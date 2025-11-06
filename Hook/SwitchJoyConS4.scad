difference() {
    rotate([90,0,0])
    linear_extrude(55)
    polygon([[0,0],[0,2.5],[50,2.5],[50,50],[40,52],[39.5,53],[40.5,53.5],[47,53],[51,52],[52,51],[52,0]]);    

    
    translate([10,-27.5,-1])
    cylinder(r=3,h=4);

    translate([30,-27.5,-1])
    cylinder(r=3,h=4);
    
    
}