// mitch nelke
// OPENS LAB, Oregon State University
// Water Vapor Limiter and Tube Adapter

// 11.7 changes:
// smaller spicket mouth old version
// removed upper legs on inner support
// added support to mouth

// *buoy rolled too much*

// 11.7.1 changes
// larger, hollowed middle stand
// larger taper at bottom fitting

// 11.7.2 changes
// increased R by 1
// raised buoy more
// middle stand wider at top

// 11.7.3 changes
// modified buoy supports
// separated buoy into separate file for dual extrusion
// fixed leg

// 11.7.4 "12" changes
// recombined buoy and body
// removed buoy supports
// made for dual extrusion

// 12.1 changes
// added back some support for the buoy to orient it during use
// thickened buoy
// added .2mm tolerance to cone socket

// 13.6 changes
// lengthened supports for buoy and adjusted buoy offset accordingly

demo = 0;//set to 0 in order to print the part

$fn = 100; //feature resolution
height = 30; // height of the main body piece. Does not include fitting or midBody
R = 17; // Outer body radius. If this is changed, C should also be changed.
r = R-9; // inner body radius
k = R-2; // outer shell wall thickness
r1 = 4.5; // main hole radius
h = 6; // height of the midBody. Used to add distance between the main chamber and the tube fitting

length = 20+r; // horizontal length of the spicket, not including amount cut off to get a verticle mouth
hLength = length/cos(90-65); // hypotenuse length of the spicket
W = 3.5; // outer radius of the spicket



module body(){
    union(){
        difference(){//main tube body
            cylinder(height,R,R);
            union(){
                cylinder(height,k,k);
                translate([0,0,height-10])difference(){
                    cylinder(8,R+8,R+8);
                    union(){
                        cylinder(8,R-1,R-1);
                        translate([-R-8,-R-16,0])cube([2*R+16,R+16,8]);
                    }
                }
            }
        }

    }
    difference(){//bottom tapered cone socket
        cylinder(5,k,k);
        cylinder(5,r1+.2,r+.2);
    }
    translate([0,0,5]) // taper above cone socket
    difference(){
        cylinder(10,k,k);
        cylinder(10,r+.2,k+.2);
    }
    translate([0,0,height]) // cap
    difference(){
        union(){
            cylinder(6.5,R,r);
            translate([-7,-15,0])cube([14,14,3]);
        }
        cylinder(5,k,r1); // for tapered top when printing
    }

}
v=(7*r/5)-(2*r1/5);

module coney(){
    // hollow cone that floats in the main chamber when water flows into the spicket, but fits into the hole to prevent most water vapor
    
    union(){
    translate([0,0,4.5])//detach from main body by raising above it
    union(){
        difference(){//bottom of buoy
            cylinder(7,r1-.1,v-.1);
            translate([0,0,1])cylinder(6,r1-3,v-3);
        }
        translate([0,0,7])
        difference(){//middle of buoy
            cylinder(height - 18,v-.1,k-3);
            cylinder(height - 18,v-3,k-5);
        }
        translate([0,0,height-11])
        difference(){ //top of buoy
            cylinder(7,k-3,r1+.5);
            cylinder(5,k-5,r1-1);
        }
        translate([0,0,height-2.25])
        for(i = [0:4]){
            translate([0,(-r1-.5) + i*(r1+.5)/2,0])
            cube([2*r1+1,.65,3.5],center=true);
        }
    }
    translate([0,0,2.5])
    union(){
        cylinder(2,r1-1.5,r1-.1);//stand, above fitting

    }
//    translate([0,0,-10-h]) // middle stand
//    difference(){
//        cylinder(9+h,3,2);
//        cylinder(6+h,2,1);
//    }
//    
//    
    translate([0,0,4-h]) // based on the midBody height
        cylinder(h-1,2,r1-1.5);  // thin stand between removeable support in fitting and the floaty cone
}
}

    

module fitting(){ //bottom section of valve, meant for being tapped with a 1/8 NPT bit for a valve-tube coupler.
    difference(){
        difference(){ // taper the bottom of the device
            cylinder(10,R-5,R);
            cylinder(9,4.5,4.5);
        }
        union(){ // cutout the center of the fitting and chamfer the inside edge for easier removal of the inner stand
            cylinder(10,r1+.2,r1+.2);
            cylinder(3,6,r1+.2);
        }
    }
    
}

module midBody(h){//between fitting and main body. Adds space between the two and allows for a smoother transition between the buoy stand between the fitting and the buoy
    translate([0,0,-h-2])
    difference(){
        cylinder(h+2,R,R);
        cylinder(h+2,r1+.2,r1+.2);
    }
}

module support(){ // the foot near the middle of the device to fit against the raincatcher
    difference(){
        union(){ // main piece
            cylinder(4,r,r);
            translate([r,0,0])cylinder(4,r,r);
            translate([-r,0,0])cylinder(4,r,r);
            translate([-2.5,-5,0])cube([5,10,16]);
        }
        union(){ // fit to device and raincatcher
            translate([0,R,0])cylinder(30,R,R);
            translate([0,-R-43,0])cylinder(30,55,55,$fn=200);
        }
    }
}
translate([0,-R,4])support(); // offset by R to place it onto the outside of the valve

module newSpicket(){
z=8;
L=7;
l=6;
difference(){
    union(){
        difference(){ // mouth perimeter
            union(){
                cylinder(z,L,L);
                translate([-L,0,0])cube([2*L,L,z]);
            }
                intersection(){
                    cylinder(z,l,l);
                    translate([-4,-L,0])cube([8,2*L,z]);
                }
        }
        
        //two cylinders to press the raincatcher spout between the cylinders and the bottom of the mouth
        translate([-4,2.25,0])cylinder(z,1,1);
        translate([4,2.25,0])cylinder(z,1,1);
    }
    translate([0,1.5*L,59+z])rotate([90,0,0])cylinder(3*L,60,60,$fn=200);
}
}
module newFitting(){
    for(i = [0:5]){
        translate([4.4* cos(360 * i/6),4.4* sin(360 * i/6),2])
        rotate([0,0,360 * i / 6])
        translate([0,1.25,0])
        rotate([90,0,0])
        linear_extrude(2.5){
        polygon(points=[[-.9,0],[-2,7.5],[-1,10],[1,10],[0,7.5],[1.1,0]]);
    }
    }
//    translate([0,0,2])
//    newFitting2();
    linear_extrude(2){
    difference(){
        circle(8,$fn=30);
        circle(1.5,$fn=30);
    }
    }
    translate([0,0,-2])
    difference(){
        cylinder(2,r1+.2,r1+.2);
        cylinder(2,r1+.2,1.5);
    }
        
}


module newFitting2(){
    difference(){
        rotate_extrude()
        translate([4.15,0,0])
        polygon(points=[[-1,0],[-1.5,6],[.5,6],[1,0]]);
        
        translate([-.5,-10,2])cube([1,20,8]);
    }
        
        
}

module newFitting3(){
    tFit=3.3;
    difference(){
        union(){
            difference(){
                cylinder(9,tFit+4,tFit+4);
                cylinder(9,tFit,tFit);
            }
            translate([0,0,2])
            difference(){
                cylinder(1,tFit,tFit);
                cylinder(1,2.8,2.8);
            }
        }
        union(){
            cube([tFit+4,tFit+4,9]);
            cylinder(1,tFit+4,tFit+4);
        }
    }
    translate([tFit,0,0])cube([4,20,4]);
    translate([0,tFit,5])cube([20,4,4]);
}



//combining and laying out everything
difference(){//for cutting out a corner of the piece if demo=1, for seeing the interior
    union(){//everything inside is the part that should get printed
            union(){//spicket
                translate([0,0,height-4])
                        translate([0,2-R,0])rotate([90,0,0])newSpicket();
                difference(){
                    body();//main body
                    
                    union(){   
                        translate([0,4-k,height-4])
                        rotate([90,0,0])
                        intersection(){
                            cylinder(8,6,6);
                            translate([-4,-7,0])cube([8,2*7,8]);
                        }
                    }
                }
                            
            }
           
        translate([0,0,1])coney();//buoy
       // translate([0,0,-h-2])rotate([180,0,0])newFitting();
        midBody(h);
        translate([0,0,-h-12])fitting();
    }
    if(demo){//corner cutout for demo mode, useful when adding or looking at features
            translate([0,0,-height])cube([R,R,4*height]);//visibility for demo
    }
}


