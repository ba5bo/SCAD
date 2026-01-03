include <../lib/chamfer/Chamfer.scad>;
holeR=2.6;
holeH=7;
holeL=20;
barH=25;
difference(){
    translate([0,0,-barH/2])
    linear_extrude(barH)
    difference() {
        square([118,55],true);
        translate([0, 1.5, 0]) {
            square([112,52],true);    
        }
    }
    translate([55,13])
        hole();
    translate([-60,13])
        hole();
    translate([-30,-28,0])
        roundbar();
    translate([30,-28,0])
        roundbar();

}
translate([0,-28,0])
    roundbar();

translate([0,0,0])
    roundbar();
module roundbar() {
    translate([0,0,0])
    rotate([-90,0,0])
     union(){
        translate([-holeL/2,0,0])
        chamferCylinder(holeH,holeR,holeR+holeH);
        translate([holeL/2,0,0])
        chamferCylinder(holeH,holeR,holeR+holeH);
        translate([0,0,10])
        translate([-holeL/2-holeR/2,-holeR,0])
            chamferCube([holeL+holeR,holeR*2,holeH],[[10,10,10],[0,0,0],[0,0,0]]);

    }
}

module hole() {
    rotate([0,90,0])
        cylinder(holeH,r=holeR);
}

