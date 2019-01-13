$fn=70;

entranceWidth=421;
entranceHeight=21;
entranceDepth=entranceHeight;

module quaterPiece(pinOut,pinIn) {
    
    pieceWidth=entranceWidth/4;
    
    module body() {
        
        translate([0,0,entranceHeight/2]) {
            cube([pieceWidth,entranceDepth,entranceHeight], center=true);
        }
    }

    module pin() {
        translate([0,0,(entranceHeight/2)]) {
            hull() {
                cube([0.1,entranceDepth/2,entranceHeight], center=true);
                translate([4,0,0]) {
                    cube([3,6,entranceHeight], center=true);
                }
            }
        }
    }
    
    difference() {
        union() {
            body();
            if (pinOut == true) {
                translate([-(pieceWidth/2)-5.5,0,0]) {
                    pin();
                }
            }
        }
        
        if (pinIn == true) {
            translate([(pieceWidth/2)-5.5,0,0]) {
                scale([1.03,1.03,1]) {
                    pin();
                }
            }
        }
    }
    
    
    
}

quaterPiece(true, true);

module singleSquare() {
    module hole() {
        translate([0,0,8/2]) {
            cube([8,entranceDepth,8], center=true);
        }
    }
    
    difference() {
        quaterPiece(true, true);
        hole();
    }
}

module singleRound() {
    module hole() {
        translate([0,entranceDepth/2,0]) {
            rotate([90,0,0]) {
                cylinder(d=16, h=entranceDepth);
            }
        }
    }
    
    difference() {
        quaterPiece(true, true);
        hole();
    }
}

module wide() {
    module hole() {
        translate([0,entranceDepth/2,0]) {
            hull() {
                translate([-30,0,0]) rotate([90,0,0]) cylinder(r=entranceHeight/2, h=entranceDepth);
                translate([30,0,0]) rotate([90,0,0]) cylinder(r=entranceHeight/2, h=entranceDepth);
            }
        }
    }
    
    difference() {
        quaterPiece(true, true);
        hole();
    }
}

//wide();
