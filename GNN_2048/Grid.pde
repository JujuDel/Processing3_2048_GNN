public class Grid {
  Cell[][] cells;
  int loop = 0;
  boolean canSpawn = false;
  int maxLoop = 10;
  int score = 0;

  public Grid() {
    cells = new Cell[4][4];

    // Draws the boundary and lines of the grid
    rect(startCoor, startCoor, endCoor - startCoor, endCoor - startCoor);
    for (int i = startCoor; i <= endCoor; i += sizeCell) {
      smooth();
      strokeWeight(3);
      line(startCoor, i, endCoor, i);
      line(i, startCoor, i, endCoor);
    }
    // Creates the 4x4 grid of cell objects
    int x = startCoor;
    int y = startCoor;
    for (int r = 0; r < cells.length; r++) {
      for (int c = 0; c < cells[0].length; c++) {
        cells[r][c] = new Cell(x, y, r, c);
        x += sizeCell;
      }
      y += sizeCell;
      x = startCoor;
    }

    spawn();
    spawn();
  }

  
  // Gets the cells that have a numeric value either from bottom-up or up-bottom
  public ArrayList<Cell> getOccupiedCells(boolean botToUp) {
    ArrayList<Cell> cList = new ArrayList<Cell>();
    if (botToUp) {
      for (int r = cells.length-1; r >= 0; r--) {
        for (int c = cells[0].length-1; c >= 0; c--) {
          if (cells[r][c].hasNumber) {
            cList.add(cells[r][c]);
          }
        }
      }
    } else {
      for (int r = 0; r < cells.length; r++) {
        for (int c =0; c < cells[0].length; c++) {
          if (cells[r][c].hasNumber) {
            cList.add(cells[r][c]);
          }
        }
      }
    }
    return cList;
  }
  

  // Adds a 2 or 4 tile to the grid
  public void spawn() {
    int i = 0;
    while (i < 1) {
      int r = (int)random(0, 4);
      int c = (int)random(0, 4);
      if (!cells[r][c].hasNumber) {
        cells[r][c].hasNumber = true;
        cells[r][c].number *= (int)random(0, 2) + 1;
        i++;
      }
    }
  }
  
  // Moves the tiles based on arrow keys
  public void moveTilesKeyboard() {
    if (loop < maxLoop && keyCode != 0) {
      for (Cell c : getOccupiedCells(false)) {
        // Checks if key and new position of tile is valid
        if (keyCode == UP && c.yCoor > startCoor && c.row != 0) {
          // Moves tile if cell above it has no numeric value
          if (!cells[c.row-1][c.col].hasNumber) {
            c.yCoor -= sizeCell;
            // Position of tile is changed when tile moves to another cell location
            if ((c.yCoor - startCoor) % sizeCell == 0) {
              c.changeCell(cells, c.row - 1, c.col);
            }
            canSpawn = true;
          }
          // Merges tile if tile above it has the same number
          else if ((c.yCoor - startCoor) % sizeCell == 0 && cells[c.row - 1][c.col].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row - 1][c.col].merge = false;
            c.yCoor -= sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row - 1, c.col);
            canSpawn = true;
          }
        } else if (keyCode == LEFT && c.xCoor > startCoor && c.col !=0) {
          if (!cells[c.row][c.col - 1].hasNumber) {
            c.xCoor -= sizeCell;
            if ((c.xCoor - startCoor) % sizeCell == 0) {
              c.changeCell(cells, c.row, c.col - 1);
            }
            canSpawn = true;
          } else if ((c.xCoor - startCoor) % sizeCell == 0 && cells[c.row][c.col - 1].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row][c.col - 1].merge = false;
            c.xCoor -= sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row, c.col - 1);
            canSpawn = true;
          }
        } else if (keyCode == RIGHT && c.xCoor < endCoor && c.col != 3) {
          if (!cells[c.row][c.col + 1].hasNumber) {
            c.xCoor += sizeCell;
            if ((c.xCoor - startCoor) % sizeCell == 0) {
              c.changeCell(cells, c.row, c.col + 1);
            }
            canSpawn = true;
          } else if ((c.xCoor - startCoor) % sizeCell == 0 && cells[c.row][c.col + 1].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row][c.col + 1].merge = false;
            c.xCoor += sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row, c.col + 1);
            canSpawn = true;
          }
        } else if (keyCode == DOWN && c.yCoor < endCoor && c.row != 3) {
          if (!cells[c.row + 1][c.col].hasNumber) {
            c.yCoor += sizeCell;
            if ((c.yCoor - startCoor) % sizeCell == 0) {
              c.changeCell(cells, c.row + 1, c.col);
            }
            canSpawn = true;
          } else if ((c.yCoor - startCoor) % sizeCell == 0 && cells[c.row + 1][c.col].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row + 1][c.col].merge = false;
            c.yCoor += sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row + 1, c.col);
            canSpawn = true;
          }
        }
      }
    }
    // Resets loop, keyCode, cell's merge state, and spawns a tile
    else {
      loop = -1;
      keyCode = 0;
      for (Cell c : getOccupiedCells(false)) {
        c.merge = true;
      }
      if (getOccupiedCells(false).size() < 16 && canSpawn) {
        spawn();
      }
      canSpawn = false;
    }
    loop++;
  }

  public void moveTilesNN(String direction) {
    for (int repeat = 0; repeat < 4; repeat++) {
      for (Cell c : getOccupiedCells(false)) {
        if (direction == "UP" && c.yCoor > startCoor && c.row != 0) {
          // Moves tile if cell above it has no numeric value
          if (!cells[c.row - 1][c.col].hasNumber) {
            c.yCoor -= sizeCell;
            c.changeCell(cells, c.row - 1, c.col);
            canSpawn = true;
          }
          // Merges tile if tile above it has the same number
          else if ((c.yCoor - startCoor) % sizeCell == 0 && cells[c.row - 1][c.col].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row - 1][c.col].merge = false;
            c.yCoor -= sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row - 1, c.col);
            canSpawn = true;
          }
        } else if (direction == "LEFT" && c.xCoor > startCoor && c.col !=0) {
          // Moves tile if cell on the left has no numeric value
          if (!cells[c.row][c.col - 1].hasNumber) {
            c.xCoor -= sizeCell;
            c.changeCell(cells, c.row, c.col - 1);
            canSpawn = true;
          }
          // Merges tile if tile on the left has the same number
          else if ((c.xCoor - startCoor) % sizeCell == 0 && cells[c.row][c.col - 1].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row][c.col - 1].merge = false;
            c.xCoor -= sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row, c.col - 1);
            canSpawn = true;
          }
        } else if (direction == "RIGHT" && c.xCoor < endCoor && c.col != 3) {
          // Moves tile if cell on the right has no numeric value
          if (!cells[c.row][c.col + 1].hasNumber) {
            c.xCoor += sizeCell;
            c.changeCell(cells, c.row, c.col + 1);
            canSpawn = true;
          }
          // Merges tile if tile on the right has the same number
          else if ((c.xCoor - startCoor) % sizeCell == 0 && cells[c.row][c.col + 1].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row][c.col + 1].merge = false;
            c.xCoor += sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row, c.col + 1);
            canSpawn = true;
          }
        } else if (direction == "DOWN" && c.yCoor < endCoor && c.row != 3) {
          // Moves tile if cell under it has no numeric value
          if (!cells[c.row + 1][c.col].hasNumber) {
            c.yCoor += sizeCell;
            c.changeCell(cells, c.row + 1, c.col);
            canSpawn = true;
          }
          // Merges tile if tile under it has the same number
          else if ((c.yCoor - startCoor) % sizeCell == 0 && cells[c.row + 1][c.col].number == c.number && c.merge) {
            c.merge = false;
            cells[c.row + 1][c.col].merge = false;
            c.yCoor += sizeCell;
            c.number *= 2;
            score += c.number;
            c.changeCell(cells, c.row + 1, c.col);
            canSpawn = true;
          }
        }
      }
    }
    for (Cell c : getOccupiedCells(false)) {
      c.merge = true;
    }
    if (getOccupiedCells(false).size() < 16 && canSpawn) {
      spawn();
    }
    canSpawn = false;
  }

  // Checks if cell can still merge/move
  public boolean checkLoseHelper(int rp, int cp) {
    if (getOccupiedCells(true).size() >= 16) {
      for (int r = rp- 1; r <= rp + 1; r++) {
        for (int c = cp - 1; c <= cp + 1; c++) {
          if (r >= 0 && r <= 3 && c >= 0 && c <= 3  && (rp != r || cp != c) && (rp == r || cp == c)) {
            if (cells[rp][cp].number == cells[r][c].number) {
              return false;
            }
          }
        }
      }
      return true;
    }
    return false;
  }

  // If cell can still move/merge, player hasn't lost yet
  public boolean checkLose() {
    for (int r = 0; r<cells.length; r++) {
      for (int c = 0; c<cells[0].length; c++) {
        if (!checkLoseHelper(r, c)) {
          return false;
        }
      }
    }
    return true;
  }
}
