int SquareSize = 200;
int SquarePosX = 100;
int SquarePosY = 50;
int SquareN = 4;

Value vl = new Value();

void setup() 
{
  size(1000, 900);
  textSize(125);
  textAlign(CENTER, CENTER);
} 

void draw() 
{
  Display(vl.getValue());
}

void Display(int number[][])
{
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

void keyPressed() 
{
  if (key == CODED) 
  {
    if(vl.moveValue(keyCode)) vl.addRand();
  }
}

class Value 
{ 
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
  
  void addRand()
  {
    int row;
    int column;
    
    do
    {
      row = floor(random(SquareN));
      column = floor(random(SquareN));
    }while(values[row][column]!=0);
    
    if(random(1)<0.7) values[row][column]++;
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
} 