/*------------------------------------------------------------------------------
 Modeler LScript: ASE Spline Import
 Version: 1.1
 Author: Johan Steen
 Author URI: http://www.artstorm.net/
 Date: 17 Feb 2010
 Description: Imports Splines from an Autodesk .ASE file from 3ds Max

 Copyright (c) 2008-2010,  Johan Steen
 All Rights Reserved.
 Use is subject to license terms.
------------------------------------------------------------------------------*/

@version 2.4
@warnings
@script modeler
@name "JS_ASESplineImport"

// global values go here
reqTitle = "ASE Spline Import v1.1";
cfgFile = getdir(SETTINGSDIR) + getsep() + "JS_ASESplineImport.cfg";
fileName = getdir("Objects") + "\\*.ASE";
layerName = "Imported Guides";
nameLayer = true;
scaleImport = false;
scaleFactor = 1.0;

main
{
    // Load the settings from the config dir
    loadSettings();

    // Open the GUI to collect information
    if (!openGUI()) return;

    // Save the settings to the config dir
    saveSettings();

    // Open the selected file
    importFile = File(fileName,"r");
    if (!importFile) error("Couldn't find the file. Sayonara... Exiting... Try again.");

    // Select next empty layer for the import
    setEmptyLayer();


    //
    // Parse through the file to build the splines in LightWave
    // --------------------------------------------------------------------------------
    lineNumber = 1;
    cid = 1;
    pid = nil;
    is = 1.5;

    selmode(USER);
    moninit(importFile.linecount(), "processing...");
    editbegin();
    while (!importFile.eof()) {
        importFile.line(lineNumber);
        lineread = importFile.read();
        lineArray = importFile.parse("\t");                     // 1 = name, 2 = ??, 3 = X, 4 = Z, 5 = Y

        // If reached the end of a spline, and new points exists
        if (lineArray[1] == "}" && pid != nil) {
            // Create a curve from selected points
            addcurve(pid);
            cid = 1;
            pid = nil;
        }

        // If a vertex point is found, add it (skipping interpolated points)
        if (lineArray[1] == "*SHAPE_VERTEX_KNOT") {
            // Get the coordinates for the vertex. Swapping Y and Z because of 3dsmax coord system
            pnt_x = lineArray[3];
            pnt_y = lineArray[5];
            pnt_z = lineArray[4];
            if (scaleImport) {
                pnt_x = string(number(pnt_x) * scaleFactor);
                pnt_y = string(number(pnt_y) * scaleFactor);
                pnt_z = string(number(pnt_z) * scaleFactor);
            }
            newPoint = vector(pnt_x + " " + pnt_y + " " + pnt_z);
            pid[cid] = addpoint(newPoint);
            cid++;
        }
        lineNumber++;
        if (monstep()) {
            editend(ABORT);
            return;
        } // End If
    }
    editend();
    monend();
    importFile.close();
}

/*
** Function to open a Requester and collect user information for the import
**
** @returns     Boolean if the requester was canceled or not
*/
openGUI
{
    reqbegin(reqTitle);
    reqsize(280,150);

    // File Button
    c1 = ctlfilename("Filename",fileName,35,1);
    ctlposition(c1,14,16);
    // Checkbox for layer naming
    c2 = ctlcheckbox("Name New Layer",nameLayer);
    ctlposition(c2,14,50);
    // Textfield for layer name
    c3 = ctlstring("Name",layerName, 96);
    ctlposition(c3,140,50);
    // Checkbox for import scale
    c4 = ctlcheckbox("Scale Import",scaleImport);
    ctlposition(c4,14,80);
    c5 = ctlnumber("Factor",scaleFactor);
    ctlposition(c5,138,80, 126);

    // Interactivity
    ctlactive(c2,"toggleOptions",c3);     // Toggle layer name updates
    ctlactive(c4,"toggleOptions",c5);     // Toggle layer name updates

    // Handle exiting of the requester
    if (!reqpost()) return false;

    fileName = getvalue(c1);
    nameLayer = getvalue(c2);
    layerName = getvalue(c3);
    scaleImport = getvalue(c4);
    scaleFactor = getvalue(c5);

    reqend();
    return true;
}

// Updating if the option box is active or not
toggleOptions: value
{
    return(value);
}

/*
** Function to find first empty layer, select it and name it.
**
** @returns     Nothing
*/
setEmptyLayer
{
    layerArray = lyrempty();                // Get array of empty layers
    layerArray.sortA();                     // Sort it in Ascending order
    lyrsetfg(layerArray[1]);                // Set the first empty layer as active  
    if (nameLayer) setlayername(layerName); // Give the layer a proper name, if the user wants that.
}

/*
** Function to load and save the settings from a file.
**
** @returns     Nothing
*/
loadSettings
{
    // Open file
    loadCfg = File(cfgFile,"r");

    // Check file was opened
    if(loadCfg)
    {
        // Loop through file until end
        while( !loadCfg.eof() )
        {
            // Add line from file into array ...
            cfg_array += loadCfg.read();
        }
        // Close file
        loadCfg.close();

        // If the array was complete, populate the settings.
        if (cfg_array.size() == 5) {
            fileName = cfg_array[1];
            layerName = cfg_array[2];
            nameLayer = number(cfg_array[3]);
            scaleImport = number(cfg_array[4]);
            scaleFactor = number(cfg_array[5]);
        }
    }
}

saveSettings
{
    // Open file
    saveCfg = File(cfgFile,"w");

    // Check if the file was opened
    if(saveCfg)
    {
        saveCfg.writeln( fileName );
        saveCfg.writeln( layerName );
        saveCfg.writeln( nameLayer );
        saveCfg.writeln( scaleImport );
        saveCfg.writeln( scaleFactor );
    }
    // Close file
    saveCfg.close();
}
