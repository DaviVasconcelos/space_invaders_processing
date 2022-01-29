//configurar quantidade de inimigos (máximo 5)
int quantInimigos = 3;

int posX;
int Xbala;
int Ybala = 0;
float speed = 0.5;
boolean gatilho = false;
int gameStat = 3;
int contador = 0;
//método antigo de randomizar
/* int[] numb1 = {0, 50, 100, 150, 200, 250, 300, 350, 400, 450};
 int[] numb2 = {0, 50, 100, 150, 200};
 int rand1 = int(random(numb1.length));
 int rand2 = int(random(numb2.length));
 int rand3 = int(random(numb2.length));
 int rand4 = int(random(numb1.length));
 int rand5 = int(random(numb1.length));
 int rand6 = int(random(numb2.length));
 int rand7 = int(random(numb1.length));
 int rand8 = int(random(numb2.length));
 int rand9 = int(random(numb1.length));
 int rand10 = int(random(numb2.length));
 inimigos i1 = new inimigos(numb1[rand1], numb2[rand2]);
 inimigos i2 = new inimigos(numb1[rand4], numb2[rand3]);
 inimigos i3 = new inimigos(numb1[rand5], numb2[rand6]);
 inimigos i4 = new inimigos(numb1[rand7], numb2[rand8]);
 inimigos i5 = new inimigos(numb1[rand9], numb2[rand10]);
 */

//método novo de randomizar
inimigos i1 = new inimigos(int(random(0, 9))*50, (int(random(0, 4))*50));
inimigos i2 = new inimigos(int(random(0, 9))*50, (int(random(0, 4))*50));
inimigos i3 = new inimigos(int(random(0, 9))*50, (int(random(0, 4))*50));
inimigos i4 = new inimigos(int(random(0, 9))*50, (int(random(0, 4))*50));
inimigos i5 = new inimigos(int(random(0, 9))*50, (int(random(0, 4))*50));

Imagem im;

void setup() {
  size(500, 500);
  Ybala = 450;
  ellipseMode(CORNER);
  im = new Imagem();
}

void draw() {
  if (gameStat == 3) {
    background(0);
    textAlign(CENTER);
    fill(255);
    textSize(60);
    text("Space Invaders", 250, 120);
    textAlign(CORNER);
    textSize(15);
    text("Escolha a quantidade de inimigos pressionando", 70, 450);
    text("para cima ou para baixo", 70, 465);
    textSize(40);
    text("Inimigos: ", 130, 280);
    text(quantInimigos, 320, 280);
    textAlign(CENTER);
    textSize(20);
    text("Pressione Enter para iniciar!", 250, 150);
  }

  if (gameStat == 0) {
    grid();
    //bala
    if (gatilho == true) {
      if (Ybala > -30) {
        Ybala = Ybala - 4;
      } else {
        gatilho = false;
        Ybala = 450;
      }
      bala(Xbala + 250, Ybala);
    }
    //quantidade de inimigos
    switch(quantInimigos) {
    case 0:
      println("Nenhum inimigo foi criado");
      break;
    case 1:
      i1.update();
      break;
    case 2:
      i1.update();
      i2.update();
      break;
    case 3:
      i1.update();
      i2.update();
      i3.update();
      break;
    case 4:
      i1.update();
      i2.update();
      i3.update();
      i4.update();
      break;
    case 5:
      i1.update();
      i2.update();
      i3.update();
      i4.update();
      i5.update();
      break;
    }
    //personagem
    im.personagem(posX + 250, 450);
  }
  //gameover
  else if (gameStat == 1) {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(60);
    text("Você venceu!", 250, 250);
  } else if (gameStat == 2) {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(60);
    text("Você perdeu!", 250, 250);
    contador = 0;
  }
}

void grid() {
  fill(0);
  stroke(255);
  for (int y=0; y<10; y++) {
    for (int x=0; x<10; x++) {
      rect(x*50, y*50, 50, 50);
    }
  }
}

void keyPressed() {
  if (gameStat == 3) {
    if (keyCode == UP && quantInimigos < 5) {
      quantInimigos = quantInimigos + 1;
    } else if (keyCode == DOWN && quantInimigos > 0) {
      quantInimigos = quantInimigos - 1; 
    }
    
    if (keyCode == ENTER) {
      gameStat = 0;
    }
  } else if (gameStat == 0) {
    if (keyCode == LEFT) {
      if (posX + 250 > 0) {
        posX = posX - 50;
      }
    }

    if (keyCode == RIGHT) {
      if (posX + 300 < width) {
        posX = posX + 50;
      }
    }

    if (keyCode == CONTROL && Ybala == 450) {
      gatilho = true;
      Xbala = posX;
    }
  }
}

void bala(int x, int y) {
  fill(255);
  stroke(255);
  circle(x+20, y+20, 10);
}

class inimigos {
  float posX, posY;
  inimigos (float x, float y) {
    posX = x;
    posY = y;
  }

  void update() {
    //mecanismo de matar inimigo
    if (Ybala <= posY && Xbala == posX - 250 && Ybala != 0) {
      posY = -50;
      contador = contador + 1;
      Ybala = 450;
      gatilho = false;
    }
    //mecanismo de vitória
    if (quantInimigos == 1) {
      if (contador == 1) {
        gameStat = 1;
      }
    } else if (quantInimigos == 2) {
      if (contador == 2) {
        gameStat = 1;
      }
    } else if (quantInimigos == 3) {
      if (contador == 3) {
        gameStat = 1;
      }
    } else if (quantInimigos == 4) {
      if (contador == 4) {
        gameStat = 1;
      }
    } else if (quantInimigos == 5) {
      if (contador == 5) {
        gameStat = 1;
      }
    }
    if (posY != -50) {
      posY = posY + speed;
    }
    //mecanismo de aumento de velocidade
    if (contador == 0) {
      speed = 0.5;
    } else if (contador == 1) {
      speed = 1.5;
    } else if (contador == 3) {
      speed = 2.5;
    }
    //mecanismo de morte
    if (posY >= 410) {
      gameStat = 2;
    }
    im.inimigo(posX, posY);
    //println("posX: ", posX, "Xbala: ", Xbala+250);
  }
}

class Imagem {
  PImage img, img2;
  Imagem() {
    img = loadImage("nave.png");
    img2 = loadImage("inimigo.png");
  }

  void inimigo(float x, float y) {
    image(img2, x, y);
  }

  void personagem(int x, int y) {
    image(img, x, y);
  }
}
