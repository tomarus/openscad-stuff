// Based on Parametric Eurorack Panel by Jonathan Bedrava
// https://www.thingiverse.com/thing:2055716

panelHp = 8;
holeWidth = 6.4;
panelThickness = 2;
panelOuterHeight = 128.5;
hp = 5.08;
mountHoleDiameter = 3.2;

module eurorackPanel()
{
    offset = 7.5 - holeWidth + (holeWidth/2);
    
    difference()
    {
        cube([hp*panelHp,panelOuterHeight,panelThickness]);
        
        translate([offset, panelOuterHeight-3.0, 0])
            eurorackMountHole();
        translate([offset, 3.0, 0])
            eurorackMountHole();
        if (panelHp > 4) {
            translate([offset + ((panelHp-3)*hp), panelOuterHeight-3.0, 0])
                eurorackMountHole();
            translate([offset + ((panelHp-3)*hp), 3.0, 0])
                eurorackMountHole();
        }
    }
}

module eurorackMountHole()
{
    mountHoleRad = mountHoleDiameter/2;
    mountHoleDepth = panelThickness+2;
    
    hwCubeWidth = holeWidth-mountHoleDiameter;
    if(hwCubeWidth<0)
    {
        hwCubeWidth=0;
    }
    
    translate([0,0,-1])
    union()
    {
        cylinder(r=mountHoleRad, h=mountHoleDepth, $fn=20);
        translate([0,-mountHoleRad,0])
            cube([hwCubeWidth, mountHoleDiameter, mountHoleDepth]);
        translate([hwCubeWidth,0,0])
            cylinder(r=mountHoleRad, h=mountHoleDepth, $fn=20);
    }
}

//

h = panelThickness + 2;
w = hp * panelHp;

module Hole(x, y, d) {
    fn = d * 6;
    if (fn < 12) { fn = 12; }
    if (fn > 24) { fn = 24; }
    translate([x,y,-1]) cylinder(d=d, h=h, $fn=fn);
}

module Marker(x, y) {
    Hole(x, y, 0.1);
}

module Midi(x, y) {
    //Marker(x, y);
    Hole(x, y, 16);
}

module Led(x, y) {
    Hole(x, y, 3.2);
}

module Pot(x, y) {
    Hole(x, y, 6.4);
}

module Jack(x, y) {
    Hole(x, y, 6.4);
}

//

projection() translate([0,0,0]) rotate([0,0,0])
difference() {
    eurorackPanel();
    // Led(x,y); Jack(x,y); Pot(x,y); etc..
}
