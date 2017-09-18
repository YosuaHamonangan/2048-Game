class NeuralNetwork
{
  float[][] wI2H, wH2O;
  int NInput = 16;
  int NHidden = 10;
  int NOutput = 4;
  
  NeuralNetwork()
  { 
    wI2H = new float[NInput+1][NHidden];
    wH2O = new float[NHidden+1][NOutput];
    
    for(int n=0;n<NInput+1;n++)
    {
      for(int m=0;m<NHidden;m++)
      {
        wI2H[n][m] = random(-0.5,0.5);
      }
    }
    
    for(int n=0;n<NHidden+1;n++)
    {
      for(int m=0;m<NOutput;m++)
      {
        wH2O[n][m] = random(-0.5,0.5);
      }
    }
  }
  
  float[] FeedForward(float input[])
  {
    float[] OutHidden = new float[NHidden];
    for(int HiddenLayer=0;HiddenLayer<NHidden;HiddenLayer++)
    {
      float sum = wI2H[0][HiddenLayer];
      
      for(int InputLayer=0;InputLayer<NInput;InputLayer++)
      {
        sum += input[InputLayer]*wI2H[InputLayer+1][HiddenLayer];
      }
      
      OutHidden[HiddenLayer] = ActivationFunc(sum);
    }
    
    float[] output = new float[NOutput];
    for(int OutputLayer=0;OutputLayer<NOutput;OutputLayer++)
    {
      float sum = wH2O[0][OutputLayer];
      
      for(int HiddenLayer=0;HiddenLayer<NHidden;HiddenLayer++)
      {
        sum += OutHidden[HiddenLayer]*wH2O[HiddenLayer+1][OutputLayer];
      }
      
      output[OutputLayer] = ActivationFunc(sum);
    }
    
    return output;
  }
  
  float ActivationFunc(float sum)
  {
    float output = 1/(1+exp(-sum));
    return output;
  }
  
  float[][] getwI2H()
  {
    return wI2H;
  }
  
  float[][] getwH2O()
  {
    return wH2O;
  }
  
  void setWeight(float weightI2H[][], float weightH2O[][])
  {
    wI2H = weightI2H;
    wH2O = weightH2O;
  }
  
  int[] getNbrOfLayers()
  {
    int[] NbrOfLayers = new int[3];
    NbrOfLayers[0] = NInput;
    NbrOfLayers[1] = NHidden;
    NbrOfLayers[2] = NOutput;
    return NbrOfLayers;
  }
  
}