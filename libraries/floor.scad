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

//
// support
module support(Xpos, Ypos, hsize) {
  translate([ Xpos, Ypos, 0]) cylinder(h=hsize, r1=0.5, r2=0.1, center=false);
}

//
// brake_cylinder
module brake_cylinder (p) {
  color("gray") rotate([0, 90, 0]) {
    translate([ 0, 0, brake_length2(p)+(steel_thickness(p)*2)]) 
      cylinder(h=brake_length1(p), d1=brake_size1(p), d2=brake_size2(p));
    translate([ 0, 0, brake_length2(p)+steel_thickness(p)]) 
      cylinder(h=steel_thickness(p), d=brake_size1(p)*1.2);
    translate([ 0, 0, steel_thickness(p)]) 
      cylinder(h=brake_length2(p), d=brake_size1(p));
    translate([ 0, 0, 0]) 
      cylinder(h=steel_thickness(p), d=brake_size1(p)*1.2);
  }
}

//
// air_reservoir
module air_reservoir (p) {
  color("gray") rotate([0, 90, 0]) {
    translate([ 0, 0, brake_length2(p)+steel_thickness(p)]) 
      cylinder(h=brake_length2(p), d1=brake_size1(p), d2=(brake_size1(p)*0.9));
    translate([ 0, 0, brake_length2(p)]) 
      cylinder(h=steel_thickness(p), d=brake_size1(p)*1.2);
    translate([ 0, 0, 0]) 
      cylinder(h=brake_length2(p), d1=(brake_size1(p)*0.9), d2=brake_size1(p));
  }
}

//
// triple_valve
module triple_valve (p) {
  color("gray") cube([brake_length2(p), (brake_length2(p)/3), (brake_length2(p)/2)]);
}

//
// brake_arm
module brake_arm (p) {
  color("gray") {
    rotate([0, 0, 20]) {
      hull() {
        translate ([ 0, 0, 0]) cube([steel_thickness(p)*2, (brake_length2(p)*2), steel_thickness(p)]);
        color("red") translate ([ (brake_length2(p)/4), brake_length2(p), 0]) 
          rotate([0, 0, 90]) 
            cube([steel_thickness(p), (brake_length2(p)/3), steel_thickness(p)]);
      }
    }
  }
}

//
// westinghouse_brakes
module westinghouse_brakes (p) {
  // TODO: This brake rigging only works for cars more than 35 prototype feet.
  cylinder_length = brake_length2(p)+(steel_thickness(p)*2)+brake_length1(p);
  reservoir_length = (brake_length2(p)*2)+steel_thickness(p);

  translate([ (car_length(p)/2)+(cylinder_length/2), (car_width(p)/2)+center_sill_width(p), brake_size1(p)+steel_thickness(p)]) 
    brake_cylinder(p);
  translate([ (car_length(p)/2)-reservoir_length-(reservoir_length/3), (car_width(p)/2)-(center_sill_width(p)*1.5), brake_size1(p)+steel_thickness(p)]) 
    air_reservoir(p);
  translate([ (car_length(p)/2)-reservoir_length-(reservoir_length/5), (car_width(p)/2)+(center_sill_width(p)*1.5), brake_size2(p)+deck_thickness(p)+steel_thickness(p)]) 
    triple_valve(p);

  // Add brake arms and connect brake_cylinder to the brake arm
  translate([ (car_length(p)/2)+(cylinder_length*2.2), (car_width(p)/2)-(brake_length2(p)*0.9), brake_size1(p)]) 
    brake_arm (p);
  translate([ (car_length(p)/2)-(cylinder_length*2.2), (car_width(p)/2)-(brake_length2(p)*0.9), brake_size1(p)]) 
    brake_arm (p);
  translate([ (car_length(p)/2)+(cylinder_length*1.45), (car_width(p)/2)+center_sill_width(p), brake_size1(p)+steel_thickness(p)]) 
    rotate([0, 90, 0]) {  
      color("gray") cylinder(h=brake_length2(p), d=steel_thickness(p));
    }
  
  // Hook up the brake arm rods
  translate([ (car_length(p)/2)+(cylinder_length*2.2), (car_width(p)/2)-brake_length2(p)+(steel_thickness(p)*2), brake_size1(p)+steel_thickness(p)]) 
    rotate([0, 90, 0]) {  
      color("gray") cylinder(h=(center_sill_length(p)/2)-(cylinder_length*2.2), d=steel_thickness(p));
    }
  translate([ (car_length(p)/2)-(cylinder_length*2.2)-(steel_thickness(p)*2), (car_width(p)/2), brake_size1(p)+steel_thickness(p)]) 
    rotate([0, 90, 0]) {  
      color("gray") cylinder(h=(cylinder_length*4.4), d=steel_thickness(p));
    }
  translate([ bolster_setback(p)+(bolster_length(p)/2), (car_width(p)/2)+center_sill_width(p), brake_size1(p)+steel_thickness(p)]) 
    rotate([0, 90, 0]) {  
      color("gray") cylinder(h=(center_sill_length(p)/2)-(cylinder_length*2.2), d=steel_thickness(p));
    }

  // Connect brake_cylinder to triple valve
  translate([ (car_length(p)/2)-reservoir_length+(steel_thickness(p)*3), (car_width(p)/2)+center_sill_width(p), brake_size1(p)+steel_thickness(p)]) 
    rotate([0, 90, 0]) {  
      color("red") cylinder(h=(brake_length2(p)*3.5), d=steel_thickness(p));
    }
  translate([ (car_length(p)/2)-reservoir_length+(steel_thickness(p)*3), (car_width(p)/2)+center_sill_width(p), brake_size1(p)+steel_thickness(p)]) 
    rotate([-90, 90, 0]) {  
      color("red") cylinder(h=(brake_length2(p)/2), d=steel_thickness(p));
    }

  // 
  translate([ (car_length(p)/2)-reservoir_length-(reservoir_length/3)+(brake_length2(p)/2), (car_width(p)/2)-(center_sill_width(p)*1.5), brake_size1(p)+steel_thickness(p)]) 
    rotate([-90, 90, 0]) {  
      color("red") cylinder(h=car_width(p)*0.6, d=steel_thickness(p));
    }
  translate([ (car_length(p)/2)-reservoir_length-(reservoir_length/3)+(brake_length2(p)*0.8), (car_width(p)/2)-(center_sill_width(p)*1.5)+(brake_length2(p)*0.7), brake_size1(p)+steel_thickness(p)]) 
    rotate([-90, 90, 0]) {  
      color("red") cylinder(h=(car_width(p)*0.5), d=steel_thickness(p));
    }
  translate([ (car_length(p)/2)-reservoir_length-(reservoir_length/3)+(brake_length2(p)*1.5), (car_width(p)/2)-(center_sill_width(p)*1.5), brake_size1(p)+steel_thickness(p)]) 
    rotate([-90, 90, 0]) {  
      color("red") cylinder(h=(brake_length2(p)*0.7), d=steel_thickness(p));
    }
  translate([ (car_length(p)/2)-reservoir_length-(reservoir_length/3)+(brake_length2(p)*0.8), (car_width(p)/2)-(center_sill_width(p)*1.5)+(brake_length2(p)*0.7), brake_size1(p)+steel_thickness(p)]) 
    rotate([0, 90, 0]) {  
      color("red") cylinder(h=(brake_length2(p)*0.75), d=steel_thickness(p));
    }

}

//
// joist
module joist(p, Xpos) {
  translate([Xpos, 0, deck_thickness(p)*2]) 
    cube([stringer_thickness(p), car_width(p), stringer_depth(p)*1.25]);
}

//
// stringer
module stringer(p, Xpos, Ypos, length) {
  translate([Xpos, Ypos-(stringer_thickness(p)/2), deck_thickness(p)*2]) 
    cube([length, stringer_thickness(p), stringer_depth(p)]);
}

//
// center_sill
module center_sill (p, Xpos1, Xpos2) {
  difference() {
    union() {  
      hull() {
        translate([Xpos1+(side_sill_angle_length(p)/4), (bolster_width(p)/2)-(center_sill_width(p)/2), deck_thickness(p)*2]) 
          cube([Xpos2-Xpos1-side_sill_angle_length(p)/2, center_sill_width(p), center_sill_lo_depth(p)]);
        translate([Xpos1+(side_sill_angle_length(p)), (bolster_width(p)/2)-(center_sill_width(p)/2), deck_thickness(p)*2]) 
          cube([Xpos2-Xpos1-side_sill_angle_length(p)*2, center_sill_width(p), center_sill_hi_depth(p)]);
      }
    translate([Xpos1, (bolster_width(p)/2)-(center_sill_width(p)/2), deck_thickness(p)*2]) 
      cube([Xpos2-Xpos1, center_sill_width(p), center_sill_lo_depth(p)]);
   }
   translate([Xpos1, (bolster_width(p)/2)-(center_sill_width(p)/2)+(center_sill_thickness(p)/2), deck_thickness(p)*2]) 
    cube([Xpos2-Xpos1, center_sill_width(p)-center_sill_thickness(p), center_sill_hi_depth(p)+center_sill_thickness(p)]);
  }
}

//
// bolster
module bolster(p, Xpos) {
  difference() {
    translate([Xpos, 0, deck_thickness(p)])
    {
      hull()
      {
        cube([bolster_length(p), bolster_width(p), deck_thickness(p)]);
        translate([0,(bolster_width(p)/2)-(bolster_length(p)/2),deck_thickness(p)]) 
          cube([bolster_length(p), bolster_length(p), bolster_depth(p)]);
      }
    }
    translate([Xpos+(bolster_length(p)/2), (bolster_width(p)/2), deck_thickness(p)])
      cylinder(h=30, r=bolster_pin_radius(p), center=true);
  }
}

module chassis(p) {
  translate([0, 0, 0]) cube([car_length(p), car_width(p), deck_thickness(p)]);
  translate([bolster_setback(p)+bolster_length(p), 0, deck_thickness(p)]) cube([center_sill_length(p), car_width(p), deck_thickness(p)]);
  bolster(p, bolster_setback(p));
  bolster(p, car_length(p)-bolster_setback(p)-bolster_length(p));
  center_sill (p, center_sill_Xpos(p), center_sill_Xpos(p)+center_sill_length(p));
  for(x = [1 : 1 : 3]) {
    stringer(p, center_sill_Xpos(p),stringer_Ypos(p)*x,center_sill_length(p));
    stringer(p, center_sill_Xpos(p),car_width(p)-(stringer_Ypos(p)*x),center_sill_length(p));
  }
  for(x = [0 : 1 : 3]) {
    joist(p, center_sill_Xpos(p)+bolster_setback(p)+(joist_space(p)*x));
    joist(p, center_sill_Xpos(p)+center_sill_length(p)-bolster_setback(p)-(joist_space(p)*x));
  }
  westinghouse_brakes (p);
}

module car_floor(p) {
  difference() {
    chassis(p);
    translate([(car_length(p)/2)-(weight_length(p)/2), (car_width(p)/2)-(weight_width(p)/2), -0.1]) cube([weight_length(p), weight_width(p), weight_depth(p)+0.1]);
  }
  for(Xpos = [center_sill_Xpos(p)+support_x_spacing(p) : support_x_spacing(p) : center_sill_Xpos(p)+center_sill_length(p)-support_x_spacing(p)]) 
    for(Ypos = [(car_width(p)/2)-(weight_width(p)/2)+(weight_width(p)/(support_y_spacing(p)*2)) : weight_width(p)/support_y_spacing(p): (car_width(p)/2)+(weight_width(p)/2)]) 
      support(Xpos, Ypos, weight_depth(p));
}