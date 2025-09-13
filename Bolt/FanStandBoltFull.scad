include     <../lib/thread/threads-scad.scad>

 ScrewHole (35.5,32,pitch=4.0,tooth_height=2.5, tolerance=0.1,tooth_angle=45)
 difference() {
   union () {
      translate([0,0,18])
      cylinder(r=18.5,h=6.5);  
      cylinder(r=35,h=18);
   }
   union() {
      translate([0,-20,-1]) {
         linear_extrude(8)
         square([70,30],true);
      }
      translate([0,20,-1]) 
         linear_extrude(8){
            square([70,30],true);
         }
   }
 }