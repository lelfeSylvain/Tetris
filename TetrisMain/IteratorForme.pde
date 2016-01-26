import java.util.Iterator;
public class IteratorForme implements Iterator {
  private CarrePos [][] maForme;
  private int x, y, i, j;
  public IteratorForme(CarrePos[][] f, int dx, int dy ) {
    x=dx;
    y=dy;
    maForme = f;
    i=0;
    j=0;
  }
  public Object next() {
    Object toto = maForme[i++][j];
    if (i==x) {
      i=0;
      j++;
    }
    return toto;
  }
  public boolean hasNext() {
    return !(i==0 && j ==y);
  }

  public void remove() {
  }
}