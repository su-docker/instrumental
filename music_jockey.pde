Maxim maxim;
Instrument flute;
Instrument veena;
Instrument tabla;

void setup()
{
  size(480, 800);
  background(0);

  maxim = new Maxim(this);

  tabla = new Instrument("tabla.png", "Tabla", #9b59b6, 0, 680, maxim.loadFile("tabla.wav"));
  flute = new Instrument("flute.png", "Flute", #c0392b, 160, 680, maxim.loadFile("flute.wav"));
  veena = new Instrument("veena.png", "Veena", #2ecc71, 320, 680, maxim.loadFile("veena.wav"));
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  drawInstruments();
}

void drawInstruments() {
  flute.draw();
  veena.draw();
  tabla.draw();
}

void mouseClicked() {
  flute.togglePlay();
  veena.togglePlay();
  tabla.togglePlay();
}


class Instrument {
  String title;
  PImage pImg;
  color bgColor;
  int x, y;
  int traceX, traceY;
  int traceInc=2;
  int width = 160;
  int height = 120;
  boolean playingAudio;

  AudioPlayer player;

  Instrument(String imageName, String title, color bgColor, int x, int y, AudioPlayer player) {
    this.title = title;
    this.pImg = loadImage(imageName);
    this.bgColor = bgColor;
    this.x = x;
    this.y = y;
    this.traceX = x+width/2;
    this.traceY = y;
    this.player = player;
    this.playingAudio = false;

    this.player.setLooping(true);
  }

  void draw() {
    drawTile();
    drawTrace();
    if (this.playingAudio) {
      drawImpression();
    }
  }

  void drawTile() {
    noStroke();
    fill(bgColor);
    rect(x, y, width, height);
    image(this.pImg, x+35, y+10, 80, 80);

    fill(#000000);
    textSize(16);
    textAlign(CENTER);
    text(this.title, x+width/2, y+height/1.2);
  }

  void drawTrace() {
    noStroke();
    fill(bgColor, 50);
    ellipse(traceX, traceY, 10, 10);

    traceY-=traceInc;
    if (traceY < 0 || traceY > y) {
      traceInc = traceInc * -1;
    }
  }

  void drawImpression() {
    float radius = random(80);
    float alpha = random(20, 90);
    fill(bgColor, alpha);
    ellipse(traceX, traceY, radius, radius);
  }

  boolean withinBounds() {
    return ((mouseX > x) && (mouseX < x+width) && (mouseY > y) && (mouseY < y+height));
  }

  void togglePlay() {
    if (withinBounds()) {
      if (this.playingAudio) {
        player.stop();
      } 
      else { 
        player.play();
      }
      this.playingAudio = !this.playingAudio;
    }
  }
}


