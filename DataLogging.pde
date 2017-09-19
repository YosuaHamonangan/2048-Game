class DataLogging
{
    PrintWriter FitnessLog = createWriter("C:/Users/yosua/Documents/Processing/game2048/data/Fitness.txt");
    PrintWriter WeigthLog = createWriter("C:/Users/yosua/Documents/Processing/game2048/data/Weigth.txt");
    PrintWriter ParentLog = createWriter("C:/Users/yosua/Documents/Processing/game2048/data/Parent.txt");
    
    void SaveFitness(int generation, int population, double fitness)
    {
      FitnessLog.println("gen\t" + generation + "\tpop\t" + population + "\tfitness\t" + (int)fitness);
      FitnessLog.flush();
    }
    
    void SaveWeigth(int generation, int population,float wI2H[][], float wH2O[][])
    {
      WeigthLog.println("gen " + generation + " pop " + population);
      
      for(int InputLayer=0;InputLayer<wI2H.length;InputLayer++)
      { 
        for(int HiddenLayer=0;HiddenLayer<wI2H[0].length;HiddenLayer++)
        {
          WeigthLog.print(nf(wI2H[InputLayer][HiddenLayer],0,4) + "\t");
        }
        WeigthLog.println();
      }
      WeigthLog.println();
      for(int HiddenLayer=0;HiddenLayer<wH2O.length;HiddenLayer++)
      {
        for(int OutputLayer=0;OutputLayer<wH2O[0].length;OutputLayer++)
        {
          WeigthLog.print(nf(wH2O[HiddenLayer][OutputLayer],0,4) + "\t");
        }
        WeigthLog.println();
      }
      WeigthLog.println();
      FitnessLog.flush();
    }
    
    void SaveParent(int p1, int p2,int population)
    {
      ParentLog.println("gen " + generation + " pop " + population + " p1 " + p1 + " p2 " + p2);
      ParentLog.flush();
    }
    
    
    
}