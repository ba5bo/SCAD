difference(){
    linear_extrude(21)
        union() {
            polygon([[-23,-2],[23,-2],[23,40],[13.5,63],[-13.5,63],[-23,40]]);
            translate([-27,8])
                        circle(d=8);   
            translate([27,8])
                        circle(d=8);   
            polygon([[-27,4],[27,4],[27,12],[-27,12]]);
            polygon([[-22,46],[22,46],[22,54],[-22,54]]);
            translate([-22,50])
                        circle(d=8);   
            translate([22,50])
                        circle(d=8); 
            
        }
    union(){
        translate([0,0,2])
            linear_extrude(17)
                polygon([[-21,0],[21,0],[21,40],[11.5,61],[-11.5,61],[-21,40]]);
        translate([0,0,4.5])
            linear_extrude(6)
                polygon([[-6.5,60],[-6.5,65],[6.5,65],[6.5,60]]);
        translate([0,2,7])
        rotate([90,0,0])
            linear_extrude(10){
                union(){
                    polygon([[-13,9],[13,9],[12,0],[-12,0]]);
                    translate([-17,4.5])
                        circle(d=4.5);    
                    translate([17,4.5])
                        circle(d=4.5);    
                    polygon([[-17,6.75],[17,6.75],[17,2.25],[-17,2.25]]);
                }
            }
            
    }
}