int vertspace = 50;
int hospace = 70;
int topgap = 40;
int leftgap = 40;
int rows = 6;
int cols = 7;
int bottomrow = rows - 1;
boolean greenturn = true;
boolean play = true;
String boardfile = "";
String loadboardfile = "";

Chip[][] chip = new Chip[rows][cols];
Table board, loadboard;

void setup()
{
  size(715, 605);
  for (int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      int rad = 35;
      int x = leftgap + c * (rad + hospace);
      int y = topgap + r * (rad + vertspace);
      chip[r][c] = new Chip(x, y, rad, color(255, 255, 255), false);
    }
  }
}

void draw()
{ 
  background(255, 255, 0);
  noStroke();
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      chip[r][c].display();
    }
  } 
  //Save Button
  noStroke();
  fill(20, 100, 230);
  ellipse(92.5, 550, 70, 70);
  textSize(18);
  fill(255);
  text("Save", 73, 547);
  text("Game", 67, 567);
  //Reset Button
  fill(200, 50, 150);
  ellipse(617.5, 550, 70, 70);
  fill(255);
  text("Reset", 593, 547);
  text("Game", 592, 567);
  //Load Button
  fill(66, 244, 176);
  ellipse(355, 550, 70, 70);
  fill(255);
  text("Load", 333, 547);
  text("Game", 331, 567);
  fill(0);
  textSize(25);
  if(play == true)
  {
    if(greenturn == true)
    {
      text("Green Turn", 155, 560);
    }
    if(greenturn == false)
    {
      text("Red Turn", 435, 560);
    }
  }
  reset();
  if(greenWin())
  {
    textSize(54);
    fill(0);
    text("Green Player Wins!", width/6, height/2);
    play = false;
  }
  if(redWin())
  {
    textSize(54);
    fill(0);
    text("Red Player Wins!", width/6, height/2);
    play = false;
  }
}

double distance(double x1, double y1, double x2, double y2)
{
  double xDiff = Math.pow(x2 - x1, 2);
  double yDiff = Math.pow(y2 - y1, 2);
  return Math.sqrt(xDiff + yDiff); 
}

void greenturn()
{
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(distance(mouseX, mouseY, chip[r][c].x, chip[r][c].y) < 35 && chip[r][c].full == false)
      {
        for(int i = 5; i >= 0; i--)
        {
          if(chip[i][c].full == false)
          {
            chip[i][c].c = color(0, 255, 0);
            chip[i][c].full = true;
            greenturn = false;
            break;
          }
        }
      }
    }
  }
}

void redturn()
{
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(distance(mouseX, mouseY, chip[r][c].x, chip[r][c].y) < 35 && chip[r][c].full == false)
      {
        for(int i = 5; i >= 0; i--)
        {
          if(chip[i][c].full == false)
          {
            chip[i][c].c = color(255, 0, 0);
            chip[i][c].full = true;
            greenturn = true;
            break;
          }
        }
      }
    }
  }
}

boolean greenWin()
{
  if(horizontalCheckGreen() || verticalCheckGreen() || greencheckbottomltopr() || greenchecktoplbottomr())
  {
    return true;
  }
  return false;
}

boolean redWin()
{
  if(horizontalCheckRed() || verticalCheckRed() || redcheckbottomltopr() || redchecktoplbottomr())
  {
    return true;
  }
  return false;
}

boolean horizontalCheckGreen()
{
  boolean win = false;
  int green = 0;
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(chip[r][c].c == color(0, 255, 0))
      {
        green += 1;
      }
      if(r != 0)
      {
        if(chip[r][c].c != color(0, 255, 0) || chip[r-1][6].c == color(0, 255, 0))
        {
          green = 0;
        }
      }
      if(r == 0)
      {
        if(chip[r][c].c != color(0, 255, 0))
        {
          green = 0;
        }
      }
      if(green >= 4)
      {
        win = true;
        break;
      }
    }
  }
  return win;
}

boolean verticalCheckGreen()
{
  boolean win = false;
  int green = 0;
  for(int c = 0; c < cols; c++)
  {
    for(int r = 0; r < rows; r++)
    {
      if(chip[r][c].c == color(0, 255, 0))
      {
        green += 1;
      }
      if(c != 6)
      {
        if(chip[r][c].c != color(0, 255, 0) || chip[0][c+1].c == color(0, 255, 0))
        {
          green = 0;
        }
      }
      if(c == 6)
      {
        if(chip[r][c].c != color(0, 255, 0))
        {
          green = 0;
        }
      }
      if(green >= 4)
      {
        win = true;
        break;
      }
    }
  }
  return win;
}

boolean horizontalCheckRed()
{
  boolean win = false;
  int red = 0;
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(chip[r][c].c == color(255, 0, 0))
      {
        red += 1;
      }
      if(r != 0)
      {
        if(chip[r][c].c != color(255, 0, 0) || chip[r-1][6].c == color(255, 0, 0))
        {
          red = 0;
        }
      }
      if(r == 0)
      {
        if(chip[r][c].c != color(255, 0, 0))
        {
          red = 0;
        }
      }
      if(red >= 4)
      {
        win = true;
        break;
      }
    }
  }
  return win;
}

boolean verticalCheckRed()
{
  boolean win = false;
  int red = 0;
  for(int c = 0; c < cols; c++)
  {
    for(int r = 0; r < rows; r++)
    {
      if(chip[r][c].c == color(255, 0, 0))
      {
        red += 1;
      }
      if(c != 6)
      {
        if(chip[r][c].c != color(255, 0, 0) || chip[0][c+1].c == color(255, 0, 0))
        {
          red = 0;
        }
      }
      if(c == 6)
      {
        if(chip[r][c].c != color(255, 0, 0))
        {
          red = 0;
        }
      }
      if(red >= 4)
      {
        win = true;
        break;
      }
    }
  }
  return win;
}

boolean greencheckbottomltopr()
{
  boolean win = false;
  int green = 0;
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(r >= 3 && c <= 3)
      {
        if(chip[r][c].c == color(0, 255, 0))
        {
          green = 1;
          for(int counter = 1; counter < 4; counter++)
          {
            if(chip[r][c].c == chip[r-counter][c+counter].c)
            {
              green += 1;
            }
            else if(chip[r][c].c != chip[r-counter][c+counter].c)
            {
              green = 0;
            }
          }
          if(green >= 4)
          {
            win = true;
          }
        }
      }
    }
  }
  return win;
}

boolean greenchecktoplbottomr()
{
  boolean win = false;
  int green = 0;
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(r <= 2 && c <= 3)
      {
        if(chip[r][c].c == color(0, 255, 0))
        {
          green = 1;
          for(int counter = 1; counter < 4; counter++)
          {
            if(chip[r][c].c == chip[r+counter][c+counter].c)
            {
              green += 1;
            }
            if(chip[r][c].c != chip[r+counter][c+counter].c)
            {
              green = 0;
            }
          }
          if(green >= 4)
          {
            win = true;
          }
        }
      }
    }
  }
  return win;
}

boolean redcheckbottomltopr()
{
  boolean win = false;
  int red = 0;
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(r >= 3 && c <= 3)
      {
        if(chip[r][c].c == color(255, 0, 0))
        {
          red = 1;
          for(int counter = 1; counter < 4; counter ++)
          {
            if(chip[r][c].c == chip[r-counter][c+counter].c)
            {
              red += 1;
            }
            else if(chip[r][c].c != chip[r-counter][c+counter].c)
            {
              red = 0;
            }
          }
          if(red >= 4)
          {
            win = true;
          }
        }
      }
    }
  }
  return win;
}

boolean redchecktoplbottomr()
{
  boolean win = false;
  int red = 0;
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(r <= 2 && c <= 3)
      {
        if(chip[r][c].c == color(255, 0, 0))
        {
          red = 1;
          for(int counter = 1; counter < 4; counter++)
          {
            if(chip[r][c].c == chip[r+counter][c+counter].c)
            {
              red += 1;
            }
            if(chip[r][c].c != chip[r+counter][c+counter].c)
            {
              red = 0;
            }
          }
          if(red >= 4)
          {
            win = true;
          }
        }
      }
    }
  }
  return win;
}

void saveGame()
{
  if(distance(mouseX, mouseY, 92.5, 550) < 35)
  {
    board = new Table();
    board.addColumn("row");
    board.addColumn("column");
    board.addColumn("x-position");
    board.addColumn("y-position");
    board.addColumn("radius");
    board.addColumn("red color");
    board.addColumn("green color");
    board.addColumn("blue color");
    board.addColumn("full");
    board.addColumn("turn");
    String date = str(month()) + "-" + str(day()) + 
    "_(" + str(hour()) + "." + str(minute()) + "." + str(second()) + ")"; 
    for(int r = 0; r < rows; r++)
    {
      for(int c = 0; c < cols; c++)
      {
        TableRow newRow = board.addRow();
        newRow.setInt("row", r);
        newRow.setInt("column", c);
        newRow.setInt("x-position", chip[r][c].x);
        newRow.setInt("y-position", chip[r][c].y);
        newRow.setInt("radius", chip[r][c].r);
        newRow.setInt("red color", int(red(chip[r][c].c)));
        newRow.setInt("green color", int(green(chip[r][c].c)));
        newRow.setInt("blue color", int(blue(chip[r][c].c)));
        newRow.setString("full", str(chip[r][c].full));
      }
    }
    TableRow oneNewRow = board.addRow();
    if(greenturn == true)
    {
      oneNewRow.setString("turn", "Green");
    }
    if(greenturn == false)
    {
      oneNewRow.setString("turn", "Red");
    }
    saveTable(board, "board" + date + ".csv");
  }
}

String fileSelected(File selection)
{
  if(selection == null)
  {
    println("Window was closed"); 
    return null;
  }
  else
  {
    println("User Selected: " + selection.getName());
    boardfile = selection.getName();
    loadboard = loadTable(boardfile, "header");
    for(int counter = 1; counter < rows * cols; counter++)
    {
      TableRow row = loadboard.getRow(counter);
      int loadrow = row.getInt("row");
      int loadcolumn = row.getInt("column");
      int loadx = row.getInt("x-position");
      int loady = row.getInt("y-position");
      int loadr = row.getInt("radius");
      int loadred = row.getInt("red color");
      int loadgreen = row.getInt("green color");
      int loadblue = row.getInt("blue color");
      boolean loadfull = boolean(row.getString("full"));
      chip[loadrow][loadcolumn] = new Chip(loadx, loady, 
      loadr, color(loadred, loadgreen, loadblue), loadfull);
    }
    TableRow newRow = loadboard.getRow(42);
    greenturn = boolean(newRow.getString("turn"));
    return boardfile;
  }
}

void loadGame()
{
  if(distance(mouseX, mouseY, 335, 550) < 35)
  {
    selectInput("Select a file", "fileSelected");
  }
}

void reset()
{
  if(distance(mouseX, mouseY, 617.5, 550) < 35 && mousePressed)
  {
    for(int r = 0; r < rows; r++)
    {
      for(int c = 0; c < cols; c++)
      {
        chip[r][c].c = color(255, 255, 255);
        chip[r][c].full = false;
        greenturn = true;
        play = true;
      }
    }
  }
}

void mouseClicked()
{
  turn();
  saveGame();
  loadGame();
}

void turn()
{
  if(play == true)
  {
    if(greenturn == true)
    {
      greenturn();
    }
    
    else if(greenturn == false)
    {
      redturn();
    }
  }
}