import controlP5.*;
ControlP5 cp5;
Table csvTable;
String[] jsCodes;
boolean init = true;
String csvFile = "";
String jsFile = "";
String componentName = "test";
String action = "write";
String pinType = "analog";

void setup() {
  size(800,800);
  cp5 = new ControlP5(this);
  PFont font = createFont("arial",20);
  //ControlFont font = new ControlFont(createFont("Roboto-Medium",16));
  // create a new button with name 'buttonA'
  cp5.addButton("OpenCSVfile")
     .setValue(1)
     .setPosition(50,50)
     .setSize(200,30)
     .setCaptionLabel("Open csv file")
     //.setFont(font)
     ;
  cp5.addButton("OpenJSfile")
     .setValue(1)
     .setPosition(50,100)
     .setSize(200,30)
     .setCaptionLabel("Open js file")
     ;
  //cp5.addButton("Add")
  //   .setValue(0)
  //   .setPosition(50,150)
  //   .setSize(200,30)
  //   ;
  //cp5.addButton("Save")
  //   .setValue(0)
  //   .setPosition(50,200)
  //   .setSize(200,30)
  //   .setCaptionLabel("Save Results");
  //   ;
     
  cp5.addTextfield("InputForComponentName")
     .setCaptionLabel("")
     .setPosition(20,170)
     .setSize(200,40)
     .setFont(createFont("arial",14))
     .setAutoClear(false)
     .setColor(color(255,0,0))
     .setFocus(true)
     ;
       
  cp5.addBang("Add")
     .setPosition(240,170)
     .setFont(createFont("arial",14))
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addBang("Save")
     .setPosition(340,170)
     .setFont(createFont("arial",14))
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
  
  //cp5.addTextfield("default")
  //   .setPosition(20,350)
  //   .setAutoClear(false)
  //   ;
     
  textFont(font);
  init = false;
}

void draw() {
  fill(0);
  textSize(14);
  text(csvFile, 260, 70);
  text(jsFile, 260, 120);
  fill(255);
  //text(cp5.get(Textfield.class,"Component").getText(), 20, 130);
  componentName = cp5.get(Textfield.class,"InputForComponentName").getText();
  //text(Component, 360,180);
}

//public void Add() {
//  cp5.get(Textfield.class,"Component").clear();
//}

//public void Save() {
//  cp5.get(Textfield.class,"Component").clear();
//}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}


public void InputForComponentName(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}

public void Add() {
  if(!init) {
    TableRow foundRow = csvTable.findRow(componentName, 0);
    //if(foundRow.getString(0).equals(componentName)){
    //  println("The "+ componentName + " is already exists");
    //} else {
      csvTable.setString(csvTable.lastRowIndex()+1,0,componentName);
      
      for(int i=0; i<jsCodes.length; i++) {
        if(jsCodes[i].contains("DO NOT REMOVE THIS COMMENT: function handleHWTest")) {
          
          String code = "\t\tcase \""+componentName+"\":\n\t\t\tcomponent = "
          + "\"" + componentName + "\""
          +";\n\t\t\tintentObj.attributes.action = "
          + "\"" + action + "\""
          +";\n\t\t\tintentObj.attributes.pinType = "
          + "\"" + pinType + "\""
          +";\n\t\t\tspeechOutput = \"Let's check the\"" + " + component + "
          +"\" is working. Tell me the pin number of Arduino you used.\""
          +";\n\t\t\tintentObj.emit(\':ask\', speechOutput)"
          +";\n\t\t\tbreak"+";";
          jsCodes = splice(jsCodes, code, i+1);
        }
      }
    //}
  }
}

public void Save() {
  if(!init) {
    saveTable(csvTable, "result/newComponentList.csv");
    saveStrings("result/index.js", jsCodes); 
  }
}

public void OpenCSVfile(int theValue) {
  if(!init)
    selectInput("Select a csv file to process:", "csvFileSelected");
}

public void OpenJSfile(int theValue) {
  if(!init)
    selectInput("Select a js file to process:", "jsFileSelected");
}

void csvFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if(selection.getPath().contains("csv")) {
      csvTable = loadTable(selection.getAbsolutePath());
      csvFile = selection.getPath();
    } else {
      csvFile = "Please, select the csv File";
    }
  }
}

void jsFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if(selection.getPath().contains("js")) {
      jsCodes = loadStrings(selection.getAbsolutePath());
      jsFile = selection.getPath();
    } else {
      jsFile = "Please, select the js File";
    }
  }
}
