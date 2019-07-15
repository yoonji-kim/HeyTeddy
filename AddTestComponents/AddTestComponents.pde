import controlP5.*;
ControlP5 cp5;
Table csvTable;
String[] jsCodes;
Textarea componentList;
boolean init = true;
String csvFile = "Load the csv file";
String jsFile = "Load the js file";
String componentName = "test";
String action = "write";
String pinType = "analog";
String componentListStr = "Open the csv file to load the existing components list.";
String componentDuplicateCheck = "";
String saveResult = "";
boolean csvFileLoaded = false;
boolean jsFileLoaded = false;
boolean duplicated = false;
boolean addComponent = false;

PFont myFont;

void setup() {
  size(800,800);
  cp5 = new ControlP5(this);
  myFont = createFont("Arial",14, true);
  
  //String[] fontList = PFont.list();
  //for(int i=0; i<fontList.length/2; i++)
  //  println(fontList[i]);
  //ControlFont font = new ControlFont(createFont("Roboto-Medium",16));
  // create a new button with name 'buttonA'

     
  cp5.addButton("OpenJSfile")
     .setValue(1)
     .setPosition(50,50)
     .setSize(200,30)
     .setCaptionLabel("Open js file")
     .setFont(myFont)
     ;
     
  cp5.addButton("OpenCSVfile")
     .setValue(1)
     .setPosition(50,100)
     .setSize(200,30)
     .setCaptionLabel("Open csv file")
     .setFont(myFont)
     ;
     
  componentList = cp5.addTextarea("txt")
                     .setPosition(50,200)
                     .setSize(200,200)
                     .setFont(myFont)
                     .setLineHeight(16)
                     .setColor(color(128))
                     .setColorBackground(color(255,100))
                     .setColorForeground(color(255,100))
                     ;
     
  cp5.addTextfield("InputForComponentName")
     .setCaptionLabel("")
     .setPosition(50,150)
     .setSize(200,30)
     .setFont(myFont)
     .setAutoClear(false)
     .setColor(color(255,0,0))
     .setFocus(true)
     ;
       
  cp5.addButton("Add")
     .setPosition(280,150)
     .setFont(myFont)
     .setSize(80,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addButton("Save")
     .setPosition(50,450)
     .setFont(myFont)
     .setSize(90,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  cp5.addButton("Cancel")
     .setPosition(160,450)
     .setFont(myFont)
     .setSize(90,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
    
  //cp5.addSlider("changeWidth")
  //   .setRange(100,400)
  //   .setValue(200)
  //   .setPosition(100,20)
  //   .setSize(100,19)
  //   ;
     
  //cp5.addSlider("changeHeight")
  //   .setRange(100,400)
  //   .setValue(200)
  //   .setPosition(100,40)
  //   .setSize(100,19)
  //   ;
     
  textFont(myFont);
  init = false;
}

void draw() {
  background(0);
  textFont(myFont);       
  fill(255);
  //textAlign(LEFT);
  //text("This text is left aligned.",width/2,100); 
  text(jsFile, 280, 70);
  text(csvFile, 280, 120);
  text(componentDuplicateCheck, 380, 170);
  text(saveResult, 50, 520);
  fill(255);
  //text(cp5.get(Textfield.class,"Component").getText(), 20, 130);
  componentName = cp5.get(Textfield.class,"InputForComponentName").getText();
  componentList.setText(componentListStr);
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
    if(csvFileLoaded && jsFileLoaded) {
      
      for(int i=0; i<csvTable.getRowCount(); i++) { //<>//
        if(duplicated) break;
        for(int j=0; j<csvTable.getColumnCount(); j++) {
          String tableData = csvTable.getString(i,j);
          if(tableData != null) {
            String temp[] = split(tableData, ' ');
            String tableDataNoSpace = "";
            for(int k=0; k<temp.length; k++)
              tableDataNoSpace += temp[k].trim();
            if(componentName.toLowerCase().equals(tableData.toLowerCase()) || componentName.toLowerCase().equals(tableDataNoSpace.toLowerCase())) {
              duplicated = true;
              break;
            } else {
              duplicated = false;
            }
          }
        }
      }

      if(duplicated) {
        componentDuplicateCheck = "The "+ componentName + " already exists.";
        addComponent = false;
      } else {
        csvTable.setString(csvTable.lastRowIndex()+1,0,componentName);
        componentListStr += componentName + "\n";
        
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
      }
      addComponent = true;
    } else {
      componentDuplicateCheck = "Load csv and js file.";
      addComponent = false;
    }
  }
}

public void Save() {
  if(!init) {
    if(addComponent) {
      saveTable(csvTable, "componentList.csv");
      saveStrings("index.js", jsCodes); 
      saveResult = "Saved.";
    } else {
      saveResult = "There is no change.";
    }
  }
}

public void Cancel() {
  if(!init) {
    exit();
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
      saveTable(csvTable, "componentList_bak.csv");
      
      csvFile = selection.getPath();
      componentListStr = "";
      for(int i=0; i<csvTable.getRowCount(); i++)
        componentListStr += csvTable.getString(i, 0)+"\n";
      componentList.setText(componentListStr);
      
      csvFileLoaded = true;
    } else {
      csvFile = "Please, select the csv File";
      csvFileLoaded = false;
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
      saveStrings("index.js.bak", jsCodes); 
      jsFile = selection.getPath();
      jsFileLoaded = true;
    } else {
      jsFile = "Please, select the js File";
      jsFileLoaded = false;
    }
  }
}

//void changeWidth(int theValue) {
//  componentList.setWidth(theValue);
//}

//void changeHeight(int theValue) {
//  componentList.setHeight(theValue);
//}
