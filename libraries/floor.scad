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

module chassis(p) {
  translate([0, 0, 0]) cube([car_length(p), car_width(p), deck_thickness(p)]);
  translate([bolster_setback(p)+bolster_length(p), 0, deck_thickness(p)]) cube([center_sill_length(p), car_width(p), deck_thickness(p)]);
  // bolster(bolster_setback(p));
  // bolster(car_length(p)-bolster_setback(p)-bolster_length(p));
  // center_sill (center_sill_Xpos(p), center_sill_Xpos(p)+center_sill_length(p));
  // for(x = [1 : 1 : 3]) {
  //   stringer(center_sill_Xpos(p),stringer_Ypos(p)*x,center_sill_length(p));
  //   stringer(center_sill_Xpos(p),car_width(p)-(stringer_Ypos(p)*x),center_sill_length(p));
  // }
  // for(x = [0 : 1 : 3]) {
  //   joist(center_sill_Xpos(p)+bolster_setback(p)+(joist_space(p)*x));
  //   joist(center_sill_Xpos(p)+center_sill_length(p)-bolster_setback(p)-(joist_space(p)*x));
  // }
}

module car_floor(p) {
  difference() {
    chassis(p);
    translate([(car_length(p)/2)-(weight_length(p)/2), (car_width(p)/2)-(weight_width(p)/2), 0]) cube([weight_length(p), weight_width(p), weight_depth(p)]);
  }
  // for(Xpos = [center_sill_Xpos(p)+support_spacing(p) : support_spacing(p) : center_sill_Xpos(p)+center_sill_length(p)-support_spacing(p)]) 
  //   for(Ypos = [(car_width(p)/2)-(weight_width(p)/2)+(weight_width(p)/6) : weight_width(p)/3: (car_width(p)/2)+(weight_width(p)/2)]) 
  //     support(Xpos, Ypos, weight_depth(p));
}