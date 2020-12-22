double sigmoid(double x) { return 1.0 / (1.0 + exp(-1.0 * (float)x)); }

class MyDFF {
  
  Network _network;
  
  MyDFF(int nbInputs, int[] nbHiddens, int nbOutput) {
    _network = new Network(nbInputs, nbHiddens, nbOutput);
  }
  
  int forward(double[] inputs) {
    if (inputs.length == _network.m_input_layer.neurons.length) {
      _network.respond(inputs);
      return _network.findIndexBestOutput();
    } else {
      println("MyDFF::respond(double[]) method -> invalid size of the argument");
    }
    return -1;
  }
}
