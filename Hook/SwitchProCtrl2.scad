difference() {
    rotate([90,0,0])
    linear_extrude(30)
    polygon([[0,0],[0,2.5],[50,2.5],[50,20.5],[40,22.5],[39.5,23.5],[40.5,24],[47,23.5],[51,22.5],[52,21.5],[52,0]]);    

    
    translate([10,-15,-1])
    cylinder(r=3,h=4);

    translate([30,-15,-1])
    cylinder(r=3,h=4);
    
    
}