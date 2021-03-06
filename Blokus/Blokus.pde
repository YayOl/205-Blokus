color c2 = #FFCC00;
int grid = 30;
boolean holdingPiece;
Piece currentPiece;
//Create Demo Pieces
Piece[] bluePiece;
Piece[] redPiece;
Board board;

Button quit;  
Button instructions;  
Button newGame;  
void settings(){
  size(1200,800);
}

//Setup Method creates on-run functionality and variables.
void setup() { //Set Window Size
  stroke(2); //Set Line Width
  board = new Board();
  bluePiece = new Piece[21];
  redPiece = new Piece[21];
  for(int i = 0; i < 21; i++){
    bluePiece[i] = new Piece(i+1, color(50, 50, 200));
    bluePiece[i].setOrigin(680 + ((75*i) % 450), 60 + (floor(i/6)*100));
  }
  for(int i = 0; i < 21; i++){
    redPiece[i] = new Piece(i+1, color(200, 50, 50));
    redPiece[i].setOrigin(680 + ((75*i) % 450), 460 + (floor(i/6)*100));
  }
  holdingPiece = false;
  
  quit = new Button("Quit", 300, 650, 100, 50);
  newGame = new Button("New Game", 50, 650, 100, 50);
  instructions = new Button("How To Play", 175, 650, 100, 50);
}


//Draw is a continuous loop that runs infinitely after setup()
void draw() {
  
  clear();
  background(255);
  noFill();
  
  //Draw Grid
  board.draw();
  
  //Draw Containers
  for(int i = 0; i < 2; ++i) {
    noFill();
    rect(630,(i * 400),520,390);
  }
  
  //Create Piece that Follows Mouse
  if(currentPiece!=null){
    currentPiece.draw();
  }
  
  for(int i = 0; i < 21; i++){
    bluePiece[i].drawPreview();
  }
  
  for(int i = 0; i < 21; i++){
    redPiece[i].drawPreview();
  }
  
  if(holdingPiece == true && currentPiece!=null){
    currentPiece.setOrigin(mouseX,mouseY);
  }
  
  //Board newBoard = new Board(0,0);  
  quit.Draw();
  instructions.Draw();
  newGame.Draw();
}

void mousePressed() {
  if(holdingPiece
  &&mouseX>0
  &&mouseY>0
  &&mouseX<600
  &&mouseY<600) {
    boolean keepGoing = board.checkAndPlacePiece(currentPiece);
    if(keepGoing){
      holdingPiece = false;
      currentPiece = null;
    }
  } else {
    for(int i = 0; i < 21; i++){
    if(mouseX>(650+(75*i)%450)
    &&mouseX<(725+(75*i)%450)
    &&mouseY>30 + (floor(i/6)*100)
    &&mouseY<105 +(floor(i/6)*100)
    &&bluePiece[i].getBeenDrawed()==false){
      bluePiece[i].setBeenDrawed(true);
      Piece temp = new Piece(bluePiece[i].getType(),
      bluePiece[i].getColor());
      currentPiece = temp;
      bluePiece[i].delete();
      holdingPiece = true;
    }
    if(mouseX>(650+(75*i)%450)
    &&mouseX<(725+(75*i)%450)
    &&mouseY>430 + (floor(i/6)*100)
    &&mouseY<505 +(floor(i/6)*100)){
      redPiece[i].setBeenDrawed(true);
      Piece temp = new Piece(redPiece[i].getType(),
      redPiece[i].getColor());
      currentPiece = temp;
      redPiece[i].delete();
      holdingPiece = true;
    }
  }
  }
  
  if (quit.MouseIsOver()) {
    exit();
  }
  if (newGame.MouseIsOver()) {
    setup();
  }
  if (instructions.MouseIsOver()) {
    String[] args = {"SecondApplet"};
    Instructions sa = new Instructions();
    PApplet.runSketch(args, sa);
  }
}

void keyPressed() {
  if (keyCode == UP){
    currentPiece.verticalFlip();
  } else if (keyCode == DOWN){
    currentPiece.horizontalFlip();
  } else if (keyCode == LEFT){
   
  } else if (keyCode == RIGHT){
    currentPiece.rotateRight();  
  }
    
}
