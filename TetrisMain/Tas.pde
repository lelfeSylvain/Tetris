class Tas {
  private Carre [][] tas;
  private int [] hauteur;
  private static final int MAXHAUTEUR = 30;
  private static final int LARGEUR = 11;


  public Tas() {
    tas = new Carre[LARGEUR][MAXHAUTEUR];
    hauteur = new int[LARGEUR];
    for (int i=0; i<LARGEUR; i++) hauteur[i]=MAXHAUTEUR-1;
  }

  public void ajouter(Carre c, int x, int y) {
    if (y<MAXHAUTEUR) {
      //println (x + " - " + y);
      tas[x][y]=c;
      hauteur[x]=y-1;
    }
  }

  public int getHauteur(int i) {
    if (i>=LARGEUR || i<0)
      return MAXHAUTEUR-1;
    else return hauteur[i];
  }

  public int getMinHauteur() {
    int i, min=MAXHAUTEUR, h;
    for (i=0; i<LARGEUR; i++) {
      h=getHauteur(i);
      if (h<min) min=h;
    }
    return min;
  }

  public int ChercherLigne() {
    int i, j, nb;
    boolean trouve;
    int [] ligneASupprimer = new int[MAXHAUTEUR];
    nb=0;
    for (i=MAXHAUTEUR-1; i>=0; i--) {
      trouve=false;
      for (j=0; j<LARGEUR && !trouve; j++)
        trouve = (tas[j][i]==null);
      if (!trouve) {
        ligneASupprimer[nb++]=i;
        println(nb+" : "+i);
      }
    }
    if (nb>0) SupprimerLesLignes(ligneASupprimer, nb);
    return nb;
  }  

  private void SupprimerLesLignes(int [] l, int n) {
    int i, j, k;
    int nb=n-1;
    for (i=1; i<MAXHAUTEUR && nb>=0; i++) {
      if (i==l[nb]) {
        for (j=i-1; j>0; j--)
          for (k=0; k<LARGEUR; k++)
            tas[k][j+1]=tas[k][j];
        for (k=0; k<LARGEUR; k++)
          tas[k][0]=tas[k][0];
        nb--;
      }
    }
  }

  public void decomposer(int x, int y, IteratorForme unIF) {
    Object o;
    CarrePos c;
    while (unIF.hasNext()) {
      o=unIF.next() ;
      if (o!=null ) { // TODO vérifier que c'est bien un CarrePos
        c = (CarrePos) o;
        ajouter(c, x+c.getX(), y+c.getY());
      }
    }
  }

  public boolean estPossible(int x, int y, IteratorForme unIF) {
    Object o;
    CarrePos c;
    int i, j;
    boolean estPossible = true;
    while (unIF.hasNext()) {
      o=unIF.next() ;
      if (o!=null ) { // TODO vérifier que c'est bien un CarrePos
        c = (CarrePos) o;
        i=x+c.getX();
        j=y+c.getY();
        if (i<0 || i>=LARGEUR || j>=MAXHAUTEUR) estPossible=false;
        estPossible = estPossible && (tas[i][j]==null) ;
      }
    }
    return estPossible;
  }


  public void afficher(int x, int y) {
    int i, j;
    for (j=0; j<MAXHAUTEUR; j++) {
      for (i=0; i<LARGEUR; i++) {
        if (tas[i][j]!=null) tas[i][j].afficher(x+i*TAILLE, (j-4)*TAILLE+y, TAILLE);
      }
    }
  }
}