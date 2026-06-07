union() {
    translate([0,0,9.5])
        cylinder(r=3.9,h=13,center=true);
    translate([0,0,1.5])
    cylinder(r=6.9, h=3, center=true);
    translate([0,0,-50])
        cylinder(r=9,h=100, center=true);
}