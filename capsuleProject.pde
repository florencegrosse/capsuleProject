import processing.sound.*;
import processing.video.*;

import system.signals.Signal ;

PFont montserratLight;
PFont montserratMedium;
PFont montserratSemiBold;

ScreenManager screenManager;
PumpManager pump;
KinectManager kinect;
PerfumeManager perfumeManager;

public SoundFile[] musicFile;

//SoundFile intro;

//Movie test;

//int[] stepsRatios = {1, 2, 3, 0, 1, 3};

void setup()
{
  size(800, 600);
  pixelDensity(2);

  //test = new Movie(this, "texture.MP4");
  //test.loop();

  montserratLight = createFont("Montserrat-Light.otf", 20);
  montserratMedium = createFont("Montserrat-Medium.otf", 20);
  montserratSemiBold = createFont("Montserrat-SemiBold.otf", 20);

  pump = new PumpManager(this);
  kinect = new KinectManager();
  perfumeManager = new PerfumeManager();

  Screen[] screen = new Screen[] //Initialization of all the screens
  {
    new Start("start", "shoes", kinect), 
      new Shoes("shoes", "instructions"), 
      new Instruction("instructions", "activity 1", kinect), 
      new Question("activity 1", "activity 2", kinect, pump, "Look at the other person in the eyes for 30 seconds. \n You will hear a bell when it is over.", 1, 0), 
      new Question("activity 2", "activity 3", kinect, pump, "Tell us with who you laugh the most.", 2, 1), 
      new Question("activity 3", "activity 4", kinect, pump, "Share an embarrassing moment in your life.", 3, 2), 
      new Question("activity 4", "activity 5", kinect, pump, "What are you grateful for today?", 0, 3), 
      new Question("activity 5", "activity 6", kinect, pump, "Share the last thing you discovered about yourself?", 1, 4), 
      new Question("activity 6", "recap", kinect, pump, "Create a secret handshake together!", 3, 5), 
      //new StickyHands("activity 7", "recap", kinect), 
      new Recap("recap", perfumeManager, pump)
  };

  screenManager = new ScreenManager(screen);

  musicFile = new SoundFile[]
    {
    new SoundFile(this, "Wind_mono.mp3"), 
    new SoundFile(this, "Birds_mono.mp3"), 
    new SoundFile(this, "Whales_mono.mp3"), 
    new SoundFile(this, "Largevibe_mono.mp3"), 
    new SoundFile(this, "Underwater_mono.mp3"), 
    new SoundFile(this, "Fire_mono.mp3"), 
    new SoundFile(this, "Neptune_mono.mp3"),
    new SoundFile(this, "bell.mp3")
  };

  musicFile[6].amp(0.5);
  musicFile[6].loop();

  //intro = new SoundFile(this, "Intro.mp3");
}

//void sendMessage( String message )
//{
//  println( message ) ;
//}

//void movieEvent(Movie m) {
//m.read();
//}

void draw()
{
  background(0);
  //pump.update();
  screenManager.draw();
  pump.draw();

  //if(screenManager.screen[0]._startMusic) { intro.amp(0.1); intro.play(); }
  //kinect.draw();
}


void mousePressed()
{
  kinect.mousePressed();
}

void mouseReleased()
{
  kinect.mouseReleased();
}

void mouseDragged()
{
  kinect.mouseDragged();
}


void keyPressed(KeyEvent e)
{
  println(e.getKeyCode());

  switch(e.getKeyCode())
  {
  case 37: //Arrow Left
    screenManager.previous();
    break;

  case 38: //Arrow up
    break;

  case 39: //Arrow right
    screenManager.next();
    break;

  case 40: //Arrow down
    break;
  }

  kinect.keyPressed(e);
}