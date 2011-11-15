PImage theImage;
float feedRate = 80;
float depth = 0.5;
float clearance = 0.75;
float pixelDim = 0.006;
int stepover = 8;

float xPos;
float yPos;
float zPos;

Data gCodeFile;

void setup( ) {
      gCodeFile = new Data();
      frameRate(120);
      theImage = loadImage( dataPath( "green-man-bw.jpg" ) );
      gCodeFile.beginSave();
      
      gCodeFile.add( "G20 G90 G40" );
      gCodeFile.add( "G0 Z0.25" );
      gCodeFile.add( "T0 M6" );
      gCodeFile.add( "G17" );
      gCodeFile.add( "M3" );
      
       for ( float y = stepover; y < theImage.height; y += stepover ) {
            for ( float x = stepover; x < theImage.width; x++ ) {
                  xPos = x * pixelDim;
                  yPos = y * pixelDim;
                  float zVal = brightness( theImage.pixels[ int(y) * theImage.width + int(x) ] );
                  zPos = map( zVal, 0, 255, 0, depth );
                  
                  gCodeFile.add( "G1 X" + xPos + " Y" + yPos + " Z" + zPos + " F" + feedRate );
                  //println("X" + xPos + " Y" + yPos);
            }
            gCodeFile.add( "G1 Z" + clearance + " F" + feedRate );
            gCodeFile.add( "G0 " + "X " + 0 + " Y" + yPos);
      }
      
      gCodeFile.add( "M5" );
      gCodeFile.add( "M30" );
      
      String datestamp = year() + "_" + 
                         nf( month(), 2 ) + "_" + 
                         nf( day(), 2 ) + "_" + 
                         nf( hour(), 2 ) + "_" + 
                         nf( second(), 2 );
                         
      gCodeFile.endSave( dataPath( "gCode-" + datestamp +  ".nc" ));
}

void draw( ) {
      
}

