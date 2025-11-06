linear_extrude(16){
    union() {
        difference() {
            polygon([[0,0],[63,0],[63,23],[0,23]]);
            polygon([[0,2],[60,2],[60,21],[0,21]]);
        }
        translate([0,23]) {
            difference(){
                union(){
                    polygon([[0,0],[0,12],[24,12],[24,0]]);
                    translate([12,12]) {
                        circle(12);
                    }
                }
                translate([12,12]) {
                        circle(10);
                }
                polygon([[24,0],[12,2],[12,4],[24,4]]);
            }
        }
    }
}