import processing.serial.*;

Serial mySerial;

String myString=null; //variable to collect
int nl =10; //ASCII code for carage return in serial
float myVal; //fload for string converted ASCII serial data
Table table; //call for table

void setup() {
  
  
  //link processing to serial
  String myPort = Serial.list() [1];
  mySerial = new Serial(this, myPort, 9600);
  //prepare the columns of table
  table = new Table();
  table.addColumn("id");
  table.addColumn("Time(millis)");
  table.addColumn("Temp1");
  table.addColumn("Temp2");
  table.addColumn("HIndex");
}

void draw () {
  while (mySerial.available()>0) {
    myString = mySerial.readStringUntil(nl);
    
    if (myString != null) {
      background(0);
      myString = trim(myString);
      //if we have one sensor value
     // myVal = float (myString); //takes data from serial and takes into number
      //println(myVal);
      
      //as we have three, need to be separated by the comma
      float sensors[] = float(split(myString, ','));
      //debug, what happend
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
  print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
      //put the values in the columns with indexing
    TableRow newRow = table.addRow();
    newRow.setInt("id", table.lastRowIndex());
    newRow.setFloat("Time(millis)", sensors[0]);
    newRow.setFloat("Temp1", sensors[1]);
    newRow.setFloat("Temp2", sensors[2]);
    newRow.setFloat("HIndex", sensors[3]);
}
// add a linefeed at the end:
println();
    }
    }
    //save table, name it as you want
     saveTable(table, "data/new.csv");


}
