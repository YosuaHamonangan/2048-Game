class GeneticAlgorithm
{
  DataLogging data = new DataLogging();
  
  int PopulationSize = 20;
  float MutationRate = 0.01;
  NeuralNetwork[] NN = new NeuralNetwork[PopulationSize];
  double[] Fitness = new double[PopulationSize];
  float[][] boardWeight = {{100.0,50.0,10.0,5.0},
                          {-1.0,0.2,0.5,1.0},
                          {-1.0,-1.0,-1.0,-1.0},
                          {-1.0,-1.0,-1.0,-1.0}
                          };
  
  /*float[][] boardWeight = {{5.0,10.0,50.0,100.0},
                          {1.0,0.5,0.2,-1.0},
                          {-1.0,-1.0,-1.0,-1.0},
                          {-1.0,-1.0,-1.0,-1.0}
                          };*/
  /*float[][] boardWeight = {{-0.1,-0.1,-0.1,-0.1},
                          {-0.1,-0.1,-0.1,-0.1},
                          {0.4,0.3,0.2,-0.1},
                          {0.5,1.0,5.0,100.0}
                          };*/
  
  GeneticAlgorithm()
  {
    for(int population=0;population<PopulationSize;population++)
    {
      NN[population] = new NeuralNetwork();
    }
    initFitness();
  }
  
  void initFitness()
  {
    for(int population=0;population<PopulationSize;population++)
    {
      Fitness[population] = 0;
    }
  }
  
  double setFitness(int[][] values, int population,int retry)
  {
    for(int row=0;row<values.length;row++)
    {
      for(int column=0;column<values[0].length;column++)
      {
        Fitness[population] += values[row][column]*boardWeight[row][column];
        if(values[row][column]==0) Fitness[population]+=5;
      }
    }
     Fitness[population] -= retry*100;
    if (Fitness[population]<0) Fitness[population] =0;
    return Fitness[population];
  }
  
  int[] ChooseParents()
  {
    double totalFitness = 0;
    for(int population=0;population<PopulationSize;population++)
    {
      totalFitness += Fitness[population];
    }
    
    int[] Parents = new int[2];
    for(int parent=0;parent<2;parent++)
    {
      Parents[parent] = 0;
      double selected = random(1);
      while(selected>0 && Parents[parent]<PopulationSize)
      {
        selected -= (double)Fitness[Parents[parent]]/totalFitness;
        Parents[parent]++;
      }
      Parents[parent]--;
    }
    return Parents;
  }
  
  void crossOver()
  {
    float[][][] wI2Hnew = new float[PopulationSize][NN[0].NInput+1][NN[0].NHidden];
    float[][][] wH2Onew = new float[PopulationSize][NN[0].NHidden+1][NN[0].NOutput];
    
    
    for(int population=0;population<PopulationSize;population++)
    {
      int[] Parents = ChooseParents();
      
      float[][] wI2H1 = NN[Parents[0]].wI2H;
      float[][] wH2O1 = NN[Parents[0]].wH2O;
      
      float[][] wI2H2 = NN[Parents[1]].wI2H;
      float[][] wH2O2 = NN[Parents[1]].wH2O;
      
      data.SaveParent(Parents[0], Parents[1],population);
      
      for(int HiddenLayer=0;HiddenLayer<NN[0].NHidden;HiddenLayer++)
      { 
        for(int InputLayer=0;InputLayer<NN[0].NInput+1;InputLayer++)
        {
          if(HiddenLayer<NN[0].NHidden/2)
          {
            wI2Hnew[population][InputLayer][HiddenLayer] = wI2H1[InputLayer][HiddenLayer];
          }
          else
          {
            wI2Hnew[population][InputLayer][HiddenLayer] = wI2H2[InputLayer][HiddenLayer];
          }
          if(random(1)<MutationRate)
          {
            wI2Hnew[population][InputLayer][HiddenLayer] = random(-1,1);
          }
        }
      }
      
      for(int OutputLayer=0;OutputLayer<NN[0].NOutput;OutputLayer++)
      {
        for(int HiddenLayer=0;HiddenLayer<NN[0].NHidden+1;HiddenLayer++)
        {
          
          if(HiddenLayer<NN[0].NHidden/2)
          {
            wH2Onew[population][HiddenLayer][OutputLayer] = wH2O1[HiddenLayer][OutputLayer];
          }
          else
          {
            wH2Onew[population][HiddenLayer][OutputLayer] = wH2O2[HiddenLayer][OutputLayer];
          }
          if(random(1)<MutationRate)
          {
            wH2Onew[population][HiddenLayer][OutputLayer] = random(-1,1);
          }
        }
      }
    }
    
    for(int population=0;population<PopulationSize;population++)
    {
      NN[population].setWeight(wI2Hnew[population],wH2Onew[population]);
    }
  }
  
  float[] getCommand(float input[], int population)
  {
    return NN[population].FeedForward(input);
  }
  
  void Save(int generation, int population)
  {
    data.SaveFitness(generation, population, Fitness[population]);
    data.SaveWeigth(generation, population, NN[population].wI2H, NN[population].wH2O);
  }
}