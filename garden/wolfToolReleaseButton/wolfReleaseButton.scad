$fn=100;

module body() {
    $width=16;
    $depth=23;
    $height=15;
    
    module bodyMain() {
        $roundRadius=8;
        
        translate([0,0,$height/2]) {
            intersection() {
                minkowski() {
                    cube([$width-$roundRadius,$depth-$roundRadius, $height], center=true);
                    sphere(r=$roundRadius);
                }
                cube([$width+$roundRadius,$depth+$roundRadius, $height], center=true);
            }
        }
    }
    
    module bodyHollow() {
        translate([-($height/2)+1.5,-($depth/2)+2.5,-5]) {
            minkowski() {
                cube([$width-4,$depth-5, $height-3]);
                sphere(r=4);
            }
        }
    }
    
    module bodyRoundTop() {
        translate([0,0,2.4]) {
            scale([1,1.3,0.7]) {
                sphere(d=($width*2)+4);
            }
        }
    }
    
    
    
    module clipSlots() {
        translate([-$width,4,0]) {
            cube([$width*2,1,$height-9.8]);
        }
        translate([-$width,-4,0]) {
            cube([$width*2,1,$height-9.8]);
        }
    }
    
    
    intersection() {
        difference() {
            bodyMain();
            bodyHollow();
            clipSlots();
        }
        bodyRoundTop();
    }
}

body();
