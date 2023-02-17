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
                translate([-5.0, -6.0, 0.0]) cube([23.0, 12.0, 8.0]);
                // corner cutter
                translate([15.0, -6.0, 0.0]) curved_corner_2D(a=3.0, h=8.0, cx=0.0, cy=1.0, fn=64);
            }
        // leftmost screw hole
        union()
        {
            translate([0.0, 0.0, -1.0]) cylinder(20.0, 1.5, 1.5, $fn=32); 
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
            translate([12.0, 26.0, -1.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
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
                translate([21.1, 7.0, -1.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
            }
            // hotend screw hole right
            translate([35.6, 7.0, -1.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
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
            translate([-10.0, -6.0, 0.0]) cube([5.0, 25.0, 12.0]);
            // upper screw hole
            translate([-11.0, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
        }
        // lower screw hole
        translate([-11.0, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
    }
    translate([-5.0, 6.0, 0.0]) curved_corner_2D(a=3.0, h=8.0, cx=1.0, cy=1.0, fn=64);
    //translate([11.05, -4.0, 0.0]) curved_corner_2D(a=3.5, h=20.0, cx=1.0, cy=1.0, fn=64);

    // right mount plate
    difference()
    {
        difference()
        {
            translate([61.7, -6.0, 0.0]) cube([5.0, 25.0, 12.0]);
            translate([60.0, 3.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
        }
        translate([60.0, 11.0, 6.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.5, 1.5, $fn=32);
    }
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
        translate([7.0, -23.35, 50.0]) cube([56.7, 41.35, 4.0]);
        translate([33.35, -3.0, 49.0]) cylinder(8.0, 10.0, 20.0, $fn=256);
    }
    union()
    {
        // center holders
        union()
        {
            translate([16.35, -4.35, 52.0]) cube([34.0, 2.0, 2.0]); 
            translate([32.35, -20.0, 52.0]) cube([2.0, 34.0, 2.0]);
        }
        // center sphere
        translate([33.35, -3.0, 50.0]) cylinder(4.0, 6.0, 10.0, $fn=256);
    }
        
    // front fan screw holes
    translate([33.35, -3.0, 51.0])
    {
        // fan screw mount hole upper left
        translate([-16.0, -16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.5, 1.5, $fn=32);
        }
        // fan screw mount hole lower left
        translate([-16.0, 16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.5, 1.5, $fn=32);
        }
        // fan screw mount hole upper right
        translate([16.0, -16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.5, 1.5, $fn=32);
        }
        // fan screw mount hole lower right
        translate([16.0, 16.0, -5.0]) difference()
        {
            cylinder(4.0, 4.0, 4.0, $fn=64);
            translate([0.0, 0.0, -1.0]) cylinder(5.0, 1.5, 1.5, $fn=32);
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
                    translate([3.0, -23.35, 8.0]) cube([5.0, 41.35, 42.0]);
                    // upper screw hole
                    translate([3.0, 10.0, 14.0]) rotate([0.0, 90.0, 0.0]) cylinder(10.0, 1.5, 1.5, $fn=32);
                }
                translate([2.0, 10.0, 14.0]) rotate([0.0, 90.0, 0.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
            }
            // lower screw hole
            translate([3.0, 2.0, 14.0]) rotate([0.0, 90.0, 0.0]) cylinder(20.0, 1.5, 1.5, $fn=32);  
        }
        translate([2.0, 2.0, 14.0]) rotate([0.0, 90.0, 0.0]) cylinder(4.0, 3.0, 3.0, $fn=32);
    }
    
    // fan cover right side
    difference()
    {
        difference()
        {
            difference()
            {
                translate([58.7, -23.35, 0.0]) cube([5.0, 41.35, 50.0]);
                translate([57.7, 7.0, 14.0]) rotate([0.0, 90.0, 0.0]) cylinder(8.0, 1.5, 1.5, $fn=32);
            }
            translate([60.7, 7.0, 14.0]) rotate([0.0, 90.0, 0.0]) cylinder(3.5, 3.0, 3.0, $fn=32);
        }
        translate([56.0, 10.0, 3.8]) rotate([0.0, 90.0, 0.0]) cylinder(22.0, 1.4, 1.6, $fn=32);
    }

    difference()
    {
        difference()
        {
            // fan cover top
            translate([7.0, 18.0, 8.0]) cube([56.7, 4.0, 42.0]);
            translate([16.0, 17.0, 7.0]) cube([24.7, 6.0, 16.0]);
        }
        translate([46.0, 17.0, 7.0]) cube([10.65, 6.0, 20.0]);        
    }
    translate([16.0, 18.0, 23.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=1.0, fn=128, type=0);
    translate([36.7, 18.0, 23.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=1.0, fn=128, type=0);
    translate([46.0, 18.0, 27.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=1.0, fn=128, type=0);
    translate([52.65, 18.0, 27.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=1.0, fn=128, type=0);
    
    // fan cover smooth edges
    translate([3.0, -23.35, 54.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=41.35, cx=1.0, cy=1.0, fn=128, type=1);
    translate([8.0, -23.35, 50.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=41.35, cx=1.0, cy=1.0, fn=128, type=0);
    translate([54.65, -23.35, 50.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=41.35, cx=0.0, cy=1.0, fn=128, type=0);
    difference()
    {
        translate([7.0, 18.0, 54.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=60.45, cx=1.0, cy=0.0, fn=128, type=1);
        translate([63.65, 16.0, 48.0]) cube([2.3, 6.0, 4.0]); 
    }
    translate([3.0, 18.0, 8.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=42.0, cx=1.0, cy=0.0, fn=128, type=1);
    
    // fan cover smooth corners
    intersection()
    {
        intersection()
        {
            translate([3.0, 18.0, 54.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=1.0, fn=128, type=1);
            translate([3.0, 18.0, 54.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=0.0, fn=128, type=1);
        }
        translate([3.0, 18.0, 50.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=0.0, fn=128, type=1);
    }
    
    translate([63.65, -23.35, 52.0]) cube([2.3, 41.35, 2.0]);
    translate([65.95, -23.35, 50.0]) cube([1.5, 41.35, 4.0]);
    translate([63.65, -23.35, 0.0]) cube([3.8, 2.0, 52.0]);
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Side Fan Part ///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module sideFanPart()
{
    // side fan front wall
    
    difference()
    {
        union()
        {
            union()
            {
                union()
                {
                    union()
                    {
                        union()
                        {
                            translate([66.0, -22.35, 48.0]) cube([11.5, 44.35, 2.0]);
                            translate([68.0, -24.35, 50.0]) cube([9.5, 42.35, 4.0]);
                        }
                        translate([68.0, 18.0, 54.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=9.5, cx=1.0, cy=0.0, fn=128, type=1);
                    }
                    union()
                    {
                        translate([77.5, -24.35, 54.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=42.35, cx=0.0, cy=1.0, fn=128, type=1);
                        translate([77.5, 18.0, 0.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=50.0, cx=0.0, cy=0.0, fn=128, type=1);
                    }
                }
                
                difference()
                {
                    difference()
                    {
                        difference()
                        {   
                            union()
                            {
                                union()
                                {
                                    // side fan right wall
                                    translate([77.5, -24.35, 0.0]) cube([4.0, 42.35, 50.0]);
                                    // side fan left wall
                                    translate([64.0, -22.35, 0.0]) cube([2.0, 44.5, 51.8]);
                                }
                                // sıde fan back wall
                                translate([66.0, -21.35, 0.0]) cube([11.5, 43.35, 7.0]);
                            }
                            // side screw hole
                            translate([62.0, 10.0, 4.0]) rotate([0.0, 90.0, 0.0]) cylinder(22.0, 1.6, 1.6, $fn=32);
                        }
                        // side screw hole (head)
                        translate([77.0, 10.0, 4.0]) rotate([0.0, 90.0, 0.0]) cylinder(5.0, 3.0, 3.0, $fn=32);
                    }
                    translate([77.0, 0.0, 24.0]) rotate([0.0, 90.0, 0.0]) cylinder(6.0, 16.0, 12.0, $fn=256);
                }
            }
            
            union()
            {
                union() 
                {
                    translate([71.0, -21.85, 50.0]) rotate([90.0, 0.0, 0.0]) cylinder(h = 2.5, r = 3.2, $fn=32);
                    translate([71.0, -21.85, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 2.5, r = 3.2, $fn=32);
                }
                union() 
                {
                    translate([77.5, -21.85, 50.0]) rotate([90.0, 0.0, 0.0]) cylinder(h = 2.5, r = 3.2, $fn=32);
                    translate([77.5, -21.85, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 2.5, r = 3.2, $fn=32);
                }
            }
        }
        
        union()
            {
                union() 
                {
                    translate([71.0, -22.0, 50.0]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.5, r = 2.2, $fn=32);
                    translate([71.0, -22.0, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.5, r = 2.2, $fn=32);
                }
                union() 
                {
                    translate([77.5, -22.0, 50.0]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.5, r = 2.2, $fn=32);
                    translate([77.5, -22.0, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.5, r = 2.2, $fn=32);
                }
            }
    }
       
    // grill
    translate([77.5, -11.0, 8.0]) cube([4.0, 1.6, 32.0]);
    translate([77.5, -7.0, 8.0]) cube([4.0, 1.6, 32.0]);
    translate([77.5, -3.0, 8.0]) cube([4.0, 1.6, 32.0]);
    translate([77.5, 1.0, 8.0]) cube([4.0, 1.6, 32.0]);
    translate([77.5, 5.0, 8.0]) cube([4.0, 1.6, 32.0]);
    translate([77.5, 9.0, 8.0]) cube([4.0, 1.6, 32.0]);
    
    intersection()
    {
        intersection()
        {
            translate([77.5, 18.0, 54.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=1.0, fn=128, type=1);
            translate([77.5, 18.0, 54.0]) rotate([0.0, 90.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=1.0, cy=0.0, fn=128, type=1);
        }
        translate([77.5, 18.0, 50.0]) rotate([0.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=4.0, cx=0.0, cy=0.0, fn=128, type=1);
    }
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Cooling Tunnel Part /////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module coolingTunnelPart()
{
    // cooling tunnel
    
    difference()
    {
        union()
        {
            difference()
            {
                union()
                {
                    difference()
                    {
                        union()
                        {
                            translate([72.0, -21.35, 26.0]) rotate([90.0, 0.0, -56.0])
                                    linear_extrude(height = 18, center = false, convexity = 0.5, twist = 0, slices=2, scale=[0.25, 0.2]) 
                                        square([14.0, 26.0]);
                            mirror([0.0, 0.0, 1.0])
                            translate([72.0, -21.35, -26.0]) rotate([90.0, 0.0, -56.0]) 
                                    linear_extrude(height = 18, center = false, convexity = 0.5, twist = 0, slices=2, scale=[0.25, 0.8]) 
                                        square([14.0, 26.0]);
                        }
                        translate([64.0, -26.0, -2.0]) cube([16.2, 8.0, 56.0]);
                    }
                    translate([64.0, -33.0, 0.0]) cube([13.5, 8.65, 50.0]);
                }
               
                union()
                {
                    union()
                    {
                        translate([72.0, -21.35, 26.0]) rotate([90.0, 0.0, -56.0])
                        translate([1.0, -0.1, -0.1]) 
                        linear_extrude(height = 20, center = false, convexity = 0.5, twist = 0, slices=2, scale=[0.1, 0.1]) 
                            square([10.0, 22.0]);
                       
                        mirror([0.0, 0.0, 1.0])
                        translate([72.0, -21.35, -26.0]) rotate([90.0, 0.0, -56.0]) 
                        translate([1.0, -0.1, -0.1]) 
                        linear_extrude(height = 20, center = false, convexity = 0.5, twist = 0, slices=2, scale=[0.1, 0.8]) 
                            square([10.0, 22.0]);  
                    }
                    translate([68.0, -32.0, 2.0]) cube([10.2, 8.65, 46.0]);
                }
            }
            union()
            {
                union()
                {
                    translate([77.5, -33.0, 0.0]) cube([4.0, 8.65, 50.0]);
                    translate([77.5, -33.0, 54.0]) rotate([-90.0, 0.0, 0.0]) curved_corner_2D(a=4.0, h=8.65, cx=0.0, cy=1.0, fn=128, type=1);
                }
                union()
                {
                    translate([64.0, -33.0, 50.0]) cube([13.5, 8.65, 4.0]);
                    translate([71.0, -24.35, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 8.65, r = 3.5, $fn=32);
                }
            }
        }
        union()
        {
            union() 
            {
                translate([71.0, -23.35, 50.0]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.2, r = 2.2, $fn=32);
                translate([71.0, -23.35, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.2, r = 2.2, $fn=32);
            }
            union() 
            {
                translate([77.5, -23.35, 50.0]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.2, r = 2.2, $fn=32);
                translate([77.5, -23.35, 3.5]) rotate([90.0, 0.0, 0.0]) cylinder(h = 3.2, r = 2.2, $fn=32);
            }
        }
    } 
    
}
    


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mountPart();
//fanCoverPart();
//sideFanPart();
//coolingTunnelPart();


// Hotend Placeholders /////////////////////////////////////////////////////////////////////////////////////////////////////
//translate([18.0, -16.0, 8.0]) cube([20.0, 28.0, 12.3]); // hotend heatsink
//translate([18.0, -33.8, 8.0]) cube([20.0, 10.0, 20.0]); // hotend 
//translate([8.35, -23.0, 36.0]) cube([40.0, 40.0, 10.0]); // hotend fan

//translate([56.0, -21.35, 7.5]) cube([12.0, 40.0, 40.0]); // side fan

