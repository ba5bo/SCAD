difference(){    

    intersection(){
        translate([8,29,3])
            rotate([90,0,0])
            linear_extrude(30){
                scale([1,6/16])
                    circle(10);     
            };
        linear_extrude(6){
            difference(){
                polygon([[0,0],[0,28],[16,28],[16,0]]);
                polygon([[4,3.5],[4,24.5],[12,24.5],[12,3.5]]);
            }
        };  
    }


    translate([0,0,5])
    linear_extrude(2){
                polygon([[0,2],[0,26],[16,26],[16,2]]);

    };  

    translate([0,0,-1])
     linear_extrude(2){
                polygon([[0,2],[0,26],[16,26],[16,2]]);

    };  
}