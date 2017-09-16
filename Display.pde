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
    background(102);
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
    text("Score = " + str(vl.getScore()), SquarePosX, SquarePosY/2);
  }
}