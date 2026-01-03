holer=2.6;
difference(){
    linear_extrude(25)
    difference() {
        square([118,55],true);
        translate([0, 1.5, 0]) {
            square([112,52],true);    
        }
    }
    translate([55,13,12.5])
        hole();

    translate([-60,13,12.5])
        hole();


    translate([-30,0,0])
        roundbar();
    translate([30,0,0])
        roundbar();

}

module roundbar() {
     union(){
            translate([-10,-22,12.5])
        rotate([90,0,0])
            cylinder(7,r=holer);
        translate([10,-22,12.5])
        rotate([90,0,0])
            cylinder(7,r=holer);

        translate([0,-26,12.5])
        cube([20,7,holer*2],true);
    }
}

module hole() {
    rotate([0,90,0])
        cylinder(7,r=holer);
}

