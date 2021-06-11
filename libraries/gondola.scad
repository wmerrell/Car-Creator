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
      translate([center_sill_Xpos(p), Ypos, car_height(p)-side_sill_lo_height(p)]) 
        cube([center_sill_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
      translate([center_sill_Xpos(p)+side_sill_angle_length(p), Ypos, car_height(p)-side_sill_lo_height(p)]) 
        cube([center_sill_length(p)-side_sill_angle_length(p)*2, side_sill_thickness(p), side_sill_hi_height(p)]);
    }
    // Sidewall
    translate([0, Ypos, 0]) {
      cube([car_length(p), side_sill_thickness(p), car_height(p)]);
      translate([0, -side_sill_thickness(p), 0]) 
        cube([car_length(p), side_sill_thickness(p)*2, stringer_thickness(p)]);
    }
  } else {
    hull() {
      translate([center_sill_Xpos(p), Ypos, car_height(p)-side_sill_lo_height(p)]) 
        cube([center_sill_length(p), side_sill_thickness(p), side_sill_lo_height(p)]);
      translate([center_sill_Xpos(p)+side_sill_angle_length(p), Ypos, car_height(p)-side_sill_lo_height(p)]) 
        cube([center_sill_length(p)-side_sill_angle_length(p)*2, side_sill_thickness(p), side_sill_hi_height(p)]);
    }
    // Sidewall
    translate([0, Ypos, 0]) {
      cube([car_length(p), side_sill_thickness(p), car_height(p)]);
      cube([car_length(p), side_sill_thickness(p)*2, stringer_thickness(p)]);
    }
  }
}

//
// pole_pocket
module pole_pocket(p, Xpos, Ypos,  flip) {
  translate([Xpos, Ypos, car_height(p)-side_sill_lo_height(p)]) {
    hull () {
      cube([ stringer_thickness(p), side_sill_lo_height(p), deck_thickness(p)*1.5]);
      cube([ stringer_thickness(p), side_sill_lo_height(p)*0.8, side_sill_lo_height(p)]);
    }
    if (flip) {
      translate([stringer_thickness(p)+steel_thickness(p), (side_sill_lo_height(p)/2)-(steel_thickness(p)/2), side_sill_lo_height(p)/2]) {
        difference() {
          rotate([0, 270, 0]) 
            cylinder(h=steel_thickness(p), d1=side_sill_lo_height(p)*0.7, d2=side_sill_lo_height(p)*0.8);
          translate([steel_thickness(p)*0.7, 0, 0]) 
            sphere(d=side_sill_lo_height(p)*0.7);
        }
      }
    } else {
      translate([-steel_thickness(p), (side_sill_lo_height(p)/2)-(steel_thickness(p)/2), side_sill_lo_height(p)/2]) {
        difference() {
          rotate([0, 90, 0]) 
            cylinder(h=steel_thickness(p), d1=side_sill_lo_height(p)*0.7, d2=side_sill_lo_height(p)*0.8);
          translate([-steel_thickness(p)*0.7, 0, 0]) 
            sphere(d=side_sill_lo_height(p)*0.7);
        }
      }
    }
  }
}

//
// dreadnaught_rib
module dreadnaught_rib (Xpos, Ypos, Ylength, thickness, di1, di2) {
  // echo(thickness=thickness, di1=di1, di2=di2);
  translate([ 0, 0, thickness]) {
    hull() {
      translate([ Xpos+(Ylength*0.05), Ypos+(di2/1.5), 0]) sphere(di1);
      translate([ Xpos+(Ylength*0.25), Ypos+(di2/1.5), 0]) sphere(di2);
      translate([ Xpos+(Ylength*0.75), Ypos+(di2/1.5), 0]) sphere(di2);
      translate([ Xpos+(Ylength*0.95), Ypos+(di2/1.5), 0]) sphere(di1);
    }
  }
  translate([ 0, 0, thickness]) {
    hull() {
      translate([  Xpos+(Ylength*0.065), Ypos-(di2/1.5), 0]) sphere(di2);
      translate([  Xpos+(Ylength*0.23), Ypos-(di2/1.5), 0]) sphere(di1);
    }
    hull() {
      translate([  Xpos+(Ylength*0.78), Ypos-(di2/1.5), 0]) sphere(di1);
      translate([  Xpos+(Ylength*0.935), Ypos-(di2/1.5), 0]) sphere(di2);
    }
  }
  translate([ Xpos, Ypos-di2*2, 0]) cube([Ylength, di2*4, thickness]);  
}

//
// 
module dreadnaught_end (p) {
  difference() {
    difference() {
      translate([0, 0, 0]) for(yy = [0 : (stringer_thickness(p)*2.75) : car_height(p)-side_sill_lo_height(p)-steel_thickness(p)] ) {
        dreadnaught_rib(0,  yy, car_width(p), steel_thickness(p), steel_thickness(p)/2, (stringer_thickness(p)));
      }
      translate([0, 0, -steel_thickness(p)]) cube([ car_width(p), car_height(p), steel_thickness(p)]);
    }
    translate([-steel_thickness(p), -car_height(p), -steel_thickness(p)]) cube([ car_width(p)+(steel_thickness(p)*2), car_height(p), steel_thickness(p)*4]);
  }
}

//
// end_sill
module end_sill(p, Xpos, Ypos, flip) {
  translate([Xpos, Ypos, car_height(p)-side_sill_lo_height(p)]) 
    cube([stringer_thickness(p), car_width(p), deck_thickness(p)*1.5]);

  pole_pocket(p, Xpos, Ypos, flip);
  translate([0, car_width(p)+side_sill_thickness(p), 0]) mirror([0,1,0]) pole_pocket(p, Xpos, Ypos, flip);

  translate([ Xpos, Ypos, 0]) cube([stringer_thickness(p), car_width(p)+side_sill_thickness(p), car_height(p)-side_sill_lo_height(p)]);

  if (flip) {
    translate([ Xpos, Ypos-side_sill_thickness(p), 0]) 
      cube([side_sill_thickness(p)*1.5, car_width(p)+(side_sill_thickness(p)*3), stringer_thickness(p)]);
    translate([Xpos, Ypos+steel_thickness(p), car_height(p)-(side_sill_lo_height(p)*0.75)]) rotate([90, 0, 90]) mirror([0,1,0]) {
      dreadnaught_end(p);
    }
  } else {
    translate([ Xpos-side_sill_thickness(p), Ypos-side_sill_thickness(p), 0]) 
      cube([side_sill_thickness(p)*1.5, car_width(p)+(side_sill_thickness(p)*3), stringer_thickness(p)]);
    translate([Xpos+steel_thickness(p), Ypos+car_width(p)+steel_thickness(p), car_height(p)-(side_sill_lo_height(p)*0.75)]) rotate([90, 0, -90]) mirror([0,1,0]) {
      dreadnaught_end(p);
    }
  }

}

//
// rib
module rib(p, Xpos, Ypos, Zpos, height) {
  translate([Xpos, Ypos, Zpos]) 
    cube([side_sill_thickness(p), side_sill_thickness(p), height]);
}

//
// gondola_car_body
module gondola_car_body(p) {
  side_sill(p, 0, true);
  side_sill(p, car_width(p), false);
  end_sill(p, 0, 0, false);
  end_sill(p, car_length(p), 0, true);
  difference() {
    translate([0, 0, car_height(p)-side_sill_lo_height(p)]) 
      cube([car_length(p), car_width(p), deck_thickness(p)/4]);
    translate([(car_length(p)/2)-(weight_length(p)/2), (car_width(p)/2)-(weight_width(p)/2), car_height(p)-side_sill_lo_height(p)-0.1]) 
      cube([weight_length(p), weight_width(p), weight_depth(p)+0.1]);
  }

  for(x = [1 : 1 : pockets_per_side(p)-1]) {
    rib(p, (x*pocket_spacing(p)), -side_sill_thickness(p), 0, car_height(p));
    rib(p, (x*pocket_spacing(p)), car_width(p)+side_sill_thickness(p), 0, car_height(p));
  }

  if (supports(p)) {
    support_height = car_height(p)-side_sill_lo_height(p);
    Ypos1 = (car_width(p)/2)-(weight_width(p)/2);
    Ypos2 = (car_width(p)/2)+(weight_width(p)/2);
    for(Xpos = [support_x_spacing(p) : support_x_spacing(p) : car_length(p)-support_x_spacing(p)]) {
      support(Xpos, Ypos1-steel_thickness(p), support_height);
      support(Xpos, Ypos2+steel_thickness(p), support_height);
    }
    for(Xpos = [support_x_spacing(p) : support_x_spacing(p) : (car_length(p)/2)-(weight_length(p)/2)]) {
      for(Ypos = [ Ypos1+support_y_spacing(p) : support_y_spacing(p) : Ypos2-support_y_spacing(p) ]) 
        support(Xpos, Ypos, support_height);
    }
    for(Xpos = [(car_length(p)/2)+(weight_length(p)/2)+steel_thickness(p) : support_x_spacing(p) : car_length(p)-support_x_spacing(p)]) {
      for(Ypos = [ Ypos1+support_y_spacing(p) : support_y_spacing(p) : Ypos2-support_y_spacing(p) ]) 
        support(Xpos, Ypos, support_height);
    }
  }
}

//
// deck_board
module deck_board(p, Xpos) {
  hull()
    {
      translate([Xpos, 0, deck_thickness(p)/8])  
        cube([deck_board_length(p), deck_board_width(p), deck_board_depth(p)/16]);
      translate([Xpos + (deck_board_length(p)/8), 0, (deck_thickness(p)/2)+(deck_board_depth(p)/4)]) 
        cube([deck_board_length(p) - (deck_board_length(p)/4), deck_board_width(p), deck_board_depth(p)*0.75- (deck_board_depth(p)/4)]);
    }
}

//
// deck
module deck(p) {
  color("Gainsboro") translate([0, 0, 0]) {
    cube([deck_length(p), deck_width(p), deck_thickness(p)/2]);
    for(Xpos = [0 : deck_board_length(p) : deck_length(p)-(deck_board_length(p)/2)]) deck_board(p, Xpos);
  }
}

//
// gondola
module gondola(p) {

  car_floor(p);

  translate([0, -space_between_car_parts(p)-car_width(p)-(side_sill_thickness(p)*2), 0]) rotate([0, 0, 0]) {
    gondola_car_body(p);

    // Test cross used to ensure the body is correct relative to thr deck.
    // color("Blue") translate([side_sill_thickness(p), car_width(p)/2, -1]) 
    //   cube([deck_length(p), deck_thickness(p), deck_thickness(p)]);
    // color("Blue") translate([car_length(p)/2, side_sill_thickness(p), -1]) 
    //   cube([deck_thickness(p), deck_width(p), deck_thickness(p)]);
  }

  translate([0, space_between_car_parts(p)+deck_width(p), 0]) rotate([0, 0, 0]) {
    deck(p);
  }
}
