use <Charm-Regular.ttf>

$fn=70;
OD=66.75;
OR=OD/2;
ID=63.75;
IR=ID/2;
wall=(OD-ID)/2;

adjustment=0.00;

module body() {
    roundD=3;
    difference() {
        minkowski() {
            linear_extrude(height=5) {
                circle(d=OD+1.5-roundD);
            }
            sphere(d=roundD);
        }
        translate([0,0,-3/2]) cube([100,100,3], center=true);
    }
}

module groove() {
    translate([0,0,-0.1]) {
        difference() {
            translate([0,0,0]) cylinder(d1=66.25+adjustment,d2=ID+(2*wall)+adjustment,h=4);
            //translate([0,0,0-0.5]) cylinder(d1=66.25-(2*wall),d2=ID,h=3+1);
        }
        
    }
}

module label() {
    linear_extrude(height=2) {
        translate([0,0,0]) text("Faenugraecum", size=8.4, font="Charm", valign="baseline", halign="center");
        translate([0,-10,0]) text("Fenugreek", size=4.7, font="Arial", valign="baseline", halign="center");
    }
}

rotate([0,0,0]) {
    difference() {
        body();
        groove();
        translate([0,0,-0.1]) linear_extrude(height=4) circle(d=OD-5);
        translate([0,0,5.5]) label();
    }
//        translate([0,0,4/2]) %cube([OD,1,4], center=true);
//        translate([0,0,4/2]) %cube([1,ID,4], center=true);
}