//created by Mariana Galuk on 18/02/2018 //<>//
//Last edited in 04/03/2018

/*
  the project mimics brush strokes in photographic 
  portraits, giving the idea of painted portraits
*/

//setting the the Button class
class Button {
  String label; // button label
  float x;      // top left corner x position
  float y;      // top left corner y position
  float w;      // width of button
  float h;      // height of button

  // constructor
  Button(String labelBut, float xpos, float ypos, float widthB, float heightB) {
    label = labelBut;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }

  void Draw() {
    fill(225);
    rect(x, y, w, h, 5);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }

  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
//global variables

//array of images
PImage imgs [] = new PImage[6];
int d = 0;

//stores the image to be saved
PImage custom;

//color variable
color c;

//boolean viriable
boolean fileSelected;

//Buttons
Button on_button1;//button pload image
Button on_button2;//button save image

void setup() {
  //canvas size and background
  size(510, 800);
  background(0);

  //setup buttons 1 and 2
  on_button1 = new Button("Image Upload", 30, 730, 120, 50);
  on_button2 = new Button("Save Image", 160, 730, 120, 50);
  on_button1.Draw();
  on_button2.Draw();

  //setup command text
  String a = "Commands: Use SPACEBAR to change between images; Choose a button to load or save an image.";
  fill(255);
  textSize(12);
  textAlign(LEFT, BOTTOM);
  text(a, 30, 670, 400, 50);  // Text wraps within text box

  //pre loaded images
  imgs[0] = loadImage("armstrong.jpg");
  imgs[1] = loadImage("willsmith.png");
  imgs[2] = loadImage("clinteastwood.jpg");//
  imgs[3] = loadImage("benedictcumberbatch.jpg");
  imgs[4] = loadImage("marilynmonroe.jpeg");//resize

  imageMode(CENTER);
}

void draw() {
  imgs[d].resize(500, 600);
  //function to draw the stylized images
  drawImage();
}

//captures if SPACEBAR is pressed and call function changeImage()
void keyPressed() {
  switch(key) {
  case 32:
    println("A Pressed. Change Image");
    changeImage();
    break;
  }
}

//draw the stylized image
void drawImage() {

  for (int i=0; i<30; i++) {
    for (int j=0; j<30; j++)
    {
      float x = random(imgs[d].width);
      float y = random(imgs[d].height);

      if ( frameCount < 10 ) {
        c = imgs[d].get(int(x), int(y));
        fill(c, 25);
        strokeWeight(50);
        stroke(c, 5);
        line(x, y, x+(random(-50, 30)), y+(random(-30, 50)));
      } else if ( frameCount >= 11 && frameCount <= 20 ) {
        c = imgs[d].get(int(x), int(y));
        fill(c, 25);
        strokeWeight(24);
        stroke(c, 25);
        line(x, y, x+(random(-50, 30)), y+(random(-30, 50)));
      } else if ( frameCount >= 21 && frameCount <= 30 ) {
        c = imgs[d].get(int(x), int(y));
        fill(c, 25);
        strokeWeight(16);
        stroke(c, 25);
        line(x, y, x+(random(-50, 30)), y+(random(-30, 50)));
      } else if ( frameCount >= 31 && frameCount <= 500 ) {
        c = imgs[d].get(int(x), int(y));
        fill(c, 25);
        strokeWeight(8);
        stroke(c, 25);
        line(x, y, x+(random(-10, 10)), y+(random(-10, 10)));
      }
    }
  }
}

//function to change between d images in the array
void changeImage() {
  d++;
  frameCount = 0;
  println(d);

  if (d >= imgs.length || imgs[d] == null) {
    d=0;
    println(d);
  }
}

//function to load an image
void fileSelection(File selection) {
  if (selection == null) {
    println("No file was selected.");
    fileSelected = false;
  } else {
    println("File selected " + selection.getAbsolutePath());
    imgs[imgs.length - 1] = loadImage(selection.getAbsolutePath());
    d = imgs.length - 1;
    frameCount = 0;
  }
}

//function to save the imagein the screen
void savFile(File selection) {
  if (selection == null) {
    println("Window was closed or user canceled action.");
  } else {
    String fileName = selection.getAbsolutePath();
    if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".tif") || fileName.endsWith(".jpeg") || fileName.endsWith(".tiff") || fileName.endsWith(".tga")) {
      custom.save( fileName );
    } else {
      //if user did not set a file extension, save as .png
      custom.save( fileName + ".png");
    }
  }
}

//captures the button event
void mousePressed() {
  if (on_button1.MouseIsOver()) {
    // print some text to the console pane if the button is clicked
    print("Upload button clicked");

    //if the button was pressed, a image can be selected
    selectInput("Select a file to process:", "fileSelection");
    if (fileSelected == true) {
      drawImage();
    }
  }
  if (on_button2.MouseIsOver()) {
    print("Save button clicked");
    custom = get(0, 0, imgs[d].width, imgs[d].height);
    selectOutput("Select output file:", "savFile");
  }
}
