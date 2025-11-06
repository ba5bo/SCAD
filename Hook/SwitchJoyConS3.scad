difference() {
    rotate([90,0,0])
    linear_extrude(55)
    polygon([[0,0],[0,2.5],[50,2.5],[50,45],[40,47],[39.5,48],[40.5,48.5],[47,48],[51,47],[52,46],[52,0]]);    

    
    translate([10,-27.5,-1])
    cylinder(r=3,h=4);

    translate([30,-27.5,-1])
    cylinder(r=3,h=4);
    
    
}