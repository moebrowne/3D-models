$fn=80;

feedPipeWall=2;
feedPipeOuterDiameter=25;
feedPipeInnerDiameter=feedPipeOuterDiameter-(feedPipeWall*2);

bendAngle=34;
buttCouplerInnerDiameter=22.5;
buttCouplerEngagementDepth=11.5;

module corner(diameter, angle, bendRadius, legLengthA, legLengthB) {
    
    legLengthB=legLengthB-2.5;
    
    module bend() {
        rotate_extrude(angle=angle,convexity=10) {
            translate([bendRadius,0,0]) {
                circle(d=diameter);
            }
        }
    }
    
    rotate([0,0,-angle]) union() {
        bend();
        rotate([180+(90-angle)+0.05,90,0]) translate([0,-bendRadius,0]) cylinder(d=diameter,h=legLengthA);
        translate([bendRadius,0.05,0]) rotate([90,0,0]) cylinder(d=diameter,h=legLengthB);
    }
}

module bend(angle, outerDiameter, wall) {
    difference() {
        corner(outerDiameter,angle,28,10,buttCouplerEngagementDepth+10);
        corner(outerDiameter-(wall*2),angle,28,10+1,buttCouplerEngagementDepth+10+1);
    }
}


module feedPipeCoupler() {
    
    module body(diameterA, diameterB) {
        translate([0,0,0]) cylinder(d1=diameterA,d2=diameterB,h=10);
        translate([0,0,10]) cylinder(d=diameterB, h=20);
    }
    
    difference() {
        body(buttCouplerInnerDiameter,feedPipeOuterDiameter+(feedPipeWall*2));
        body(buttCouplerInnerDiameter-(feedPipeWall*2),feedPipeOuterDiameter);
    }
}

bend(bendAngle,buttCouplerInnerDiameter,feedPipeWall);
translate([28,10,0]) rotate([-90,90,0]) feedPipeCoupler();