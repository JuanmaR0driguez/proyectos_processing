
import processing.serial.*;
import processing.sound.*;

Serial myPort;  // The serial port

SoundFile kick;
SoundFile snare;

void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  
  kick = new SoundFile(this, "kick.mp3");
  snare = new SoundFile(this, "snare.mp3");
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 230400);
}

void draw() {
  while (myPort.available() > 0) {
    char inByte = myPort.readChar();
    println(inByte);
    if(inByte == '0'){
    kick.play(1,0.05);
    }
    else if(inByte=='1'){
    snare.play(1,0.05);
    }
    else if(inByte == '2'){
      snare.play(1,0.05);
      kick.play(1,0.05);
    }
  }
}
