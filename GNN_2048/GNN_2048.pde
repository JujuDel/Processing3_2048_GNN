// 2048 container
Grid grid;
int startCoor = 100;
int endCoor = 700;
int sizeCell = (endCoor - startCoor) / 4;
  
// Player score
static int score;

// 1 NN
MyDFF myDFF;

// Directions
String DIRECTION[] = new String[4];

void setup() {
  size(1500, 800);
  background(255);
  textSize(30);
  fill(255, 0, 0);
  text("Press 'r' to reset game", 150, 560);
  grid = new Grid();
  score = 0;
  grid.spawn();
  grid.spawn();

  DIRECTION[0] = "UP";
  DIRECTION[1] = "RIGHT";
  DIRECTION[2] = "DOWN";
  DIRECTION[3] = "LEFT";

  // Set the number of hidden layers and the number of neurons per layers
  int hiddens[] = new int[1];
  hiddens[0] = 16 * 5;

  myDFF = new MyDFF(16, hiddens, 4);
  myDFF.display(myDFF.respond(grid));
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
    background(255);
    myDFF.display(myDFF.respond(grid));
  }
}
