// Values from https://jcoppens.com/ant/qfh/calc.en.php
// remember to enter the proper bending radius and wire diameter

// Frequency: 1700
// Turns: 0.5
// Length: 1
// Bend: 1
// Wire: 1.5
// W/h: 0.44

// Larger loop
H1=58.2;    // Antenna height, center to center of wire
Di1=24.1;   // Internal diameter
D1=25.6;    // Horizontal separator
Dc1=23.6;   // Compensated horiz. separation
// Smaller loop
H2=55.4;    // Antenna height
Di2=22.8;   // Internal diameter
D2=24.3;    // Horizontal separator
Dc2=22.3;   // Compensated horiz. separator

thickness=1;  // thickness of the support rings
coax=4;       // coax diameter, inside center cylinder
ccyl=8;       // center cylinder diameter
wire=1.5;     // wire diameter
aheight=max(H1,H2)*1.2; // add 20% length to the centre support

// D1 angle compensation for the middle ring
//mcomp=H2/H1*90-90;      // RH - LHCP
mcomp=90-H2/H1*90;      // LH - RHCP

// Note: the former is built upside down due to the top being flat

difference(){
    union(){
        cylinder(aheight, d=ccyl);
        // top ring
        union(){
            rotate([0, 0, 45])
                translate([-ccyl/4, -max(D1,D2)*0.4, 0])
                    cube([ccyl/2, max(D1,D2)*0.8, thickness]);
            rotate([0, 0, 135])
                translate([-ccyl/4, -max(D1,D2)*0.4, 0])
                    cube([ccyl/2, max(D1,D2)*0.8, thickness]);
            difference(){
                cylinder(thickness, d=max(D1,D2));
                translate([0, 0, -1])
                    cylinder(thickness+2, d=max(D1,D2)*0.8);
                rotate([0, 0, 0])
                    translate([Dc1/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 180])
                    translate([Dc1/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 90])
                    translate([Dc2/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 270])
                    translate([Dc2/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
            }
        }

        // middle ring, placed for D2, D1 angle compensated
        translate([0,0,H2/2-thickness/2]){
            union(){
                rotate([0, 0, 45])
                    translate([-ccyl/4, -max(D1,D2)*0.4, 0])
                        cube([ccyl/2, max(D1,D2)*0.8, thickness]);
                rotate([0, 0, 135])
                    translate([-ccyl/4, -max(D1,D2)*0.4, 0])
                        cube([ccyl/2, max(D1,D2)*0.8, thickness]);
                difference(){
                    cylinder(thickness, d=max(D1,D2));
                    translate([0, 0, -1])
                        cylinder(thickness + 2, d=max(D1,D2)*0.8);
                rotate([0, 0, 90+mcomp])
                    translate([Di1/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 270+mcomp])
                    translate([Di1/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 0])
                    translate([Di2/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 180])
                    translate([Di2/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                }
            }
        }

        // bottom ring small
        translate([0,0,H2-thickness]){
            union(){
                rotate([0, 0, 45])
                    translate([-ccyl/4, -max(D1,D2)*0.4, 0])
                        cube([ccyl/2, max(D1,D2)*0.8, thickness]);
                rotate([0, 0, 135])
                    translate([-ccyl/4, -max(D1,D2)*0.4, 0])
                        cube([ccyl/2, max(D1,D2)*0.8, thickness]);
                difference(){
                    cylinder(thickness, d=max(D1,D2));
                    translate([0, 0, -1])
                        cylinder(thickness + 2, d=max(D1,D2)*0.8);
                    rotate([0, 0, 90])
                        translate([Dc2/2, -wire/2, -1])
                            cube([wire*3, wire, thickness+2]);
                    rotate([0, 0, 270])
                        translate([Dc2/2, -wire/2, -1])
                            cube([wire*3, wire, thickness+2]);
                    rotate([0, 0, 135])
                        translate([ccyl/4, ccyl/4, -1])
                            cube([D1/2, D1/2, thickness+2]);
                    rotate([0, 0, 315])
                        translate([ccyl/4, ccyl/4, -1])
                            cube([D1/2, D1/2, thickness+2]);
                }
            }
        }
        
        // link between bottom rings
        translate([0,0,(H1+H2)/2-thickness/2]){
            intersection(){
                difference(){
                    cylinder(H1-H2-thickness, d=max(D1,D2), center = true);
                    translate([0, 0, -1])
                        cylinder(thickness + 2, d=max(D1,D2)*0.8);
                }
                union(){
                    rotate([0, 0, 45])
                        cube([ccyl/2, max(D1, D2), H1-H2-thickness], center = true);
                    rotate([0, 0, 135])
                        cube([ccyl/2, max(D1, D2), H1-H2-thickness], center = true);
                    }
                }
            }

        // bottom ring large
        translate([0,0,H1-thickness]){
            difference(){
                cylinder(thickness, d=max(D1,D2));
                translate([0, 0, -1])
                    cylinder(thickness + 2, d=max(D1,D2)*0.8);
                rotate([0, 0, 0])
                    translate([Dc1/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 180])
                    translate([Dc1/2, -wire/2, -1])
                        cube([wire*3, wire, thickness+2]);
                rotate([0, 0, 45])
                    translate([ccyl/4, ccyl/4, -1])
                        cube([D1/2, D1/2, thickness+2]);
                rotate([0, 0, 225])
                    translate([ccyl/4, ccyl/4, -1])
                        cube([D1/2, D1/2, thickness+2]);
            }
        }
    }
    translate([0, 0, -1])
        cylinder(aheight+2, d=coax);
    translate([-ccyl/2, 0, H1])
        cube([ccyl, ccyl/2, wire]);
    translate([0, -ccyl/2, H2])
        cube([ccyl/2, ccyl, wire]);
    translate([0, 0, H2])
        cube([ccyl/2, ccyl/2, H1-H2+thickness]);
}
