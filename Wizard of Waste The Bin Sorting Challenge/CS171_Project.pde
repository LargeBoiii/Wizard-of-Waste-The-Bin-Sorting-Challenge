import controlP5.*;
ControlP5  cp5;

int correctBin = -1;   //value used to store which bin is right
int score = 0;         //keep track of score
int lives = 3;         //keep track of lives
int currentItem = -1;  //row of currently displayed item in csv file 

PImage img;            //image to display picture of current item
PImage wizard;         //image to show the wizard in the bottom right   source: https://knowyourmeme.com/photos/2238755-pondering-my-orb
PImage wizardSmall;
PImage textBubble;     //text bubble speech is placed in                source: https://www.pngwing.com/en/free-png-ddmoy

PFont Font;            //creating font object
PFont FontBig;         //creating 2nd font object to allow for different text size
PFont FontSmall;
Table  table;          //create new table object


void setup()
{
  size(1900,1050); 
  surface.setTitle("Wizard of Waste: The Bin Sorting Challenge");  
  surface.setIcon(loadImage("wizardHat.png"));                      //Original Source: https://oldschool.runescape.wiki/w/Fremennik_hat                                                                                     
  Font = createFont("i do not trust you.ttf", 50);                  //Source: https://all-free-download.com/font/download/i_do_not_trust_you_6918784.html
  FontBig = createFont("i do not trust you.ttf", 96);  
  FontSmall = createFont("i do not trust you.ttf", 40);
  
  cp5 = new ControlP5(this);    //instantiating controlp5 object
   
  cp5.addButton("BinR")         //adding a new cp5 button, setting its position and setting it to use the correct images for its use.       
    .setPosition(50,500)
    .setImages(loadImage("RecyclingBin.png"),loadImage("RecyclingBinHover.png"),loadImage("RecyclingBin.png"))
    .updateSize()
    .setValue(1f);             //this value is used for comparing against the correct anwser, which is gotten from reading the csv file
    
 cp5.addButton("BinW")
    .setPosition(390,500)
    .setImages(loadImage("WasteBin.png"),loadImage("WasteBinHover.png"),loadImage("WasteBin.png"))
    .updateSize()
    .setValue(2f);
    
 cp5.addButton("BinC")
    .setPosition(730,500)
    .setImages(loadImage("CompostBin.png"),loadImage("CompostBinHover.png"),loadImage("CompostBin.png"))
    .updateSize()
    .setValue(3f);

  wizard = loadImage("pondering.png");
  wizardSmall = loadImage("ponderingSmall.png");
  textBubble = loadImage("textBubble.png");
  
  lives = 3;       //reset lives and score to correct values to counteract buttons sending events at run for some reason, this fixes the game starting with incorrect lives left and score
  score = 0;
  updateGame();    //call updateGame at setup to generate first object
  
} 

void draw()
{
  background(146,142,133);
  textFont(FontBig);                    //setting bigger font for lives and score 
  textAlign(BASELINE,BASELINE);         //resetting text allignment to default at start of new draw
  fill(94,91,85);
  rect(85,15,360,200,5);                //score bg
  rect(25,475,1020,505,5);              //bin bg
  rect(25,375,1020,75,5);               //bin title bg
  fill(255);
  text("Score: " + score, 100,100);
  text("Lives: " + lives, 100,200);
  
  image(wizard,1100,310,800,750);
  image(img,1340,655);
  image(textBubble,1080,15);

  textFont(Font);                        //switching fonts to make text fit inside the text box
  text("Apprentice, which bin would you place", 1125,110);
  text(table.getString(currentItem, "Display name") + " Into?", 1125, 150);
  textAlign(CENTER,BOTTOM);              //alligning text, made placing it in the right spot easier 
  text("Recycling",205,440);             //bin titles
  text("Waste", 540,440);
  text("Compost", 875,440);
  
  //game over condition
  if(lives < 1)                  
  {
    cp5.hide();                  //hide all buttons
    //draw all ui elements
    background(94,91,85);        
    fill(146,142,133);
    rect(50,50,1800,950,5);
    fill(255);
    textFont(FontBig);
    text("Game Over", 950,150);
    strokeWeight(3);
    stroke(255);
    line(750,140,1150,140);
    strokeWeight(2);
    stroke(255);
    image(wizardSmall,width/2-321,411);
    image(textBubble,560,150);
    textFont(FontSmall);
    
    if(score == 0)                //displaying different game over messages based on players performance
    {
      text("How dare you call yourself my apprentice,  a score of 0 is unacceptable.",650,130,600,200);
    }
    else if(score < 15)
    {
      text("A poor peformance, you only scored " + score + ". You have a long way to becoming a Wizard of waste",650,140,600,200);
    }
    else if(score < 31)
    {
      text("Good job apprentice, you scored " + score + " . You're on your way to mastering the magic of waste managment.",650,120,600,200);
    }
    else
    {
     text("Truly impressive, a score of " + score + ". You have really earned the title of Wizard of Waste.", 690,140,500,200);
    }
  } 
 
}

public void updateGame()              //function that is called to update to next object from csv file
{                                    
  table = loadTable("ItemList.csv","header");        //data for proper waste managment was mostly sourced from https://www.mywaste.ie/page-what-to-do-with/
  currentItem = (int)random(0,40);  
  correctBin = table.getInt(currentItem, "Correct Bin");
  img = loadImage(str(currentItem) + ".png");               
}

//functions that listen for events from bin buttons, check whther a correct guess was made then update the game and adjust score and lives
public void BinR(int theValue)      
{                                  
 if(theValue == correctBin)
   {
     score++;                                     
   }
   else
   {
     lives--;
   }
   updateGame();
}

public void BinW(int theValue)
{
 if(theValue == correctBin)
   {
     score++;
   }
   else
   {
     lives--;
   }
   updateGame();
}

public void BinC(int theValue)
{
 if(theValue == correctBin)
   {
     score++;
   }
   else
   {
     lives--;
   }
   updateGame();
}
