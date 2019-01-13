$fn=70;
capDiameter=13.2;
capHeight=21;

headerHeight=capHeight/4;
padding=2;
rows=3;
columns=2;


module holder() {
    
    module body() {
        translate([0,0,((capHeight+headerHeight+padding)/2)]) {
            cube([capDiameter+padding,capDiameter+padding,capHeight+headerHeight+padding], center=true);
        }
    }
    
    module capHole() {
        translate([0,0,padding]) {
            cylinder(d=capDiameter,h=capHeight+20);
        }
    }
    
    difference() {
        body();
        capHole();
    }
}

module wireCutouts() {
    for (rowI=[0:rows-1]) {
        translate([(rowI*(capDiameter+padding))+(-capDiameter/4),(-capDiameter/4),0]) {
            cube([capDiameter/2, ((capDiameter+padding)*(columns))-(capDiameter/2)-padding, headerHeight]);
        }
    }
    
    for (columnI=[0:columns-1]) {
        translate([(-capDiameter/4),(columnI*(capDiameter+padding))+(-capDiameter/4),0]) {
            cube([((capDiameter+padding)*(rows))-(capDiameter/2)-padding, capDiameter/2, headerHeight]);
        }
    }
    
    translate([(-capDiameter/1.5),(-capDiameter/4),0]) {
        cube([(capDiameter+padding)-(capDiameter/2)-padding, capDiameter/2, headerHeight]);
    }
    
    translate([(-capDiameter/1.5),(capDiameter+padding)*(columns-1)-(capDiameter/4),0]) {
        cube([(capDiameter+padding)-(capDiameter/2)-padding, (capDiameter/2), headerHeight]);
    }
}

module holderSet() {
    for (rowI=[0:rows-1]) {
        for (columnI=[0:columns-1]) {
            translate([(rowI*(capDiameter+padding)),(columnI*(capDiameter+padding)),0]) {
                holder();
            }
        }
    }
}


module holderSetCorners() {
    cornerRadius=capDiameter/2;
    cornerDiameter=capDiameter;
    
    translate([cornerRadius-((capDiameter+padding)/2),cornerRadius-((capDiameter+padding)/2),0]) {
        linear_extrude(height=capHeight+padding+headerHeight) {
            minkowski() {
                square([(rows*(capDiameter+padding))-cornerDiameter,(columns*(capDiameter+padding))-cornerDiameter]);
                circle(r=cornerRadius);
            }
        }
    }
}

module holderSquare() {
    difference() {
        holderSet();
        
        translate([0,0,capHeight+padding]) wireCutouts();
    }
}

module holderRounded() {
    intersection() {
        holderSquare();
        holderSetCorners();
    }
}

holderRounded();
