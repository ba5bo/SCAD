
difference () {
    union () {
        linear_extrude(11) {
            circle(d=13);
        }
        linear_extrude(5) {
        square([19,10], true);
        }
    }
    translate([0,0,-1])
    linear_extrude(7) {
        circle(d=6);
    }
}
