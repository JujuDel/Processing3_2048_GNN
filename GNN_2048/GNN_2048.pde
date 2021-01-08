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

// Whether or not the genetic is ongoing
boolean isGeneticOngoing = false;

void setup() {
  size(1500, 800);
  background(255);
  textSize(30);
  fill(255, 0, 0);

  DIRECTION[0] = "UP";
  DIRECTION[1] = "RIGHT";
  DIRECTION[2] = "DOWN";
  DIRECTION[3] = "LEFT";

  // Set the number of hidden layers and the number of neurons per layers
  hiddens = new int[1];
  hiddens[0] = 16 * 5;

  population = new Population();
  population.blank();
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

  // Genetic algorithm
  if (isGeneticOngoing) {
    // All the NN are finished
    if (population.allNNStoped())
    {
      // Perform the mutation
      population.mutate();
      // TEMPORARY: start over
      setup();
    }
    else
    {
      // Do one step
      population.update();
      // Display the first NN
      background(255);
      population.NNs[0].display(population.NNs[0].findIndexBestOutput());
    }
  }
  // User is controlling the game
  else {
    // Moves tiles when arrow key is pressed and grid is not full
    if (population.grids[0].getOccupiedCells(true).size() <= 16 && (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)) {
      population.grids[0].moveTilesKeyboard();
    }
  }

  // Draws the cells that have a numeric value
  for (Cell c : population.grids[0].getOccupiedCells (true)) {
    c.drawTile();
  }
}

void keyPressed() {
  // 'R' -> Resets the game
  if (!isGeneticOngoing && (key == 'r' || key == 'R')) {
    setup();
  }
  // 'F' -> Execute 1 feed forward
  else if (!isGeneticOngoing && (key == 'f' || key == 'F')) {
    background(255);
    population.NNs[0].respond(population.grids[0]);
    population.NNs[0].display(population.NNs[0].findIndexBestOutput());
    if (!population.grids[0].moveTilesNN(DIRECTION[population.NNs[0].findIndexBestOutput()])) {
      setup();
    }
  }
  // 'SPACE BAR' -> Starts or stops the genetic
  else if (key == ' ') {
    isGeneticOngoing = !isGeneticOngoing;
  }
}
