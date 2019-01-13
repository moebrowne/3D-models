$fn=100;

module body() {
    cylinder(d2=63, d1=60, h=15);
}

module bodyHole() {
    cylinder(d2=59, d1=56, h=15);
}

module lidTop() {
    intersection() {
        translate([0,0,15]) {
            cylinder(d=75, h=5);
        }
        translate([0,0,-(150/2)+25]) {
            sphere(d=150);
        }
    }
}

module lidTopFitted() {

    difference() {
        lidTop();
        
        $radius=220;
        $difference = 16;
        
        translate([-50,0,-($radius-$difference)]) {
            rotate([0,90,0]) {
                translate() {
                    cylinder(r=$radius, h=100);
                }
            }
        }
    }
}

module lidTopRounded() {
    minkowski() {
        lidTop();
        sphere(r=2);
    }
}
//lidTopRounded();

module handle() {
    translate([0,3,20]) {
        rotate([90,0,0]) {
            scale([1.2,1,1]) {
                cylinder(r=17, h=6);
            }
        }
    }
}

module bodyFull() {
    difference() {
        union() {
            body();
            lidTopRounded();
            handle();
        }
        bodyHole();
    }
}

bodyFull();