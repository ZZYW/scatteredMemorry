import processing.video.*;
import peasy.*;

PeasyCam cam;
Capture video;
PImage maskImage;

int totalMirror = 400;
float[] xs = new float[totalMirror];
float[] ys = new float[totalMirror];
float[] zs = new float[totalMirror];
float[] angleXs = new float[totalMirror];
float[] angleYs = new float[totalMirror];
float[] angleZs = new float[totalMirror];

PVector rotateAngles = new PVector(0, 0, 0);


void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(2000);
  smooth();
  rectMode(CENTER);
  hint( ENABLE_DEPTH_TEST);
  //println(Capture.list());

  video = new Capture(this, 320, 240);
  video.start();


  maskImage = loadImage("mask.png");


  for (int i=0; i<totalMirror; i++) {
    xs[i] = random(-width/2, width/2);
    ys[i] = random(-height/2, height/2);
    zs[i] = random(-300, 300);
    angleXs[i] = random(-PI, PI);
    angleYs[i] = random(-PI, PI);
    angleZs[i] = random(-PI, PI);
  }
}

// An event for when a new frame is available
void captureEvent(Capture video) {
  // Step 4. Read the image from the camera.
  video.read();
}

void draw() {
  //blendMode(MULTIPLY);
  background(200);
  rotateX(rotateAngles.x);
  rotateY(rotateAngles.y);
  rotateAngles = PVector.add(rotateAngles, new PVector(0.001, 0.001, 0.001));
  for (int i=0; i<totalMirror; i++) {
    pushMatrix();
    translate(xs[i], ys[i], zs[i]);
    rotateX(angleXs[i]);
    rotateY(angleYs[i]);
    rotateZ(angleZs[i]);
    //video.mask(maskImage);
    tint(50, 153, 204, 150);

    image(video, 0, 0);
    popMatrix();
  }
}