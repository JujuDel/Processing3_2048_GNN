class Population {
  MyDFF[] NNs;
  Grid[] grids;
  int gen = 0;
  
  Population(int sizePopulation) {
    NNs = new MyDFF[sizePopulation];
    grids = new Grid[sizePopulation];
  }
  
  void init() {
    for (int i = 0; i < NNs.length; i++) {
      NNs[i] = new MyDFF(16, hiddens, 4);
      grids[i] = new Grid();
    }
  }
}
