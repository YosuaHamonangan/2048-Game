boolean gameOver = false;
boolean auto = true;
Value vl = new Value();
Display display = new Display();
GeneticAlgorithm GA = new GeneticAlgorithm();
int PopulationSize = GA.PopulationSize;
int population = 0, generation = 0;
int delay = 500;
long maxScore = 0;

void setup() 
{
  size(1000, 970);
} 

void draw() 
{
  background(102);
  if(auto && !gameOver) 
  {
    delay(delay);
    AI();
    display.GenerationPopulation(generation, population, maxScore);
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
  if(key == ' ') reset();
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
  int counter = 0;
  while(!moved && counter<4)
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
    //println(index);
    //println(command);
    moved = vl.moveValue(37+index);
  }
  
  vl.addRand();
  gameOver = vl.checkLose();
  
  if(gameOver)
  {
    long score = vl.getScore();
    if(score>maxScore) maxScore = score;
    GA.setFitness(score,population);
    reset();
    population++;
    if(population==PopulationSize)
    {
      generation++;
      population = 0;
      GA.crossOver();
    }
  }
}