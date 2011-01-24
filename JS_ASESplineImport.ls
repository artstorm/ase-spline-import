// ******************************
// Modeler LScript: Import splines from Autodesk ASCII Scene Export (.ASE)
// Version: 1.0
// Author: Johan Steen
// Date: 28 Dec 2008
// Description: Imports Splines from an Autodesk .ASE file from 3ds Max
//
// http://www.artstorm.net
// ******************************

@version 2.4
@warnings
@script modeler
@name "JS_ASESplineImport"

// global values go here
reqTitle = "ASE Spline Import v1.0";
fileName = getdir("Objects") + "\\*.ASE";
layerName = "Imported Guides";
nameLayer = true;

main
{
    // Open the GUI to collect information
    if (!openGUI()) return;

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
            newPoint = vector(lineArray[3] + " " + lineArray[5] + " " + lineArray[4]);  // Swapping Y and Z because of 3dsmax coord system
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
    reqsize(280,130);

    // File Button
    c1 = ctlfilename("Filename",fileName,35,1);
    ctlposition(c1,14,16);
    // Checkbox for layer naming
    c2 = ctlcheckbox("Name New Layer",nameLayer);
    ctlposition(c2,14,60);
    // Textfield for layer name
    c3 = ctlstring("Name",layerName, 96);
    ctlposition(c3,140,60);

    // Interactivity
    ctlactive(c2,"toggleLayerName",c3);     // Toggle layer name updates

    // Handle exiting of the requester
    if (!reqpost()) return false;

    fileName = getvalue(c1);
    nameLayer = getvalue(c2);
    layerName = getvalue(c3);

    reqend();
    return true;
}

// Updating if the layer name is active or not
toggleLayerName: value
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
