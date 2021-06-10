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

use<../libraries/function_lib.scad>
use<../libraries/floor.scad>

//
// side_sill
module side_sill(p, Ypos, orientation) {
  if(orientation) {
    hull() {
      translate([center_sill_Xpos(p), Ypos, 0]) 
        cube([center_sill_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
      translate([center_sill_Xpos(p)+side_sill_angle_length(p), Ypos, 0]) 
        cube([center_sill_length(p)-side_sill_angle_length(p)*2, side_sill_thickness(p), side_sill_hi_height(p)]);
    }
    translate([0, Ypos, 0]) 
      cube([car_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
  } else {
    hull() {
      translate([center_sill_Xpos(p), Ypos, 0]) 
        cube([center_sill_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
      translate([center_sill_Xpos(p)+side_sill_angle_length(p), Ypos, 0]) 
        cube([center_sill_length(p)-side_sill_angle_length(p)*2, side_sill_thickness(p), side_sill_hi_height(p)]);
    }
    translate([0, Ypos, 0]) 
      cube([car_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
  }
}

//
// pole_pocket
module pole_pocket(p, Xpos, flip) {
  translate([Xpos,0,0]) {
    hull () {
      cube([ stringer_thickness(p), side_sill_lo_height(p), deck_thickness(p)*1.5]);
      cube([ stringer_thickness(p), side_sill_lo_height(p)*0.8, side_sill_lo_height(p)]);
    }
    if (flip) {
      translate([stringer_thickness(p)+steel_thickness(p), (side_sill_lo_height(p)/2)-(steel_thickness(p)/2), side_sill_lo_height(p)/2]) {
        difference() {
          rotate([0, 270, 0]) 
            cylinder(h=steel_thickness(p), d1=side_sill_lo_height(p)*0.7, d2=side_sill_lo_height(p)*0.8);
          translate([steel_thickness(p)*0.7,0,0]) 
            sphere(d=side_sill_lo_height(p)*0.7);
        }
      }
    } else {
      translate([-steel_thickness(p), (side_sill_lo_height(p)/2)-(steel_thickness(p)/2), side_sill_lo_height(p)/2]) {
        difference() {
          rotate([0, 90, 0]) 
            cylinder(h=steel_thickness(p), d1=side_sill_lo_height(p)*0.7, d2=side_sill_lo_height(p)*0.8);
          translate([-steel_thickness(p)*0.7,0,0]) 
            sphere(d=side_sill_lo_height(p)*0.7);
        }
      }
    }
  }
}

//
// end_sill
module end_sill(p, Xpos, flip) {
  translate([Xpos, 0, 0]) 
    cube([side_sill_thickness(p), car_width(p), deck_thickness(p)*1.5]);
  if(flip) {
    adj = side_sill_thickness(p)-stringer_thickness(p);
    pole_pocket(p, Xpos+adj, flip);
    translate([0, car_width(p), 0]) mirror([0,1,0]) pole_pocket(p, Xpos+adj, flip);
  } else {
    pole_pocket(p, Xpos, flip);
    translate([0, car_width(p), 0]) mirror([0,1,0]) pole_pocket(p, Xpos, flip);
  }
}

//
// pocket
module pocket(p, Xpos, Ypos, Zpos) {
  difference() {
    translate([Xpos-(pocket_hole(p)/2)-(pocket_wall(p)), Ypos, Zpos]) 
      cube([pocket_hole(p)+(pocket_wall(p)*2), pocket_hole(p)+(pocket_wall(p)*2), pocket_depth(p)]);
    translate([Xpos-(pocket_hole(p)/2), Ypos+(pocket_wall(p)), Zpos-(pocket_depth(p)/2)]) 
      cube([pocket_hole(p), pocket_hole(p), (pocket_depth(p)*2)]);
  }  
}

//
// flat_car_body
module flat_car_body(p) {
  side_sill(p, 0,1);
  side_sill(p, car_width(p)-side_sill_thickness(p),0);
  end_sill(p, 0, false);
  end_sill(p, car_length(p)-side_sill_thickness(p), true);

  for(x = [0 : 1 : pockets_per_side(p)-1]) {
    pocket(p, (x*pocket_spacing(p))+(pocket_spacing(p)/2)+((pocket_hole(p)-pocket_wall(p))/2), 0-pocket_hole(p)-pocket_wall(p), 0);
    pocket(p, (x*pocket_spacing(p))+(pocket_spacing(p)/2)+((pocket_hole(p)-pocket_wall(p))/2), car_width(p)-pocket_wall(p), 0);
  }
}


//
// deck_board
module deck_board(p, Xpos) {
  hull()
    {
      translate([Xpos, -space_between_car_parts(p)-car_width(p), deck_thickness(p)/8])  
        cube([deck_board_length(p), deck_board_width(p), deck_board_depth(p)/16]);
      translate([Xpos + (deck_board_length(p)/8), -space_between_car_parts(p)-car_width(p), (deck_thickness(p)/2)+(deck_board_depth(p)/4)]) 
        cube([deck_board_length(p) - (deck_board_length(p)/4), deck_board_width(p), deck_board_depth(p)*0.75- (deck_board_depth(p)/4)]);
    }
}

//
// deck
module deck(p) {
  translate([0, -space_between_car_parts(p)-car_width(p), 0]) 
    cube([car_length(p), car_width(p), deck_thickness(p)/4]);
  for(Xpos = [0 : deck_board_length(p) : car_length(p)-(deck_board_length(p)/2)]) deck_board(p, Xpos);
}

//
// flatcar
module flatcar(p) {
  translate([side_sill_thickness(p)/2, side_sill_thickness(p)/2, 0]) car_floor(p);
  flat_car_body(p);
  deck(p);
}
