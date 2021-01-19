int _SIZE_POPULATION = 100;
double _ELITISM_RATIO = 0.1;
double _MUTATION_RATE = 0.2;
int _ELITISM_IDX = (int)(_ELITISM_RATIO * _SIZE_POPULATION);

class Population {
  MyDFF[] NNs;
  Grid[] grids;
  boolean[] isAlive;
  int gen = 0;

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
        double choice1 = random(1);
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
        double choice2 = random(1);
        for (; idxParent2 < _SIZE_POPULATION; ++idxParent2) {
          if (grids[idxParent2].fitness < choice2) {
            idxParent2--;
            break;
          }
        }
      }

      // Create two children
      newNNs[i] = giveBirth(NNs[idxParent1], NNs[idxParent2]);
      newNNs[i + 1] = giveBirth(NNs[idxParent2], NNs[idxParent1]);
    }

    // Resulting NNs
    NNs = newNNs.clone();
    gen++;
  }
}

MyDFF giveBirth(MyDFF father, MyDFF mother) {
  // Input / Hiddens / Output sizes
  int input = father._network.m_input_layer.neurons.length;
  int hiddens[] = new int[father._network.m_hidden_layer.length];
  for (int i = 0; i < hiddens.length; i++) {
    hiddens[i] = father._network.m_hidden_layer[i].neurons.length;
  }
  int output = father._network.m_output_layer.neurons.length;

  // Child initialization
  MyDFF child = new MyDFF(input, hiddens, output);

  // Weighted random average on all weights / biases
  for (int l = 0; l < child._network.m_hidden_layer.length; ++l) {
    for (int n = 0; n < child._network.m_hidden_layer[l].neurons.length; ++n) {
      double r = random(1);
      if (r > _MUTATION_RATE) {
        r = random(1);
        child._network.m_hidden_layer[l].neurons[n].m_bias = r * father._network.m_hidden_layer[l].neurons[n].m_bias + (1 - r) * mother._network.m_hidden_layer[l].neurons[n].m_bias;
        for (int w = 0; w < child._network.m_hidden_layer[l].neurons[n].m_weights.length; ++w) {
          r = random(1);
          child._network.m_hidden_layer[l].neurons[n].m_weights[w] = r * father._network.m_hidden_layer[l].neurons[n].m_weights[w] + (1 - r) * mother._network.m_hidden_layer[l].neurons[n].m_weights[w];
        }
      }
    }
  }
  for (int n = 0; n < child._network.m_output_layer.neurons.length; ++n) {
    double r = random(1);
    if (r > _MUTATION_RATE) {
        r = random(1);
      child._network.m_output_layer.neurons[n].m_bias = r * father._network.m_output_layer.neurons[n].m_bias + (1 - r) * mother._network.m_output_layer.neurons[n].m_bias;
      for (int w = 0; w < child._network.m_output_layer.neurons[n].m_weights.length; ++w) {
        r = random(1);
        child._network.m_output_layer.neurons[n].m_weights[w] = r * father._network.m_output_layer.neurons[n].m_weights[w] + (1 - r) * mother._network.m_output_layer.neurons[n].m_weights[w];
      }
    }
  }

  return child;
}
