Cell[][] cells;
Grid grid;

int startCoor = 100;
int endCoor = 700;
int sizeCell = (endCoor - startCoor) / 4;
  
static int score;

void setup() {
  size(800, 800);
  background(255);
  textSize(30);
  fill(255, 0, 0);
  text("Press 'r' to reset game", 150, 560);
  cells = new Cell[4][4];
  grid = new Grid();
  score = 0;
  grid.spawn();
  grid.spawn();
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
    grid.moveTiles();
  }
}

// Resets game is r is pressed
void keyPressed() {
  if (key == 'r') {
    setup();
  }
}
