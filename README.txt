ASE Spline Import
=================
LightWave Modeler LScript by Johan Steen.


Description
===========
I grew tired of fighting with editing hair guides in LightWave 3D, 
especially as I have access to more applications than LightWave. I 
like the hair styling tools in 3ds Max, but I couldn’t find an easy 
way to move splines from 3ds Max into LightWave, as no format I tried 
seemed to handle splines between the applications. Finally I grew 
tired of finding an out of the box solution for moving splines into 
LightWave, which gave birth to this importer.

This tool imports curves via Autodesks ASCII Scene Export, .ASE files 
into Modeler.

The importer strips everything from the .ASE file except splines. I 
could probably extend the importer to handle the other elements in the 
format as well, but I didn’t personally see the need for that, as there 
already are many other options available for that like FBX/Collada/Obj.

I also decided to only import the vertex knots from the .ASE file and 
not the interpolation knots when building the curves in LightWave, as 
I found them only adding unnecessary clutter and not keeping the curves 
as clean as they come in now. If there is any reason the keep the 
interpolation knots, feel free to drop me a note and I might add an 
extra option for that.


Usage
=====
This tool is quite straight forward to use, but here is a quick guide 
just for the sake of it.

Filename: The .ASE file to import. The arrow on the right opens a file 
browser, which defaults to the objects folder in the current content 
directory.

Name New Layer: The .ASE file imports in the next empty layer and 
places the curves there. If this box is checked the new layer gets the 
name typed into the textfield next to it.

That's pretty much it. Hope some of you find this tool useful.


Installation
============
* Copy the JS_ASESplineImport.lsc to LightWave's plug-in folder.
* If "Autoscan Plugins" is enabled, just restart LightWave and it's installed.

* Else locate the "Add Plugins" button in LightWave and add it manually.

I'd recommend to add the tool to a convenient spot in your modeler's menu, so 
all you have to do is press the button when you need to use the tool. I have 
located the button on my Hair Tab in Modeler and named it Import Splines.


Author
======
This tool is written by Johan Steen.
Contact me through http://www.artstorm.net/


History
=======
v1.0 - 29 Dec 2008:
  * Release of version 1.0, first public release.


Disclaimer / Legal Stuff
========================
ASE Spline Import is freeware. 
Please do not distribute or re-post this 
tool without the author's permission.

ASE Spline Import is provided "as is" without 
warranty of any kind, either express or implied,
no liability for consequential damages.

By installing and or using this software
you agree to the terms above.

Copyright © 2008 Johan Steen.