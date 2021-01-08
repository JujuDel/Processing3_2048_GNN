class Population {
  MyDFF[] NNs;
  Grid[] grids;
  boolean[] isAlive;
  int gen = 0;
  
  Population(int sizePopulation) {
    NNs = new MyDFF[sizePopulation];
    grids = new Grid[sizePopulation];
    isAlive = new boolean[sizePopulation];

    for (int i = 0; i < NNs.length; i++) {
      NNs[i] = new MyDFF(16, hiddens, 4);
      grids[i] = new Grid();
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

  void computeFitness() {
    // TODO
  }

  void mutate() {
    // TODO
  }

}
