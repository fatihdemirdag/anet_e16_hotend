//translate([21.66, 1.4, 0.0]) import("C:/Users/fatih/Desktop/anet_e16_fan_duct.stl");

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// UTILITY MODULES /////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module curved_corner_2D(a, h, cx=1.0, cy=0.0, fn=32, type=0) 
{
    if (type == 0)
    {
        difference()
        {
            cube([a, a, h]);
            translate([cx * a, cy * a, -1.0]) cylinder(h + 2.0, a, a, $fn=fn);
        }
    } else {
        difference()
        {
            cube([a, a, h]);
            difference()
            {
                translate([-0.1, -0.1, -0.1]) cube([a+0.2, a+0.2, h+0.2]);
                translate([cx * a, cy * a, -0.1]) cylinder(h + 0.2, a, a, $fn=fn);
            }
        }
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Mount Part //////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module mountPart()
{
    // mount part base 
    difference() // lower left
    {
            difference()
            {
                translate([-20.0, -6.0, 0.0]) cube([38.0, 12.0, 8.0]);
                // corner cutter
                translate([15.0, -6.0, 0.0]) curved_corner_2D(a=3.0, h=8.0, cx=0.0, cy=1.0, fn=64);
            }
        // leftmost screw hole
        union()
        {
            translate([0.0, 0.0, -1.0]) cylinder(20.0, 1.6, 1.6, $fn=32); 
            translate([0.0, 0.0, 5.0]) cylinder(4.0, 3.0, 3.0, $fn=32); 
        }
    }

    difference() // upper part
    {
        union()
        {
            union()
            {
                translate([12.0, 26.0, 0.0]) cylinder(8.0, 6.0, 6.0, $fn=64);
                translate([6.0, 6.0, 0.0]) cube([12.0, 20.0, 8.0]);
            }
            translate([2.0, 6.0, 0.0]) curved_corner_2D(a=4.0, h=8.0, cx=0.0, cy=1.0, fn=64);
        }
        // upper screw hole
        union()
        {
            translate([12.0, 26.0, -1.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
            translate([12.0, 26.0, 5.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
        }
    }

    // rightmost part (hotend mount part)
    difference()
    {
        difference()
        {
            difference()
            {
                translate([18.0, 1.0, 0.0]) cube([43.7, 12.0, 8.0]);
                // hotend screw hole left
                translate([21.1, 7.0, -1.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
            }
            // hotend screw hole right
            translate([35.6, 7.0, -1.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
        } 
        // screw clearence 
        translate([38.5, 13.2, -1.0]) cylinder(20.0, 4.0, 4.0, $fn=128);
    }

    // center column curves left
    translate([18.0, 13.0, 0.0]) curved_corner_2D(a=3.0, h=8.0, cx=1.0, cy=1.0, fn=64);
    translate([18.0, -2.0, 0.0]) curved_corner_2D(a=3.0, h=8.0, cx=1.0, cy=0.0, fn=64);
    

    // upper part 
    // left mount plate
    difference()
    {
        difference()
        {
            translate([-25.0, -6.0, 0.0]) cube([5.0, 25.0, 12.0]);
            // upper screw hole
            translate([-26.0, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
        }
        // lower screw hole
        translate([-26.0, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
    }
    translate([-30.0, -6.0, 0.0]) cube([5.0, 25.0, 2.0]);
    translate([-20.0, 6.0, 0.0]) curved_corner_2D(a=3.0, h=8.0, cx=1.0, cy=1.0, fn=64);
    //translate([11.05, -4.0, 0.0]) curved_corner_2D(a=3.5, h=20.0, cx=1.0, cy=1.0, fn=64);

    // right mount plate
    difference()
    {
        difference()
        {
            translate([61.7, -6.0, 0.0]) cube([5.0, 25.0, 12.0]);
            translate([60.0, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
        }
        translate([60.0, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
    }
    translate([66.0, -6.0, 0.0]) cube([5.0, 25.0, 2.0]);
    // center column curves right
    translate([57.7, 13.0, 0.0]) curved_corner_2D(a=4.0, h=8.0, cx=0.0, cy=1.0, fn=64);
    translate([57.7, -3.0, 0.0]) curved_corner_2D(a=4.0, h=8.0, cx=0.0, cy=0.0, fn=64);
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Fan Cover Part //////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanCoverPart()
{
    
    // fan cover front
    difference()
    {
        difference()
        {
            translate([-26.0, -20.0, 55.0]) cube([93.7, 70.0, 4.0]);
            translate([20.85, 38.0, 59.0]) linear_extrude(2, center=true, convexity=0, 1.0, slices=1, scale=1.0) text("ANET E-16", 12, "Impact", halign="center", valign="center");
        }
        translate([20.85, 8.0, 54.5]) cylinder(5.0, 16.0, 20.0, $fn=256);
    }
    union()
    {
        // center holders
        union()
        {
            translate([0.85, 8.0, 55.0]) cube([40.0, 2.0, 2.0]); 
            translate([19.85, -12.0, 57.0]) cube([2.0, 40.0, 2.0]);
        }
        // center sphere
        translate([20.85, 8.0, 55.0]) cylinder(4.0, 14.0, 16.0, $fn=256);
    }
        
    // front fan screw holes
    translate([20.85, 8.0, 56.0])
    {
        // fan screw mount hole upper left
        translate([-16.0, -16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.6, 1.6, $fn=32);
        }
        // fan screw mount hole lower left
        translate([-16.0, 16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.6, 1.6, $fn=32);
        }
        // fan screw mount hole upper right
        translate([16.0, -16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.6, 1.6, $fn=32);
        }
        // fan screw mount hole lower right
        translate([16.0, 16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.6, 1.6, $fn=32);
        }
    }
    
    // fan cover left side
    difference()
    {
        difference()
        {
            difference()
            {
                difference()
                {
                    difference()
                    {
                        difference()
                        {
                            translate([-30.0, -20.0, 0.0]) cube([5.0, 70.0, 55.0]);
                            for(y = [0:13])
                            {
                                for(x = [0:7])
                                {
                                    translate([-22.5, -4.0 + x * 4.0 + (y % 2) * 2.0, 24.0 + y * 2.0]) rotate([0.0, -90.0, 0.0]) cylinder(30.0, 1.0, 1.0, $fn=16);
                                }
                            }
                        }
                        translate([-31.0, -6.2, -1.0]) cube([7.0, 25.4, 3.2]);
                    }
                    // upper screw hole
                    translate([-31.0, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
                }
                translate([-31.0, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
            }
            // lower screw hole
            translate([-31.0, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
        }
        translate([-31.0, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
    }
    
    translate([-13.0, -20.0, 8.2]) cube([5.0, 60.0, 46.8]);
    
    // fan cover right side
    difference()
    {
        difference()
        {
            difference()
            {
                difference()
                {
                    difference()
                    {
                        translate([66.7, -20.0, 0.0]) cube([5.0, 70.0, 55.0]);
                        translate([65.7, -6.2, -1.0]) cube([7.0, 25.4, 3.2]);
                    }
                    // upper screw hole
                    translate([65.7, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
                }
                translate([68.7, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
            }
            // lower screw hole
            translate([65.7, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.6, 1.6, $fn=32);
        }
        translate([68.7, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
    }
    
    // fan cover top
    difference()
    {
        difference()
        {
            translate([-26.0, 50.0, 0.0]) cube([93.7, 4.0, 55.0]);
            translate([16.0, 49.0, 7.0]) cube([24.7, 6.0, 16.0]);
        }
        translate([-10.0, 49.0, 7.0]) cube([10.65, 6.0, 20.0]);        
    }
    
    translate([16.0, 50.0, 23.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=1.0, fn=128, type=0);
    translate([36.7, 50.0, 23.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=1.0, fn=128, type=0);
    translate([-10.0, 50.0, 27.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=1.0, fn=128, type=0);
    translate([-3.35, 50.0, 27.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=1.0, fn=128, type=0);
    
    // fan cover smooth edges
    translate([-26.0, 50.0, 59.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=93.7, cx=1.0, cy=0.0, fn=128, type=1);
    translate([-30.0, -20.0, 59.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=70.0, cx=1.0, cy=1.0, fn=128, type=1);
    translate([67.7, -20.0, 59.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=70.0, cx=0.0, cy=1.0, fn=128, type=1);
    
    translate([-30.0, 50.0, 0.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=55.0, cx=1.0, cy=0.0, fn=128, type=1);
    translate([67.7, 50.0, 0.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=55.0, cx=0.0, cy=0.0, fn=128, type=1);
    
    // fan cover down
    translate([-25.0, -20.0, 35.0]) cube([91.7, 4.0, 20.0]);
    difference()
    {
        translate([-25.0, -20.0, 12.2]) cube([12.0, 30.0, 2.0]);
        translate([-17.5, 0.0, 8.0]) rotate([0.0, 0.0, 0.0]) cylinder(10.0, 1.6, 1.6, $fn=32);
    }
    
    // fan cover smooth corners
    intersection()
    {
        intersection()
        {
            translate([-30.0, 50.0, 59.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=1.0, fn=128, type=1);
            translate([-30.0, 50.0, 59.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=0.0, fn=128, type=1);
        }
        translate([-30.0, 50.0, 55.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=0.0, fn=128, type=1);
    }
    
    // fan cover smooth corners
    intersection()
    {
        intersection()
        {
            translate([67.7, 50.0, 59.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=1.0, fn=128, type=1);
            translate([67.7, 50.0, 59.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=0.0, fn=128, type=1);
        }
        translate([67.7, 50.0, 55.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=0.0, fn=128, type=1);
    }
    
    // fan duct
    difference()
    {
        difference()
        {
            translate([-15.0, -25.0, 12.2]) rotate([0.0, 0.0, 65.0]) rotate([90.0, 0.0, 0.0]) linear_extrude(32.0, center=true, scale=0.5) square([10.0, 30.0]);
            translate([-15.0, -25.0, 12.2]) rotate([0.0, 0.0, 65.0]) rotate([90.0, 0.0, 0.0]) linear_extrude(36.0, center=true, scale=0.48) translate([2.0, 2.0, 0.0]) square([6.0, 26.0]);
        }
        translate([-25.0, -15.0, 14.5]) cube([9.9, 40.0, 20.0]);
    }
}





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//mountPart();
fanCoverPart();






// Hotend Placeholders /////////////////////////////////////////////////////////////////////////////////////////////////////
//translate([18.0, -16.0, 8.0]) cube([20.0, 28.0, 12.3]); // hotend heatsink
//translate([18.0, -33.8, 8.0]) cube([20.0, 10.0, 20.0]); // hotend 
//translate([8.35, -23.0, 36.0]) cube([40.0, 40.0, 10.0]); // hotend fan

//translate([-25.0, -15.0, 14.5]) cube([9.9, 40.0, 40.0]); // side fan

