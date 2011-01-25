--------------------------------------------------------------------------------
 ASE Spline Import - README

 ASE Spline Import imports curves via Autodesks ASCII Scene Export, .ASE files 
 into Modeler.

 Website:      http://www.artstorm.net/plugins/ase-spline-import/
 Project:      http://code.google.com/p/js-lscripts/
 Feeds:        http://code.google.com/p/js-lscripts/feeds
 
 Contents:
 
 * Installation
 * Usage
 * Source Code
 * Changelog
 * Credits

--------------------------------------------------------------------------------
 Installation
 
 General installation steps:

 * Copy the JS_ASESplineImport.lsc to LightWave's plug-in folder.
 * If "Autoscan Plugins"
   is enabled, just restart LightWave and it's installed.
 * Else locate the "Add Plugins" button in LightWave and add it manually.
 
 I'd recommend to add the tool to a convenient spot in your modeler's menu, so 
 all you have to do is press the button when you need to use the tool. I have 
 located the button on my Hair Tab in Modeler and named it Import Splines.

--------------------------------------------------------------------------------
 Usage

 This tool is quite straight forward to use, but here is a quick guide 
 just for the sake of it.

 Filename: The .ASE file to import. The arrow on the right opens a file 
 browser, which defaults to the objects folder in the current content 
 directory.

 Name New Layer: The .ASE file imports in the next empty layer and 
 places the curves there. If this box is checked the new layer gets the 
 name typed into the textfield next to it.

 Scale Import: Let’s you scale the splines by a factor of your choice
 to easier match the import with packages using other scaling units than
 LightWave 3D.

 That's pretty much it. Hope some of you find this tool useful.

--------------------------------------------------------------------------------
 Source Code
 
 Download the source code:
 
   http://code.google.com/p/js-lightwave-lscripts/source/checkout

 You can check out the latest trunk or any previous tagged version via svn
 or explore the repository directly in your browser.
 
 Note that the default checkout path includes all my available LScripts, you
 might want to browse the repository first to get the path to the specific
 script's trunk or tag to download if you don't want to get them all.
 
--------------------------------------------------------------------------------
 Changelog

 * v1.1 - 17 Feb 2010
   * Added an option to scale the imported splines.
   * Added a .cfg file located in LightWave's config folder to store the settings
     between sessions.
 * v1.0 - 29 Dec 2008
   * Release of version 1.0, first public release.   
   
--------------------------------------------------------------------------------
 Credits

 Johan Steen, http://www.artstorm.net/
 * Original author
 
 