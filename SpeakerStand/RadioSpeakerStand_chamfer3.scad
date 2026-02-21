include <../lib/chamfer/Chamfer.scad>;
holeR=2.6;
holeH=5;
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

/*translate([0,-28,0])
    roundbar();

translate([0,0,0])
    roundbar();*/

module roundbar() {
    translate([0,0,0])
    rotate([-90,0,0])
     union(){
        for(t=[-holeL/2:holeL/40.0:holeL/2]) 
        {
            translate([t,0,0])
                hole2();
        }
    }
}

module hole2() {
    linear_extrude(holeH,scale=(holeH+holeR)/holeR){
        circle(r=holeR,true,$fn=30);
    }
}
module hole() {
    rotate([0,90,0])
        cylinder(holeH,r=holeR,$fn=30);
}

