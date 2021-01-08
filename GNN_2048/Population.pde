class Population {
  MyDFF[] NNs;
  Grid[] grids;
  int gen = 0;
  
  Population(int sizePopulation) {
    NNs = new MyDFF[sizePopulation];
    grids = new Grid[sizePopulation];

    for (int i = 0; i < NNs.length; i++) {
      NNs[i] = new MyDFF(16, hiddens, 4);
      grids[i] = new Grid();
    }
  }

  void respond() {
    for (int i = 0; i < NNs.length; i++) {
      NNs[i].respond(grids[i]);
    }
    NNs[0].display(NNs[0].findIndexBestOutput());
  }

  void blank() {
    for (int i = 0; i < NNs.length; i++) {
      NNs[i].blank();
    }
    NNs[0].display();
  }

  boolean allNNStoped() {
    // TODO
    return false;
  }

  void computeFitness() {
    // TODO
  }

  void mutate() {
    // TODO
  }

  void update() {
    // TODO
  }
}
