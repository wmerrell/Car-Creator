//
//
//  Part of the Customizable Car Creator
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
// You should have received a copy of the GNU General Public License along with Bridge Creator/.
// If not, see <https://www.gnu.org/licenses/>.
//

//
// scaler - Converts a measurement in Prototype Inches to millimeters for internal use in the scale chosen
function scaler(Scale, x) = (x / ([220, 160, 87, 64, 48, 22.5][Scale])) * 25.4;

//
// value_of
function value_of(name,list) = list[search([name],list)[0]][1];

//
// list functions
function scale(list) = list[search(["scale"],list)[0]][1];                   
function gauge(list) = list[search(["gauge"],list)[0]][1];                   
function car_type(list) = list[search(["car_type"],list)[0]][1];
function car_length(list) = list[search(["car_length"],list)[0]][1];
function car_width(list) = list[search(["car_width"],list)[0]][1];
function deck_height(list) = list[search(["deck_height"],list)[0]][1];
function deck_thickness(list) = list[search(["deck_thickness"],list)[0]][1];
function bolster_length(list) = list[search(["bolster_length"],list)[0]][1];
function bolster_width(list) = list[search(["bolster_width"],list)[0]][1];
function bolster_depth(list) = list[search(["bolster_depth"],list)[0]][1];
function bolster_setback(list) = list[search(["bolster_setback"],list)[0]][1];
function bolster_pin_radius(list) = list[search(["bolster_pin_radius"],list)[0]][1];
function weight_width(list) = list[search(["weight_width"],list)[0]][1];
function weight_depth(list) = list[search(["weight_depth"],list)[0]][1];
function weight_length(list) = list[search(["weight_length"],list)[0]][1];
function center_sill_length(list) = list[search(["center_sill_length"],list)[0]][1];
function center_sill_Xpos(list) = list[search(["center_sill_Xpos"],list)[0]][1];
function center_sill_width(list) = list[search(["center_sill_width"],list)[0]][1];
function center_sill_lo_depth(list) = list[search(["center_sill_lo_depth"],list)[0]][1];
function center_sill_hi_depth(list) = list[search(["center_sill_hi_depth"],list)[0]][1];
function center_sill_thickness(list) = list[search(["center_sill_thickness"],list)[0]][1];
function stringer_Ypos(list) = list[search(["stringer_Ypos"],list)[0]][1];
function stringer_thickness(list) = list[search(["stringer_thickness"],list)[0]][1];
function stringer_depth(list) = list[search(["stringer_depth"],list)[0]][1];
function joist_space(list) = list[search(["joist_space"],list)[0]][1];
function side_sill_lo_height(list) = list[search(["side_sill_lo_height"],list)[0]][1];
function side_sill_hi_height(list) = list[search(["side_sill_hi_height"],list)[0]][1];
function side_sill_angle_length(list) = list[search(["side_sill_angle_length"],list)[0]][1];
function pockets_per_side(list) = list[search(["pockets_per_side"],list)[0]][1];
function pocket_spacing(list) = list[search(["pocket_spacing"],list)[0]][1];
function pocket_wall(list) = list[search(["pocket_wall"],list)[0]][1];
function pocket_hole(list) = list[search(["pocket_hole"],list)[0]][1];
function pocket_depth(list) = list[search(["pocket_depth"],list)[0]][1];
function support_spacing(list) = list[search(["support_spacing"],list)[0]][1];
function deck_board_length(list) = list[search(["deck_board_length"],list)[0]][1];
function deck_board_width(list) = list[search(["deck_board_width"],list)[0]][1];
function deck_board_depth(list) = list[search(["deck_board_depth"],list)[0]][1];
function steel_thickness(list) = list[search(["steel_thickness"],list)[0]][1];
function rivet_round(list) = list[search(["rivet_round"],list)[0]][1];
function rivet_height(list) = list[search(["rivet_height"],list)[0]][1];
function rivet_size1(list) = list[search(["rivet_size1"],list)[0]][1];
function rivet_size2(list) = list[search(["rivet_size2"],list)[0]][1];
function rivet_offset(list) = list[search(["rivet_offset"],list)[0]][1];
function show_rivets(list) = list[search(["show_rivets"],list)[0]][1];
function brake_round(list)  = list[search(["brake_round"],list)[0]][1];
function brake_height(list) = list[search(["brake_height"],list)[0]][1];
function brake_length1(list) = list[search(["brake_length1"],list)[0]][1];
function brake_length2(list) = list[search(["brake_length2"],list)[0]][1];
function brake_size1(list)  = list[search(["brake_size1"],list)[0]][1];
function brake_size2(list)  = list[search(["brake_size2"],list)[0]][1];
function brake_offset(list) = list[search(["brake_offset"],list)[0]][1];
function supports(list) = list[search(["supports"],list)[0]][1];
function space_between_car_parts(list) = list[search(["space_between_car_parts"],list)[0]][1];
