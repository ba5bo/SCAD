difference(){
    union() {
        translate([0,0,1.5])
        cylinder(r=6.9, h=3, center=true);
        translate([0,0,-50])
            cylinder(r=9,h=100, center=true);
    }
    translate([0,0,-3.5])
        cylinder(r=4,h=14,center=true);
    translate([0,0,-93.5])
        cylinder(r=4,h=14,center=true);
}