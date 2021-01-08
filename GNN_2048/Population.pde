class Population {
  MyDFF[] NNs;
  Grid[] grids;
  boolean[] isAlive;
  int gen = 0;
  
  int _SIZE_POPULATION = 100;
  double _ELITISM_RATIO = 0.1;
  double _MUTATION_RATE = 0.2;
  int _ELITISM_IDX = (int)(_ELITISM_RATIO * _SIZE_POPULATION);

  Population() {
    NNs = new MyDFF[_SIZE_POPULATION];
    grids = new Grid[_SIZE_POPULATION];
    isAlive = new boolean[_SIZE_POPULATION];

    for (int i = 0; i < NNs.length; i++) {
      NNs[i] = new MyDFF(16, hiddens, 4);
      grids[i] = new Grid(i);
      isAlive[i] = true;
    }
  }

  void resetGrids() {
    grids = new Grid[_SIZE_POPULATION];
    isAlive = new boolean[_SIZE_POPULATION];

    for (int i = 0; i < NNs.length; i++) {
      grids[i] = new Grid(i);
      isAlive[i] = true;
    }
  }

  void update() {
    for (int i = 0; i < NNs.length; i++) {
      if (isAlive[i]) {
        // Run the NN
        NNs[i].respond(grids[i]);
        // Apply the NN output to the grid
        isAlive[i] = grids[i].moveTilesNN(DIRECTION[NNs[i].findIndexBestOutput()]);
      }
    }
  }

  void blank() {
    for (int i = 0; i < NNs.length; i++) {
      NNs[i].blank();
    }
    NNs[0].display();
  }

  boolean allNNStoped() {
    for (boolean b : isAlive) {
      if (b) {
        return false;
      }
    }
    return true;
  }

  void mutate() {
    // Sort the grids with their fitness
    java.util.Arrays.sort(grids);

    // Sum of all the scores
    float fitnessSum = 0;
    for (int i = 0; i < grids.length; i++) {
      fitnessSum += grids[i].score;
    }

    // Compute the cumulative fitness
    float cumSum = 0;
    for (int i = grids.length - 1; i >= 0; i--) {
      grids[i].fitness = cumSum + grids[i].score / fitnessSum;
      cumSum = grids[i].fitness;
    }

    // Next generation array
    MyDFF[] newNNs = new MyDFF[_SIZE_POPULATION];

    // Elitism
    for (int i = 0; i < _ELITISM_IDX; ++i) {
      newNNs[i] = NNs[grids[i].idx];
    }

    // Continuous Genetic mutation
    for (int i = _ELITISM_IDX; i < _SIZE_POPULATION; i += 2) {
      int idxParent1 = _SIZE_POPULATION;
      while (idxParent1 == _SIZE_POPULATION) {
        idxParent1 = 1;
        float choice1 = random(999999) / 999999;
        for (; idxParent1 < _SIZE_POPULATION; ++idxParent1) {
          if (grids[idxParent1].fitness < choice1) {
            idxParent1--;
            break;
          }
        }
      }
      int idxParent2 = _SIZE_POPULATION;
      while (idxParent2 == idxParent1 || idxParent2 == _SIZE_POPULATION) {
        idxParent2 = 1;
        float choice2 = random(999999) / 999999;
        for (; idxParent2 < _SIZE_POPULATION; ++idxParent2) {
          if (grids[idxParent2].fitness < choice2) {
            idxParent2--;
            break;
          }
        }
      }

      // TEMPORARY: Next random
      newNNs[i] = new MyDFF(16, hiddens, 4);
      newNNs[i + 1] = new MyDFF(16, hiddens, 4);
    }

    // Resulting NNs
    NNs = newNNs.clone();
  }
}
