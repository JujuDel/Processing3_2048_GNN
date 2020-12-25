double sigmoid(double x) { return 1.0 / (1.0 + exp(-1.0 * (float)x)); }

class MyDFF {
  
  Network _network;
  
  MyDFF(int nbInputs, int[] nbHiddens, int nbOutput) {
    _network = new Network(nbInputs, nbHiddens, nbOutput);
  }
  
  int respond(double[] inputs) {
    if (inputs.length == _network.m_input_layer.neurons.length) {
      _network.respond(inputs);
      return _network.findIndexBestOutput();
    } else {
      println("MyDFF::respond(double[]) method -> invalid size of the argument");
    }
    return -1;
  }

  int findIndexBestOutput() {
    return _network.findIndexBestOutput();
  }

  //// 2048 input methods

  int respond(Grid grid) {
    double inputs[] = new double[16];
    for (int j = 0; j < 4; j++) {
      for (int i = 0; i < 4; i++) {
        if (grid.cells[j][i].hasNumber) {
          // Each number is 2^i with i : 1 -> 17
          // log(number) / (17 * log(2)) is equivalent to i / 17
          inputs[4 * j + i] = log(grid.cells[j][i].number) / (17 * log(2));
        } else {
          inputs[4 * j + i] = 0;
        }
      }
    }
    return respond(inputs);
  }

  //// Vizu methods

  void blank() {
    _network.blank();
  }

  void display(int res) {
    _network.display(res);
  }
}
