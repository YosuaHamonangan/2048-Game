class Value 
{ 
  int SquareN = 4;
  int[][] values = new int[SquareN][SquareN];
  
  Value () 
  {
    for(int row=0;row<SquareN;row++)
    {
      for(int column=0;column<SquareN;column++)
      {
        values[row][column] = 0;
      }
    }
    
    addRand();
    addRand();
  } 
  
  int[][] getValue() 
  { 
    return values;
  }
  
  float[] getValue_1d() 
  {
    int max = 0;
    float[] values_1d = new float[SquareN*SquareN];
    for(int row=0;row<SquareN;row++)
    {
      for(int column=0;column<SquareN;column++)
      {
        values_1d[row*SquareN + column] = values[row][column];
        if(values[row][column]>max) max = values[row][column];
      }
    }
    
    for(int n=0;n<SquareN*SquareN;n++)
    {
      values_1d[n] /= max;
    }
    return values_1d;
  }
  
  void addRand()
  {
    int row;
    int column;
    
    do
    {
      row = floor(random(SquareN));
      column = floor(random(SquareN));
    }while(values[row][column]!=0);
    
    if(random(1)<0.9) values[row][column]++;
    else values[row][column]+=2;
  }
  
  boolean moveValue(int direction)
  {
    boolean moved = false;
    
    switch(direction) 
    {
    case UP:
      for(int column=0;column<SquareN;column++)
      {
        int lastIndex = 0;
        boolean lastSame = true;
        for(int row=0;row<SquareN;row++)
        {
          int temp = values[row][column];
          if(temp!=0)
          {
            if(!lastSame && values[lastIndex-1][column]==temp)
            {
              moved = true;
              values[row][column] = 0;
              values[lastIndex-1][column]++;
              lastSame = true;
            }
            else 
            {
              if(row!=lastIndex) moved = true;
              values[row][column] = 0;
              values[lastIndex][column]=temp;
              lastIndex++;
              lastSame = false;
            }
          }
        }
      }
    break;
      
    case DOWN: 
    for(int column=0;column<SquareN;column++)
      {
        int  lastIndex = SquareN-1;
        boolean lastSame = true;
        for(int row=SquareN-1;row>=0;row--)
        {
          int temp = values[row][column];
          if(temp!=0)
          {
            if(!lastSame && values[lastIndex+1][column]==temp)
            {
              values[row][column] = 0;
              values[lastIndex+1][column]++;
              lastSame = true;
              moved = true;
            }
            else
            {
              if(row!=lastIndex) moved = true;
              values[row][column] = 0;
              values[lastIndex][column]=temp;
              lastIndex--;
              lastSame = false;
            }
          }
        }
      }
    break;
    
    case LEFT: 
      for(int row=0;row<SquareN;row++)
      {
        int lastIndex = 0;
        boolean lastSame = true;
        for(int column=0;column<SquareN;column++)
        {
          int temp = values[row][column];
          if(temp!=0)
          {
            if(!lastSame && values[row][lastIndex-1]==temp)
            {
              values[row][column] = 0;
              values[row][lastIndex-1]++;
              lastSame = true;
              moved = true;
            }
            else
            {
              if(column!=lastIndex) moved = true;
              values[row][column] = 0;
              values[row][lastIndex]=temp;
              lastIndex++;
              lastSame = false;
            }
          }
        }
      }
    break;
      
    case RIGHT: 
    for(int row=0;row<SquareN;row++)
      {
        int  lastIndex = SquareN-1;
        boolean lastSame = true;
        for(int column=SquareN-1;column>=0;column--)
        {
          int temp = values[row][column];
          if(temp!=0)
          {
            if(!lastSame && values[row][lastIndex+1]==temp)
            {
              values[row][column] = 0;
              values[row][lastIndex+1]++;
              lastSame = true;
              moved = true;
            }
            else
            {
              if(column!=lastIndex) moved = true;
              values[row][column] = 0;
              values[row][lastIndex]=temp;
              lastIndex--;
              lastSame = false;
            }
          }
        }
      }
    break;
    
    default:
    break;
    }
    
    return moved;
  }
  
  boolean checkLose()
  {
    boolean canMove = false;
    for(int row=0;row<SquareN;row++)
    {
      for(int column=0;column<SquareN;column++)
      {
        if(values[row][column] == 0) canMove = true;
      }
    }
    if(!canMove)
    {
      for(int row=0;row<SquareN;row++)
      {
        for(int column=1;column<SquareN;column++)
        {
          if(values[row][column] == values[row][column-1]) canMove = true;
        }
      }
      
      for(int column=0;column<SquareN;column++)
      {
        for(int row=1;row<SquareN;row++)
        {
          if(values[row][column] == values[row-1][column]) canMove = true;
        }
      }
    }
    return !canMove;
  }
  
  long getScore()
  {
    long Score = 0;
    for(int row=0;row<SquareN;row++)
    {
      for(int column=0;column<SquareN;column++)
      {
        if(values[row][column]!=0) Score += pow(2,values[row][column]);
      }
    }
    return Score;
  }
} 