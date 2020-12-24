// 2048 container
Grid grid;

// 2048 display
int startCoor = 100;
int endCoor = 700;
int sizeCell = (endCoor - startCoor) / 4;
  
// Player score
static int score;

// NN sizes
int nbInputs = 16;
int nbOutputs = 4;
int [] hiddens;

// 1 NN
MyDFF myDFF;

void setup() {
  size(800, 800);
  background(255);
  textSize(30);
  fill(255, 0, 0);
  text("Press 'r' to reset game", 150, 560);
  grid = new Grid();
  score = 0;
  grid.spawn();
  grid.spawn();

  // Set the number of hidden layers and the number of neurons per layers
  hiddens = new int[1];
  hiddens[0] = 16 * 5;

  myDFF = new MyDFF(nbInputs, hiddens, nbOutputs);
}

void draw() {
  // Redraws the grid
  fill(205, 193, 197);
  rect(startCoor, startCoor, endCoor - startCoor, endCoor - startCoor);
  for (int i = startCoor; i <= endCoor; i += sizeCell) {
    smooth();
    strokeWeight(3);
    line(startCoor, i, endCoor, i);
    line(i, startCoor, i, endCoor);
  }
  fill(255);
  strokeWeight(2);
  rect(430, 20, 130, 30);
  fill(0);
  textSize(25);
  text("Score: " + score, 350, 45);

  // Draws the cells that have a numeric value
  for (Cell c : grid.getOccupiedCells (true)) {
    c.drawTile();
  }

  // Moves tiles when arrow key is pressed and grid is not full
  if (grid.getOccupiedCells(true).size() <= 16 && (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)) {
    grid.moveTilesKeyboard();
  }
}

// Resets game is r is pressed
void keyPressed() {
  if (key == 'r' || key == 'R') {
    setup();
  }
  else if (key == 'f' || key == 'F') {
    println("FORWARD DONE", myDFF.respond(grid));
  }
}
