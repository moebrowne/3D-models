$fn=60;
spacing=46.5;


module frameLug() {
    cube([22.7,100,9.5], center=true);
}

module rounder() {
    translate([-12,0,0]) rotate([0,0,45]) minkowski() {
        cube([46.2,46.2,20], center=true);
        sphere(d=5);
    }
}

intersection() {
    rounder();
    difference() {
        #cube([spacing,12,11.2], center=true);
        translate([0,0,0]) frameLug();
    }
}