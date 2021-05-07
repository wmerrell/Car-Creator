//
//
//  Customizable Flatcar Creator
//  Will Merrell
//  December 5, 2020
//
//
$fn=36*1;
use <MCAD/regular_shapes.scad>
// preview[view:south, tilt:top]

//
// CUSTOMIZING
//
Scale=1; // [0:Z, 1:N, 2:HO, 3:S, 4:O]

/* [Prototype Car Dimensions] */
Car_Length_in_Feet=49.5;
Car_Width_in_Feet=9.5;
Deck_Height_in_Inches=44.5;

/* [Car Features] */
Side_Sill_Depth_in_Inches=18.0;
Fish_Belly_Depth_in_Inches=35.0;
Fish_Belly_Angle_Length_in_Feet=9.5;
Pockets_per_Side=11;

/* [Layout] */
Space_Between_Deck_and_Body=8;



//
// REMAINING PARAMETERS
//

//
//
scale=[220, 160, 87, 64, 48][Scale];
echo(Scale=Scale,scale=scale);
car_length=scaler(Car_Length_in_Feet*12);
car_width=scaler(Car_Width_in_Feet*12);
echo(car_length=car_length,car_width=car_width);

deck_height=scaler(Deck_Height_in_Inches);
deck_thickness=[0.3, 0.5, 0.75, 1.1, 1.6][Scale];

bolster_length=[2.5, 3.8, 5.2, 8.1, 10.6][Scale];
bolster_width=car_width*1;
bolster_depth=[1.5, 2.8, 4.2, 6.1, 8.5][Scale];
bolster_setback=[5.2, 10.0, 16.5, 20, 30][Scale];
bolster_pin_radius=[0.75, 1.1, 1.8, 2.1, 2.4][Scale];

weight_width=[5, 12, 25, 20, 40][Scale];
weight_depth=[0.3, 0.7, 1, 2, 3][Scale];
weight_length=car_length-((bolster_setback*2)+bolster_length*2);

center_sill_length=car_length-((bolster_setback+bolster_length)*2);
center_sill_Xpos=bolster_setback+bolster_length;
center_sill_width=[2.5, 3.5, 5.2, 7, 10][Scale];
center_sill_lo_depth=[1.5, 2, 3.8, 5, 7.8][Scale];
center_sill_hi_depth=scaler(Fish_Belly_Depth_in_Inches);
center_sill_thickness=[0.8, 1, 1.8, 2, 3][Scale];
stringer_Ypos=(car_width-center_sill_width)/8;
stringer_thickness=[0.35, 0.6, 0.75, 1, 2][Scale];
stringer_depth=[0.5, 0.8, 1.8, 2, 3][Scale];
joist_space=(center_sill_length-(bolster_setback)-(stringer_thickness)-center_sill_width)/8;

side_sill_lo_height=scaler(Side_Sill_Depth_in_Inches);
side_sill_hi_height=scaler(Fish_Belly_Depth_in_Inches);
side_sill_angle_length=scaler(Fish_Belly_Angle_Length_in_Feet*12);

pocket_spacing=car_length/Pockets_per_Side;
pocket_wall=[0.1, 0.25, 0.4, 0.75, 1.0][Scale];
pocket_hole=[0.5, 0.75, 1.0, 1.5, 2][Scale];
pocket_depth=[1.0, 1.5, 2.0, 4.0, 6.0][Scale];
echo(Pockets_per_Side=Pockets_per_Side,pocket_spacing=pocket_spacing);
echo(pocket_hole=pocket_hole,pocket_wall=pocket_wall);

support_spacing=center_sill_length/20;

deck_board_length=car_length/[50, 75, 100, 125, 125][Scale];
deck_board_width=car_width*1;
deck_board_depth=[0.125, 0.2, 0.35, 0.5, 0.75][Scale];

//
//  MODULES
//

//
// scaler - Convers a measurement in Prototype Inches to millimeters for internal use in the scale chosen
function scaler(x) = (x/scale)*25.4;

//
// side_sill
module side_sill(Ypos, orientation) {
  if(orientation) {
    hull() {
      translate([center_sill_Xpos, Ypos, 0]) cube([center_sill_length,stringer_thickness, side_sill_lo_height]);
      translate([center_sill_Xpos+side_sill_angle_length, Ypos, 0]) cube([center_sill_length-side_sill_angle_length*2,stringer_thickness, side_sill_hi_height]);
    }
    translate([0, Ypos, 0]) cube([car_length,stringer_thickness, side_sill_lo_height]);
  } else {
    hull() {
      translate([center_sill_Xpos, Ypos, 0]) cube([center_sill_length,stringer_thickness, side_sill_lo_height]);
      translate([center_sill_Xpos+side_sill_angle_length, Ypos, 0]) cube([center_sill_length-side_sill_angle_length*2,stringer_thickness, side_sill_hi_height]);
    }
    translate([0, Ypos, 0]) cube([car_length,stringer_thickness, side_sill_lo_height]);
  }
}

//
// joist
module joist(Xpos) {
  translate([Xpos, 0, deck_thickness*2]) cube([stringer_thickness, car_width, stringer_depth*1.25]);
}

//
// stringer
module stringer(Xpos, Ypos, length) {
  translate([Xpos, Ypos-(stringer_thickness/2), deck_thickness*2]) cube([length, stringer_thickness, stringer_depth]);
}

//
// center_sill
module center_sill (Xpos1, Xpos2) {
  difference() {
    union() {  
      hull() {
        translate([Xpos1+(side_sill_angle_length/4), (bolster_width/2)-(center_sill_width/2), deck_thickness*2]) cube([Xpos2-Xpos1-side_sill_angle_length/2, center_sill_width, center_sill_lo_depth]);
        translate([Xpos1+(side_sill_angle_length), (bolster_width/2)-(center_sill_width/2), deck_thickness*2]) cube([Xpos2-Xpos1-side_sill_angle_length*2, center_sill_width, center_sill_hi_depth]);
      }
     translate([Xpos1, (bolster_width/2)-(center_sill_width/2), deck_thickness*2]) cube([Xpos2-Xpos1, center_sill_width, center_sill_lo_depth]);
   }
   translate([Xpos1, (bolster_width/2)-(center_sill_width/2)+(center_sill_thickness/2), deck_thickness*2]) cube([Xpos2-Xpos1, center_sill_width-center_sill_thickness, center_sill_hi_depth+center_sill_thickness]);
  }
}

//
// bolster
module bolster(Xpos) {
  difference() {
    translate([Xpos, 0, deck_thickness])
    {
      hull()
      {
        cube([bolster_length, bolster_width, deck_thickness]);
        translate([0,(bolster_width/2)-(bolster_length/2),deck_thickness]) cube([bolster_length, bolster_length, bolster_depth]);
      }
    }
    translate([Xpos+(bolster_length/2), (bolster_width/2), deck_thickness])cylinder(h=30, r=bolster_pin_radius, center=true);
  }
}

//
// pocket
module pocket(Xpos, Ypos, Zpos) {
  difference() {
    translate([Xpos-(pocket_hole/2)-(pocket_wall), Ypos, Zpos]) cube([pocket_hole+(pocket_wall*2), pocket_hole+(pocket_wall*2), pocket_depth]);
    translate([Xpos-(pocket_hole/2), Ypos+(pocket_wall), Zpos-(pocket_depth/2)]) cube([pocket_hole, pocket_hole, (pocket_depth*2)]);
  }  
}

//
// car_body
module car_body() {
  translate([0, 0, 0]) cube([car_length, car_width, deck_thickness]);
  translate([bolster_setback+bolster_length, 0, deck_thickness]) cube([center_sill_length, car_width, deck_thickness]);
  bolster(bolster_setback);
  bolster(car_length-bolster_setback-bolster_length);
  center_sill (center_sill_Xpos, center_sill_Xpos+center_sill_length);
  for(x = [1 : 1 : 3]) {
    stringer(center_sill_Xpos,stringer_Ypos*x,center_sill_length);
    stringer(center_sill_Xpos,car_width-(stringer_Ypos*x),center_sill_length);
  }
  for(x = [0 : 1 : 3]) {
    joist(center_sill_Xpos+bolster_setback+(joist_space*x));
    joist(center_sill_Xpos+center_sill_length-bolster_setback-(joist_space*x));
  }
  
  side_sill(0,1);
  side_sill(car_width-stringer_thickness,0);

  for(x = [0 : 1 : Pockets_per_Side-1]) {
    pocket((x*pocket_spacing)+(pocket_spacing/2)+((pocket_hole-pocket_wall)/2), 0-pocket_hole-pocket_wall, 0);
    pocket((x*pocket_spacing)+(pocket_spacing/2)+((pocket_hole-pocket_wall)/2), car_width-pocket_wall, 0);
  }
}

//
// deck_board
module deck_board(Xpos) {
  hull()
    {
      translate([Xpos, -Space_Between_Deck_and_Body-car_width, deck_thickness/8])  cube([deck_board_length, deck_board_width, deck_board_depth/16]);
      translate([Xpos + (deck_board_length/8), -Space_Between_Deck_and_Body-car_width, (deck_thickness/2)+(deck_board_depth/4)]) cube([deck_board_length - (deck_board_length/4), deck_board_width, deck_board_depth*0.75- (deck_board_depth/4)]);
    }
}

//
// deck
module deck() {
  translate([0, -Space_Between_Deck_and_Body-car_width, 0]) cube([car_length, car_width, deck_thickness/4]);
}

//
// support
module support(Xpos, Ypos, hsize) {
  translate([ Xpos, Ypos, 0]) cylinder(h=hsize, r1=0.4, r2=0.1, center=false);
}

//
// ASSEMBLE BUILDING
//
difference() {
  car_body();
  translate([(car_length/2)-(weight_length/2), (car_width/2)-(weight_width/2), 0]) cube([weight_length, weight_width, weight_depth]);
}
for(Xpos = [center_sill_Xpos+support_spacing : support_spacing: center_sill_Xpos+center_sill_length-support_spacing]) 
    for(Ypos = [(car_width/2)-(weight_width/2)+(weight_width/6) : weight_width/3: (car_width/2)+(weight_width/2)]) 
        support(Xpos, Ypos, weight_depth);

deck();
for(Xpos = [0 : deck_board_length : car_length-(deck_board_length/2)]) deck_board(Xpos);
