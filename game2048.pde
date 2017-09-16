boolean gameOver = false;
boolean auto = true;
Value vl = new Value();
Display display = new Display();

void setup() 
{
  size(1000, 970);
} 

void draw() 
{
  if(auto && !gameOver) gameOver = vl.moveValue(floor(random(37,41)));
  display.Board(vl.getValue());
  display.Score();
  if(gameOver) display.GameOver();
}

void keyPressed() 
{
  if (!auto && !gameOver && key == CODED) gameOver = vl.moveValue(keyCode);
}