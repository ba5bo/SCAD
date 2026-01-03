include <../../lib/chamfer/Chamfer.scad>
lat=30.5;

difference(){
    translate([0,65,2])
        cube([120,100,12],true);
    translate([0,20,0])
        rotate([0,90-lat,90])
            pinAndSurface();
}
translate([-30,-30,0])
pin();

module pin(){
    chamferCylinder(h=150,5,1);
}

translate([-200,-200,0])
    pinAndSurface();


translate([-100,-100])
    surface();

module pinAndSurface(){
    union(){
        pin();
        translate([0,0,80])
        surface();
    }
}

module surface() {
    difference(){
        cylinder(r=40,h=3);
        translate([0,0,9])
            degrees();
        translate([0,0,-6])
            degrees();
    }
}

module degrees(){
        union()
        {
            for(a=[0:1:11]) {
                rotate([0,0,-a*30])
                {
                    union() {
                        degree();
                        translate([1,29,-6.5])
                        linear_extrude(13){
                            text(str(a*2),size=6);
                        }
                    }
                }
            }
        }

}
module degree(){
    cube([90,0.5,13],true);
}

translate([50,-50,-80])
difference(){
        translate([0,0,80])
        surface();
        pin();
    }