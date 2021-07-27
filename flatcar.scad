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

use<function_lib.scad>
use<floor.scad>

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
      cube([deck_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
  } else {
    hull() {
      translate([center_sill_Xpos(p), Ypos, 0]) 
        cube([center_sill_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
      translate([center_sill_Xpos(p)+side_sill_angle_length(p), Ypos, 0]) 
        cube([center_sill_length(p)-side_sill_angle_length(p)*2, side_sill_thickness(p), side_sill_hi_height(p)]);
    }
    translate([0, Ypos, 0]) 
      cube([deck_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
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
  if (body_mounts(p)) {
    wid = (deck_width(p)-coupler_width(p))/2;
    adj = (side_sill_thickness(p)/2);
    translate([Xpos, adj, 0]) 
      cube([side_sill_thickness(p), wid, side_sill_lo_height(p)]);
    translate([Xpos, deck_width(p)-wid+adj, 0]) 
      cube([side_sill_thickness(p), wid, side_sill_lo_height(p)]);
  } else {
    translate([Xpos, 0, 0]) 
      cube([side_sill_thickness(p), deck_width(p), deck_thickness(p)]);
  }
  if(flip) {
    adj = side_sill_thickness(p)-stringer_thickness(p);
    pole_pocket(p, Xpos+adj, flip);
    translate([0, deck_width(p)+side_sill_thickness(p), 0]) mirror([0,1,0]) pole_pocket(p, Xpos+adj, flip);
  } else {
    pole_pocket(p, Xpos, flip);
    translate([0, deck_width(p)+side_sill_thickness(p), 0]) mirror([0,1,0]) pole_pocket(p, Xpos, flip);
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
// step
// head is a boolean that says whether the step is on the zero end or the car_length end.
// right is a boolean that says whether the step is on the zero side or the car_width side.
// step(p, car_length, car_width, true, true) will create the step at the far side and at the far end from 0, 0
module step (p, Xpos, Ypos, head, right) {
  step_depth = (center_sill_hi_depth(p)*0.8);
  step_length = (bolster_setback(p)/3);
  Xadj = head ? 0 : -step_length;
  Yadj = right ? -steel_thickness(p) : steel_thickness(p);
  translate([Xpos+Xadj, Ypos+Yadj, 0])  
    cube([steel_thickness(p), side_sill_thickness(p), step_depth]);
  translate([Xpos+Xadj, Ypos+Yadj, step_depth])  
    cube([step_length, side_sill_thickness(p), steel_thickness(p)]);
  translate([Xpos+step_length-steel_thickness(p)+Xadj, Ypos+Yadj, 0])  
    cube([steel_thickness(p), side_sill_thickness(p), step_depth]);
}

//
// flat_car_body
module flat_car_body(p) {
  side_sill(p, 0, 1);
  side_sill(p, deck_width(p), 0);
  end_sill(p, 0, false);
  end_sill(p, deck_length(p)-side_sill_thickness(p), true);

  pocket_size = pocket_hole(p)-pocket_wall(p);
  for(x = [0 : 1 : pockets_per_side(p)-1]) {
    pocket(p, (x*pocket_spacing(p))+(pocket_spacing(p)/2)+(pocket_size/2), -pocket_size-(side_sill_thickness(p)/2), 0);
    pocket(p, (x*pocket_spacing(p))+(pocket_spacing(p)/2)+(pocket_size/2), deck_width(p)+side_sill_thickness(p)-pocket_wall(p), 0);
  }

  step(p, 0, 0, true, true);
  step(p, 0, deck_width(p), true, false);
  step(p, deck_length(p), 0, false, true);
  step(p, deck_length(p), deck_width(p), false, false);
}


//
// deck_board
module deck_board(p, Xpos, Ypos) {
  hull()
  {
    translate([Xpos, Ypos, deck_thickness(p)/8])  
      cube([deck_board_length(p), deck_board_width(p), deck_board_depth(p)/16]);
    translate([Xpos + (deck_board_length(p)/8), Ypos, (deck_thickness(p)/2)+(deck_board_depth(p)/4)]) 
      cube([deck_board_length(p) - (deck_board_length(p)/4), deck_board_width(p), deck_board_depth(p)*0.75- (deck_board_depth(p)/4)]);
  }
}

//
// deck
module deck(p) {
  cube([deck_length(p), deck_width(p), deck_thickness(p)/4]);
  for(Xpos = [0 : deck_board_length(p) : deck_length(p)-(deck_board_length(p)/2)]) 
    deck_board(p, Xpos, 0);
}

//
// flatcar
module flatcar(p) {
  translate([0,(side_sill_thickness(p)/2),0]) car_floor(p);
  flat_car_body(p);
  translate([ 0, -space_between_car_parts(p)-deck_width(p), 0])
    deck(p);
}
