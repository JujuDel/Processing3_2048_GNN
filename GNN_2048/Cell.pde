public class Cell {

  boolean hasNumber = false;
  int number;
  int xCoor, yCoor, row, col;
  boolean merge = true;

  public Cell(int x, int y, int r, int c) {
    number = 2;
    xCoor = x;
    yCoor = y;
    row = r;
    col = c;
  }

  // Updates the position of a cell when cell is moving
  public void changeCell(Cell[][] cells, int r, int c) {
    cells[r][c].merge = merge;
    hasNumber = false;
    if (row == r) {
      xCoor -= sizeCell * (c - col);
    } else if (this.col == c) {
      yCoor -= sizeCell * (r - row);
    }
    cells[r][c].number = number;
    number = 2;
    cells[r][c].hasNumber = true;
  }

  // Draw the tile
  public void drawTile() {
    if (number == 2) {
      fill(238, 228, 218);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(119, 110, 101);
      text("" + number, xCoor + 58, yCoor + 95);
    }
    else if (number == 4) {
      fill(238, 228, 218);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(119, 110, 101);
      text("" + number, xCoor + 58, yCoor + 95);
    }
    else if (number == 8) {
      fill(242, 177, 121);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 55, yCoor + 95);
    }
    else if (number == 16) {
      fill(245, 149, 99);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 35, yCoor + 95);
    }
    else if (number == 32) {
      fill(246, 124, 99);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 35, yCoor + 95);
    }
    else if (number == 64) {
      fill(246, 94, 57);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 35, yCoor + 95);
    }
    else if (number == 128) {
      fill(237, 206, 115);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 20, yCoor + 95);
    }
    else if (number == 256) {
      fill(237, 202, 100);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 22, yCoor + 95);
    }
    else if (number == 512) {
      fill(237, 198, 81);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(60);
      fill(255);
      text("" + number, xCoor + 22, yCoor + 95);
    }
    else if (number == 1024) {
      fill(238, 199, 68);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(50);
      fill(255);
      text("" + number, xCoor + 14, yCoor + 95);
    }
    else if (number == 2048) {
      fill(236, 194, 48);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(50);
      fill(255);
      text("" + number, xCoor + 14, yCoor + 95);
    }
    else if (number == 4096) {
      fill(254, 61, 62);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(50);
      fill(255);
      text("" + number, xCoor + 14, yCoor + 95);
    }
    else if (number == 8192) {
      fill(255, 32, 33);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(50);
      fill(255);
      text("" + number, xCoor + 14, yCoor + 95);
    }
    else if (number == 16384 || number == 32768 || number == 65536) {
      fill(255, 32, 33);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(45);
      fill(255);
      text("" + number, xCoor + 5, yCoor + 95);
    }
    else if (number == 131072) {
      fill(255, 32, 33);
      rect(xCoor, yCoor, sizeCell, sizeCell);
      textSize(38);
      fill(255);
      text("" + number, xCoor + 3, yCoor + 95);
    }
  }
}
