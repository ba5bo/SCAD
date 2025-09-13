difference() {

    linear_extrude(11) {
        square([50.1,24.5],true);
    }
    translate([0,0,-0.5]) {
        linear_extrude(9)
        {
            square([47.1,21.5],true);
        }
    }
}