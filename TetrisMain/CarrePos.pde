class CarrePos extends Carre {
  private int x, y;
  public CarrePos(Couleur coul,  int i, int j) {
    super(coul);
    x=i;
    y=j;
  }

  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
}