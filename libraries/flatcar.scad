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


// //
// // car_body
// module flat_car_body() {
  
//   side_sill(0,1);
//   side_sill(car_width-stringer_thickness,0);

//   for(x = [0 : 1 : Pockets_per_Side-1]) {
//     pocket((x*pocket_spacing)+(pocket_spacing/2)+((pocket_hole-pocket_wall)/2), 0-pocket_hole-pocket_wall, 0);
//     pocket((x*pocket_spacing)+(pocket_spacing/2)+((pocket_hole-pocket_wall)/2), car_width-pocket_wall, 0);
//   }
// }



module flatcar(p) {
  car_floor(p);
}
