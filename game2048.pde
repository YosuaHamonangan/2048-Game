boolean gameOver = false;
boolean auto = true;
Value vl = new Value();
Display display = new Display();
GeneticAlgorithm GA = new GeneticAlgorithm();
int PopulationSize = GA.PopulationSize;
int population = 0, generation = 0;
int delay = 500;
long maxScore = 0;
double fitness = 0;

void setup() 
{
  size(1300, 970);
} 

void draw() 
{
  background(102);
  if(auto) 
  {
    delay(delay);
    AI();
    display.GenerationPopulation(generation, population, maxScore, fitness);
  }
  display.Board(vl.getValue());
  display.Score();
  if(gameOver) display.GameOver();
}

void keyPressed() 
{
  if (!auto && !gameOver && key == CODED)
  {  
    if(vl.moveValue(keyCode))
     {
       vl.addRand();
       gameOver = vl.checkLose();
     }
  }
  if(key == ' ') AI();;
  if(key == '1') delay = 500;;
  if(key == '2') delay = 0;;
}

void reset()
{
  vl = new Value();
  gameOver = false;
}

void AI()
{
  float command[] = GA.getCommand(vl.getValue_1d(),population);
  boolean moved = false;
  int retry = 0;
  while(!moved && retry<4)
  {
    float max = 0;
    int index = 0;
    for(int cmd=0;cmd<4;cmd++)
    {
      if(command[cmd]>max)
      {
        max = command[cmd];
        index = cmd;
      }
    }
    command[index] = 0;
    moved = vl.moveValue(37+index);
    retry++;
  }
  
  fitness = GA.setFitness(vl.getValue(),population,retry-1);
  vl.addRand();
  gameOver = vl.checkLose();
  
  if(gameOver)
  {
    long score = vl.getScore();
    if(score>maxScore) maxScore = score;
    
    println("gen ", generation, " pop ", population, " fitness ", fitness);
    
    reset();
    population++;
    if(population==PopulationSize)
    {
      generation++;
      population = 0;
      GA.crossOver();
      GA.initFitness();
    }
  }
}