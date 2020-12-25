// 2048 container
int startCoor = 100;
int endCoor = 700;
int sizeCell = (endCoor - startCoor) / 4;

// Number of hidden layers and the number of neurons per layers
int hiddens[];

// Genetic population
Population population;

// Directions
String DIRECTION[] = new String[4];

void setup() {
  size(1500, 800);
  background(255);
  textSize(30);
  fill(255, 0, 0);
  text("Press 'r' to reset game", 150, 560);

  DIRECTION[0] = "UP";
  DIRECTION[1] = "RIGHT";
  DIRECTION[2] = "DOWN";
  DIRECTION[3] = "LEFT";

  // Set the number of hidden layers and the number of neurons per layers
  hiddens = new int[1];
  hiddens[0] = 16 * 5;

  population = new Population(100);
  population.respond();
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
  text("Score: " + population.grids[0].score, 350, 45);

  // Draws the cells that have a numeric value
  for (Cell c : population.grids[0].getOccupiedCells (true)) {
    c.drawTile();
  }

  // Moves tiles when arrow key is pressed and grid is not full
  if (population.grids[0].getOccupiedCells(true).size() <= 16 && (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)) {
    population.grids[0].moveTilesKeyboard();
  }
}

// Resets game is r is pressed
void keyPressed() {
  if (key == 'r' || key == 'R') {
    setup();
  }
  else if (key == 'f' || key == 'F') {
    background(255);
    population.respond();
  }
}
