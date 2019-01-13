$fn=50;

innerDepth=21.5+1;
innerWidth=126;
innerLength=60;
wallThickness=1;

module box() {

    module shell() {
        module hollow() {
            cube([innerWidth,innerLength,innerDepth+1]);
        }
        
        difference() {
            translate([-wallThickness/2,-wallThickness/2,-wallThickness]) {
                cube([innerWidth+wallThickness,innerLength+wallThickness,innerDepth+wallThickness]);
            }
            hollow();
        }
    }
    
    module mountPosts() {
        clearance=6;
        module mountPost() {
            difference() {
                cylinder(d=6, h=clearance);
                cylinder(d=2.4, h=clearance+1);
                translate([0,0,clearance+4.5]) sphere(d=10);
            }
        }
        
        translate([4,4,0]) mountPost();
        translate([innerWidth-4,4,0]) mountPost();
        translate([4,innerLength-4,0]) mountPost();
        translate([innerWidth-4,innerLength-4,0]) mountPost();
    }
    
    mountPosts();
    shell();
}

module facePlate() {
    module displayHole() {
        displayWidth=71.5;
        displayHeight=24;
        displayDepth=4.5;
        
        translate([9.75,((innerLength-displayHeight)-6.5),-3]) cube([displayWidth,displayHeight,displayDepth]);
    }
    
    module face() {
        translate([-wallThickness/2,-wallThickness/2,-wallThickness]) {
            cube([innerWidth+wallThickness,innerLength+wallThickness,wallThickness]);
        }
        translate([0,0,-wallThickness*1.5]) cube([innerWidth,innerLength,wallThickness/2]);
    }

    module radiationSymbol() {
        translate([15,15,-1]) {
            rotate([0,180,0]) scale([0.05,0.05,0.05]) surface(file="radiation.png", invert=true, center=true);
        }
    }

    
    difference() {
        face();
        displayHole();
        //radiationSymbol();
    }
}

module batteryBox() {
    difference() {
        %cube([innerWidth+(wallThickness),17,15]);
        translate([3,17/2,16/2]) rotate([0,90,0]) cylinder(d=15, h=100);
    }
}

//translate([-wallThickness/2,innerLength+(wallThickness/2),-wallThickness]) batteryBox();

box();
//translate([0,0,innerDepth+wallThickness]) facePlate();



