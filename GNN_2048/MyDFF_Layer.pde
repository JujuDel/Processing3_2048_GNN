class Layer {
  
  Neuron [] neurons;
  
  Layer(int nbNeuron) {
    neurons = new Neuron[nbNeuron];
    for (int i = 0; i < nbNeuron; ++i) {
      neurons[i] = new Neuron();
    }
  }
  
  Layer(int nbNeuron, Layer pLayer) {
    neurons = new Neuron[nbNeuron];
    for (int i = 0; i < nbNeuron; ++i) {
      neurons[i] = new Neuron(pLayer);
    }
  }
  
  void respond() {
    for (int i = 0; i < neurons.length; ++i) {
      neurons[i].respond();
    }
  }
  
  void train(double learningRateW, double learningRateB) {
    for (int i = 0; i < neurons.length; ++i) {
      neurons[i].train(learningRateW, learningRateB);
    }
  }
}
