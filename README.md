# Car-Creator
 Create Custom Railroad Freight Cars

## Summary

When you make trees for your layout, some are very detailed used as a focus point for a scene. Others are just puffballs to create the look and feel of trees in the distance. The cars that are created by this program are the puffball trees of you car collection. They are not highly detailed stars of the scene, they are the background to fill out and add depth to your collection. They are not a precise model of any prototype but are intended to look like typical cars that fill out a scene. I have tried to make them look as good as I can, based on prototype photos, but they are intentionally generic. This is intended as a way to produce a large number of cars inexpensively. We don't have Blue Box models any more, so I made this.

This program has a lot of parameters. I have tried to make the default values be pretty good choices for most of them. I model in N-Scale so most choices are ones that produce cars that I like in N-Scale. I have also tested fairly thourghly in HO Scale. I print on a resin printer so size is limited. Z, S, O, and G Scales are supported, but many of the values have not been tested and may not even work. Feel free to make changes to support other scales that I have not gotten around to. If you do, please report back to me so that your better values can be incorporated into the main code.

## Printing
I have the best luck printing these on a resin printer directly on the build plate without any extra supports beyond the ones that are supplied if _Use Supports_ is turned on. I have not tested them on a FDM printer. If you do, let me know how it turns out. 

## Parameters
The default values are ones that I think make a good looking car. You can choose what you like. Most are self explainitory. 

### _Scale_
This controls which scale will be produced. Scales supported at present are Z, N, HO, S, O, and G. I use a resin printer for testing, so N and HO have been used for testing. Other scales will work, but many of the internal parameters have not been set to proper values. That remains to be done and is one area that others can help with.

### _Car Type_
This selects the kind of car that will be generated. At present only flatcars and gondolas have been implemented. As other types are added, they will be added to this list.

### _Car Length in Feet_, _Car Width in Feet_, and _Car Height in Feet_
These set the overall dimensions of the car that is generated. All of these dimensions are given in prototype dimensions. Appropriate scaling is done within the program.

## Car Features
These control aspects of the model itself.

  * **_Side Sill Depth in Inches_**: .
  * **_Side Sill Thickness in Inches_**: .
  * **_Fish Belly Depth in Inches_**: .
  * **_Fish Belly Angle Length in Feet_**: .
  * **_Pockets per Side_**: On flatcars this will set the number of stake pockets. On gondolas, this will control the number vertical ribs.
  * **_Truck Height in Inches_**: This is the height from the rail head up to the top of the truck where it sits on the bolster. If _Use Body Mount Couplers_ is off, this will have no effect.
  * **_Bolster Height in Inches_**: This is the height of the bolster. Something in the area of 18 inches works well. 
  * **_Use Body Mount Couplers_**: This will produce a mounting point for coupler mountings. I designed using Kadee #5 with standard trucks in HO and MicroTrains 1015 couplers and standard trucks in N Scale. I have not tested in any other scale. If this is off it will produce a car suitable for truck mounted couplers. In N Scale truck mounted couplers are common, but in HO body mounted couplers seem to be preffered.

## Layout
These control things about generating the model for printing.

  * **_Space Between Car Parts_**: This controls the separation between the parts of the model.
  * **_Fudge Factor in Inches_**: Adds a small additional space to the walls of the model so that the floor can fit between them. This is needed because 3d printers often have a little spread around the parts. I use about 2 inches.
  * **_Show Rivets_**: This is not currently implemented. 
  * **_Use Supports_**: This controls whether the supports are generated. For printing on a resin printer it is best to have this turned on. When using an FDM it might be best to turn it off. If this is off, the user will need to supply supports where needed.
