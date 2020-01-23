class Chip
{
  int x = 0;
  int y = 0;
  int r = 0;
  int c = 0;
  boolean full = false;
  
  Chip()
  {
  }
  
  Chip(int x, int y, int r, color c, boolean full)
  {
    this.x = x;
    this.y = y;
    this.r = r;
    this.c = c;
    this.full = full;
  }
  
  void display()
  {
    fill(c);
    ellipse(x, y, 2*r, 2*r);
  }
}