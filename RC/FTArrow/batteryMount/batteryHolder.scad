 
batteryWidth=26.5;
batteryHeight=30.5;

strapWidth=22;
strapThickness=2.35;

module fusalage() {
    translate([0,0,37]) {
        rotate([180,0,0]) {
            translate([0,-140.435,0]) {
                // https://www.thingiverse.com/thing:1410967
                #import("ft-arrow-fuse-light.stl");
            }
        }
    }
}

module batteryHolder() {
    
    module body() {
        translate([0,0,(10.5/2)+3]) {
            cube([strapWidth+4,39.9,10.5], center=true);
        }
    }
    
    module batteryCutout() {
        translate([0,0,(batteryHeight/2)]) {
            cube([strapWidth+4+1,batteryWidth,batteryHeight], center=true);
        }
    }
    
    module strapCutout() {
        module verticalCut() {
            translate([0,(batteryWidth/2)+(strapThickness/2)+1.5,(batteryHeight/2)]) {
                cube([strapWidth,strapThickness,batteryHeight], center=true);
            }
        }
        
        verticalCut();
        rotate([0,0,180]) verticalCut();
    }
    
    difference() {
        body();
        strapCutout();
        batteryCutout();
    }
}

difference() {
    translate([-149.3,0,3.95]) batteryHolder();
    fusalage();
}
