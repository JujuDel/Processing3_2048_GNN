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

  //// Vizu methods

  void blank() {
    for (int i = 0; i < neurons.length; ++i) {
      neurons[i].m_output = 0;
    }
  }

  void display(int size) {
    for (Neuron n : neurons) {
      n.display(size);
    }
  }

  void displayInput(int xStart, int yStart, int sizeNeuron, int nbNeurons) {
    for (int i = 0; i < neurons.length; ++i) {
      pushMatrix();
        translate(
          (i%nbNeurons) * sizeNeuron + xStart,
          (i/nbNeurons) * sizeNeuron + yStart);
        neurons[i].display(sizeNeuron);
      popMatrix();
    }
  }

  int displayHidden(int xStart, int yStart, int sizeNeuron, int nbNeurons) {
    for (int i = 0; i < neurons.length; ++i) {
      pushMatrix();
        translate(
          (i/nbNeurons) * (sizeNeuron + 2) + xStart,
          (i%nbNeurons) * (sizeNeuron + 2) + yStart);
        neurons[i].display(sizeNeuron);
      popMatrix();
    }
    return (neurons.length - 1) / nbNeurons;
  }

  void displayOutput(int xStart, int yStart, int sizeNeuron, int res)
  {
    for (int i = 0; i < neurons.length; ++i) {
      pushMatrix();
        translate(
          xStart,
          i * (sizeNeuron + 2) + yStart);
        neurons[i].display(sizeNeuron);

        if (i == res)
          fill(0,200,0);
        else
          fill(100);
        text(i + ": " + nf((float)neurons[i].m_output, 0, 4), 16, 6);
      popMatrix();
    }
  }
}
