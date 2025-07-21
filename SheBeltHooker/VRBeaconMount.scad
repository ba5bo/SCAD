difference(){

    union(){
        translate([0,0,-20])
            linear_extrude(90){
                    polygon([[-70,0],[4,0],[4,150],[50,150],[50,154],[0,170],[0,4],[-70,4]]);
            };
        translate([0,0,-20])    
        linear_extrude(90){
            polygon([[-70,0],[4,0],[4,150],[69,150],[69,154],[0,154],[0,4],[-70,4]]);
        }
    };
        translate([0,0,-40])
        linear_extrude(130){
                polygon([[4,154],[40,154],[4,164]]);
        };
        
}