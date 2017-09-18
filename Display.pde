class Display
{
  int SquareSize = 200;
  int SquarePosX = 100;
  int SquarePosY = 120;
  int SquareN = 4;
  
  int TextGameOverSize = 125;
  int TextNumberSize = 125;
  int TextScoreSize = 40;
  
  void Board(int number[][])
  {
    textAlign(CENTER, CENTER);
    textSize(TextNumberSize);
    for(int row=0;row<SquareN;row++)
    {
      for(int column=0;column<SquareN;column++)
      {
        fill(255);
        rect(SquarePosX + column*SquareSize, SquarePosY + row*SquareSize, SquareSize, SquareSize);
        
        fill(0,0,255);
        if(number[row][column]!=0) text(str((int)pow(2,number[row][column])), SquarePosX + (column+0.5)*SquareSize, SquarePosY + (row+0.45)*SquareSize);
      }
    }
  }
  
  void GameOver()
  {
    textAlign(CENTER, CENTER);
    textSize(TextGameOverSize);
    fill(0,255,0);
    text("Game Over", width/2, height/2);
  }
  
  void Score()
  {
    textAlign(LEFT, CENTER);
    textSize(TextScoreSize);
    fill(255);
    text("Score = " + str((int) vl.getScore()), SquarePosX, SquarePosY/2);
  }
  
  void GenerationPopulation(int generation, int population, long maxScore)
  {
    textAlign(LEFT, TOP);
    textSize(TextScoreSize);
    fill(255);
    text("Gen = " + str(generation), SquarePosX+250, 0);
    
    textAlign(LEFT, BOTTOM);
    text("Pop = " + str(population), SquarePosX+250, SquarePosY);
    
    textAlign(LEFT, CENTER);
    text("Max Scr = " + str((int)maxScore), SquarePosX+450, SquarePosY/2);
  }
}