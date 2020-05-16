$fn=60;

downPipeWall=1.8;
downPipeOuterDiameter=68;
downPipeInnerDiameter=downPipeOuterDiameter-(downPipeWall*2);

feedPipeWall=2;
feedPipeOuterDiameter=25;
feedPipeInnerDiameter=feedPipeOuterDiameter-(feedPipeWall*2);

bodyWall=2;
bodyOuterDiameter=110;
bodyInnerDiameter=bodyOuterDiameter-(bodyWall*2);
bodyHeight=70;
bodyFacets=10;
bodyFacetAngle=(((bodyFacets-2)*180)/bodyFacets);

catcherWall=bodyWall;
catcherOuterDiameter=downPipeOuterDiameter/1.4;
catcherInnerDiameter=catcherOuterDiameter-(catcherWall*2);
catcherHeight=bodyHeight-25;

module body() {
    module skin() {
        difference() {
            cylinder(d=bodyOuterDiameter, h=bodyHeight, $fn=bodyFacets);
            translate([0,0,bodyWall]) cylinder(d=bodyInnerDiameter, h=bodyHeight, $fn=bodyFacets);
        }
    }
    
    module catcher() {
        difference() {
            cylinder(d=catcherOuterDiameter, h=catcherHeight);
            translate([0,0,-1]) cylinder(d=catcherInnerDiameter, h=catcherHeight+2);
        }
    }
    
    module passThroughHole() {
        cylinder(d=catcherInnerDiameter, h=5, center=true);
    }
    
    module connector() {
        height=15;
        translate([0,0,-height]) {
            difference() {
                cylinder(d=downPipeInnerDiameter, h=height);
                translate([0,0,-1]) cylinder(d=downPipeInnerDiameter-(bodyWall*2), h=height+2);
            }
        }
    }
    
    module feed(innerDiameter) {
        downAngle=4;
        length=30;
        
        module tubePositioned() {
            module tube() {
                difference() {
                    cylinder(d=feedPipeInnerDiameter, h=length);
                    translate([0,0,-1]) cylinder(d=innerDiameter-(feedPipeWall*2), h=length+2);
                }
            }
            
            translate([0,(bodyWall*2)-(bodyOuterDiameter/2)+1,(feedPipeOuterDiameter/2)-feedPipeWall+0.5]) rotate([downAngle,0,0]) rotate([90,90,0]) tube();
        }
        
        difference() {
            tubePositioned();
            translate([0,0,1]) rotate([0,0,bodyFacetAngle+90]) cylinder(d=bodyInnerDiameter,h=bodyHeight, $fn=bodyFacets);
        }
    }
    

    difference() {
        union() {
            rotate([0,0,bodyFacetAngle+90]) skin();
            catcher();
        }
        feed(0);
        //translate([0,4,3.5]) scale([0.81,0.81,0.81]) hull() feed();
        passThroughHole();
    }
    
    connector();
    feed(feedPipeInnerDiameter);
    
}


    
module lid() {
    height=10;
    gap=1;
    module skin() {
        difference() {
            cylinder(d=bodyOuterDiameter+(bodyWall*2),h=height, $fn=bodyFacets);
            translate([0,0,-bodyWall]) cylinder(d=bodyOuterDiameter+gap,h=height, $fn=bodyFacets);
        }
    }
    
    module connectorHole() {
        cylinder(d=downPipeOuterDiameter+0.4, h=height+15);
    }
    
    module connectorFlange() {
        wall=2;
        cylinder(d=downPipeOuterDiameter+(wall*2), h=10);
    }
    
    difference() {
        union() {
            skin();    
            connectorFlange();
        }
        translate([0,0,-1]) connectorHole();
    }
    
}

module lidEngagementBumps() {
    for(i=[1:bodyFacets]) {
        rotate(a=[0,0,((bodyFacetAngle/2)*(i/2))], v=[(bodyOuterDiameter/2)-2.65,0,0]) translate([(bodyOuterDiameter/2)-2.3,0,0]) scale([0.3,1,1]) sphere(d=3, $fn=30);
    }
}


translate([0,0,bodyHeight+30]) union() {
    rotate([0,0,bodyFacetAngle+90]) lid();
    translate([0,0,3.5]) lidEngagementBumps();
}

difference() {
    body();
    translate([0,0,bodyHeight-4.5]) lidEngagementBumps();
}


//%translate([0,0,90/2]) cube([downPipeOuterDiameter+45,downPipeOuterDiameter+45,90], center=true);
//%translate([38,32,67]) cube([4,4,3]);
//%translate([38,32,105]) cube([4,4,3]);