module ramp() {
    module topRow() {
        translate([0,0,0]) cube([1,1,0.01]);
        translate([100,0,0]) cube([1,1,1.7]);
        translate([200,0,0]) cube([1,1,4.8]);
        translate([300,0,0]) cube([1,1,6.6]);
        translate([400,0,0]) cube([1,1,9.1]);
        translate([500,0,0]) cube([1,1,9.6]);
        translate([600,0,0]) cube([1,1,12.4]);
        translate([700,0,0]) cube([1,1,13.4]);
        translate([770,0,0]) cube([1,1,15]);
    }

    hull() {
        translate([-1,242-2,0]) topRow();
        cube([770,1,2.8]);
    }
}

ramp();

//intersection() {
//    translate([121*0,121*1,0])cube([121,121,121]);
//    ramp();
//}