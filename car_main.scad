//
//
//  Customizable Car Creator
//  Will Merrell
//  April 4, 2021
//
// 
// Car Creator is free software: you can redistribute it and/or modify it under the terms of the
// GNU General Public License as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// Car Creator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with Car Creator.
// If not, see <https://www.gnu.org/licenses/>.
//

//
//!
//!
//
$fn = 36 * 1;
use<MCAD/regular_shapes.scad>
use<function_lib.scad>
use<floor.scad>
use<flatcar.scad>
use<gondola.scad>

echo();
echo();
echo();
echo();
echo();
// preview[view:south, tilt:top]

//
// CUSTOMIZING
//
Scale = 2;// [0:Z, 1:N, 2:HO, 3:S, 4:O, 5:G]
Car_Type = 1;// [0:Flat Car, 1:Gondola, 2:Box Car, 3:Reefer]
Car_Length_in_Feet=35.5;
Car_Width_in_Feet=9.5;
Car_Height_in_Feet=5.5;

/* [Car Features] */
Side_Sill_Depth_in_Inches=18.0;
Side_Sill_Thickness_in_Inches=5.5;
Fish_Belly_Depth_in_Inches=35.0;
Fish_Belly_Angle_Length_in_Feet=9.5;
Pockets_per_Side=7;
Truck_Height_in_Inches=27.1875;
Bolster_Height_in_Inches=17.6;
Use_Body_Mount_Couplers = true;

/* [Layout] */
Space_Between_Car_Parts=8;
Fudge_Factor_in_Inches = 2;
Show_Rivets = true;
Use_Supports = false;

//
// REMAINING PARAMETERS
//

car_length = scaler(Scale, Car_Length_in_Feet*12);
car_width = scaler(Scale, Car_Width_in_Feet*12);
car_height = scaler(Scale, Car_Height_in_Feet*12);
side_sill_thickness = scaler(Scale, Side_Sill_Thickness_in_Inches);
fudge_factor = scaler(Scale, Fudge_Factor_in_Inches);
deck_length = car_length-(side_sill_thickness*2)-fudge_factor;
deck_width = car_width-(side_sill_thickness*2)-fudge_factor;
steel_thickness = scaler(Scale, [3.0, 2.5, 1.75, 1.5, 1, 1][Scale]);
bolster_length = [2.5, 3.8, 5.2, 8.1, 10.6, 16][Scale];
bolster_setback = [5.2, 8.0, 16.5, 20, 30, 50][Scale];
bolster_height = scaler(Scale, Bolster_Height_in_Inches);
truck_height = scaler(Scale, Truck_Height_in_Inches);
deck_height = truck_height + bolster_height;
coupler_mount_height = [4.0, 8.5, 11.5, 15.0, 25.0, 50.0][Scale];
center_sill_length = deck_length-((bolster_setback+bolster_length)*2);
center_sill_width = [2.5, 3.5, 5.2, 7, 10, 12][Scale];
stringer_thickness = [0.35, 0.6, 0.75, 1, 2, 4][Scale];

parameters=[
  ["scale",                         [220, 160, 87, 64, 48, 22.5][Scale]],
  ["gauge",                         [6.5, 9.0, 16.5, 22.43, 30.0, 45.0][Scale]],
  ["car_type",                      Car_Type],
  ["car_length",                    car_length],
  ["car_width",                     car_width],
  ["car_height",                    car_height],
  ["deck_height",                   deck_height],
  ["deck_length",                   deck_length],
  ["deck_width",                    deck_width],
  ["deck_thickness",                [0.3, 0.55, 0.75, 1.1, 1.6, 3][Scale]],
  ["bolster_length",                bolster_length],
  ["bolster_width",                 deck_width],
  ["bolster_height",                bolster_height],
  ["bolster_setback",               bolster_setback],
  ["bolster_pin_radius",            [0.75, 1.0, 0.9, 2.1, 2.4, 3][Scale]],
  ["weight_width",                  [5, 12, 23, 20, 40, 80][Scale]],
  ["weight_depth",                  [0.3, 0.95, 1, 2, 3, 5][Scale]],
  ["weight_length",                 car_length-((bolster_setback*2)+bolster_length*2)],
  ["center_sill_length",            center_sill_length],
  ["center_sill_Xpos",              bolster_setback+bolster_length],
  ["center_sill_width",             [2.5, 3.5, 5.2, 7, 10, 12][Scale]],
  ["center_sill_lo_depth",          [1.5, 2, 3.8, 5, 7.8, 10][Scale]],
  ["center_sill_hi_depth",          scaler(Scale, Fish_Belly_Depth_in_Inches)],
  ["center_sill_thickness",         [0.8, 1, 1.8, 2, 3, 5][Scale]],
  ["stringer_Ypos",                 (car_width-center_sill_width)/8],
  ["stringer_thickness",            stringer_thickness],
  ["stringer_depth",                [0.5, 0.8, 1.8, 2, 3, 4][Scale]],
  ["joist_space",                   (center_sill_length-(bolster_setback)-(stringer_thickness)-center_sill_width)/8],
  ["side_sill_lo_height",           scaler(Scale, Side_Sill_Depth_in_Inches)],
  ["side_sill_hi_height",           scaler(Scale, Fish_Belly_Depth_in_Inches)],
  ["side_sill_angle_length",        scaler(Scale, Fish_Belly_Angle_Length_in_Feet*12)],
  ["side_sill_thickness",           side_sill_thickness],
  ["pockets_per_side",              Pockets_per_Side],
  ["pocket_spacing",                deck_length/Pockets_per_Side],
  ["pocket_wall",                   [0.1, 0.25, 0.4, 0.75, 1.0, 2.0][Scale]],
  ["pocket_hole",                   [0.5, 0.75, 1.0, 1.5, 2, 4][Scale]],
  ["pocket_depth",                  [1.0, 1.5, 2.0, 4.0, 6.0, 8.0][Scale]],
  ["support_x_spacing",             center_sill_length/[15, 20, 30, 80, 100, 15][Scale]],
  ["support_y_spacing",             [1, 2, 3, 5, 5, 5][Scale]],
  ["deck_board_length",             deck_length/[50, 75, 100, 125, 125, 125][Scale]],
  ["deck_board_width",              deck_width],
  ["deck_board_depth",              [0.125, 0.2, 0.35, 0.5, 0.75, 1.0][Scale]],
  ["steel_thickness",               steel_thickness],
  ["rivet_round",                   16],
  ["rivet_height",                  scaler(Scale, 1.0)],
  ["rivet_size1",                   scaler(Scale, 1.5)],
  ["rivet_size2",                   scaler(Scale, 0.8)],
  ["rivet_offset",                  scaler(Scale, 5.0)],
  ["show_rivets",                   Show_Rivets],
  ["brake_round",                   16],
  ["brake_height",                  scaler(Scale, 8.0)],
  ["brake_length1",                 scaler(Scale, 18.0)],
  ["brake_length2",                 scaler(Scale, 24.0)],
  ["brake_size1",                   scaler(Scale, 18.0)],
  ["brake_size2",                   scaler(Scale, 5.0)],
  ["brake_offset",                  scaler(Scale, 5.0)],
  ["truck_height",                  truck_height],
  ["coupler_mount_height",          [4.5, 7.1, 11.5, 16.5, 22.0, 30.0][Scale]],
  ["coupler_length",                [5.2, 5.2, 11.6, 22.5, 30.0, 45.0][Scale]],
  ["coupler_width",                 [3.7, 3.7, 7.6, 10.0, 15.0, 20.0][Scale]],
  ["coupler_mount_hole_radius",     [0.5, 0.6, 0.9, 2.0, 3.0, 4.0][Scale]],
  ["coupler_mount_hole_setback",    [3.0, 3.2, 5.28, 10.0, 15.0, 20.0][Scale]],
  ["body_mounts",                   Use_Body_Mount_Couplers],
  ["supports",                      Use_Supports],
  ["space_between_car_parts",       Space_Between_Car_Parts],
  ["fudge_factor",                  fudge_factor],
  ["0",                             0]
]; 

echo();
echo(parameters=parameters);
echo();


//
// ---------------------------------------------------------------------------- //
//  MODULES
// ---------------------------------------------------------------------------- //
//

//
// main
module main(p) {
    //
    // Car Type: Flat Car
  if(car_type(p) == 0) {
    echo("Car Type: Flat Car");
    flatcar(p);

    //
    // Car Type: Gondola
  } else if(car_type(p) == 1) {
    echo("Car Type: Gondola");
    gondola(p);

    //
    // Car Type: Box Car
  } else if(car_type(p) == 2) {
    echo("Car Type: Box Car");
    //
    // Car Type: Reefer
  } else if(car_type(p) == 3) {
    echo("Car Type: Reefer");
    //
    // Car Type: Unknown Car Type
  } else {
    assert(false, "Unknown Car Type");
  }

}

main(parameters);
