class Neuron {
  
  Layer m_inputs;
  
  double [] m_weights;
  double m_bias;
  
  double m_output;
  double m_error;
  
  Neuron() {}
  
  Neuron(Layer prev_inputs) {
    m_inputs = prev_inputs;
    m_weights = new double [prev_inputs.neurons.length];
    for (int i = 0; i < m_weights.length; ++i) {
      m_weights[i] = randomGaussian() / sqrt(prev_inputs.neurons.length);
    }
    m_bias = 0;
  }
  
  void respond() {
    double sum_input = m_bias;
    
    for (int i = 0; i < m_inputs.neurons.length; ++i) {
      sum_input += m_inputs.neurons[i].m_output * m_weights[i];
    }
    
    m_output = sigmoid(sum_input);
    m_error = 0;
  }
  
  void setError(double target) {
    m_error = 2 * (target - m_output);
  }
  
  void train(double learningRateW, double learningRateB) {
    double delta = m_error * m_output * (1 - m_output);
    double dW = delta * learningRateW;
    
    for (int i = 0; i < m_inputs.neurons.length; ++i) {
      m_inputs.neurons[i].m_error += m_weights[i] * delta;
      m_weights[i] += m_inputs.neurons[i].m_output * dW;
    }
    m_bias += delta * learningRateB;
  }
}
