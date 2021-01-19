class Network {

  Layer m_input_layer;
  Layer [] m_hidden_layer;
  Layer m_output_layer;

  Network(int inputs, int [] hiddens, int outputs) {
    m_input_layer = new Layer(inputs);
    
    m_hidden_layer = new Layer[hiddens.length];
    if (m_hidden_layer.length > 0 ) {
      m_hidden_layer[0] = new Layer(hiddens[0], m_input_layer);
      for (int i = 1; i < m_hidden_layer.length; ++i) {
        m_hidden_layer[i] = new Layer(hiddens[i], m_hidden_layer[i-1]);
      }
      m_output_layer = new Layer(outputs, m_hidden_layer[m_hidden_layer.length - 1]);
    } else {
      m_output_layer = new Layer(outputs, m_input_layer);
    }
  }
  
  void respond(double[] data) {
    for (int i = 0; i < m_input_layer.neurons.length; ++i) {
      m_input_layer.neurons[i].m_output = data[i];
    }
    
    for (int i = 0; i < m_hidden_layer.length; ++i) {
      m_hidden_layer[i].respond();
    }
    
    m_output_layer.respond();
  }
  
  void train(double [] targets, double learningRateW, double learningRateB) {
    // adjust the output layer
    for (int i = 0; i < m_output_layer.neurons.length; ++i) {
      m_output_layer.neurons[i].setError(targets[i]);
      m_output_layer.neurons[i].train(learningRateW, learningRateB);
    }
    
    // propagate back to the hidden layers
    for (int i = m_hidden_layer.length - 1; i >= 0 ; --i) {
      m_hidden_layer[i].train(learningRateW, learningRateB);
    }
  }
  
  int findIndexBestOutput()
  {
    double maxOutput = -1;
    int foundedLabel = -1;
    for (int i = 0; i < m_output_layer.neurons.length; ++i) {
      if (m_output_layer.neurons[i].m_output > maxOutput)
      {
        maxOutput = m_output_layer.neurons[i].m_output;
        foundedLabel = i;
      }
    }
    
    return foundedLabel;
  }

  //// Vizu methods

  int nbNeuronPerCol = 8;

  void blank() {
    m_input_layer.blank();

    for (int i = 0; i < m_hidden_layer.length; ++i) {
      m_hidden_layer[i].blank();
    }

    m_output_layer.blank();
  }

  void weights() {
    if (m_hidden_layer.length > 0) {
      for (int n = 0; n < m_hidden_layer[0].neurons.length; n++) {
        for (int w = 0; w < m_hidden_layer[0].neurons[n].m_weights.length; w++) {
          strokeWeight(abs((float)m_hidden_layer[0].neurons[n].m_weights[w]));
          int igrid = w % 4;
          int jgrid = w / 4;
          int ineuron = n / nbNeuronPerCol;
          int jneuron = n % nbNeuronPerCol;
          line(startCoor + (igrid + .5) * sizeCell, startCoor + (jgrid + .5) * sizeCell,
               775 + ineuron * (30 + 32), 200 + jneuron * (30 + 32));
        }
      }
    }

    for (int n = 0; n < m_output_layer.neurons.length; n++) {
      for (int w = 0; w < m_output_layer.neurons[n].m_weights.length; w++) {
        strokeWeight(abs((float)m_output_layer.neurons[n].m_weights[w]));
        int ineuron = w / nbNeuronPerCol;
        int jneuron = w % nbNeuronPerCol;
        line(775 + ineuron * (30 + 32), 200 + jneuron * (30 + 32), 1175, 320 + n * (20 + 32));
      }
    }
  }

  void display(int res) {
    if (m_hidden_layer.length > 0) {
      m_hidden_layer[0].displayHidden(775, 200, 32, nbNeuronPerCol);
    }
    m_output_layer.displayOutput(1175, 320, 32, res);
  }
}
