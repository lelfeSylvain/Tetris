class Forme {
  private CarrePos [][] maForme;
  private Forme suivant;
  public static final int X=4;
  public static final int Y=4;

  public Forme(String t, Couleur coul) {
    int i, j, k ;
    suivant=null;
    maForme = new CarrePos[X][Y];
    i=j=0;
    for (k=0; k<t.length(); k++) {
      if (((int)t.charAt(k))-48==1)
        maForme[i][j]=new CarrePos(coul,i, j);
      i++;
      if (i>=X) {
        i=0;
        j++;
      }
    }
  }

  public Forme(Forme f) {
    
    int i, j;
    suivant=null;
    maForme = new CarrePos[X][Y];
    for(j=0;j<Y;j++)
    for (i=0; i<X; i++) {
        if (f.maForme[i][j]!=null) maForme[i][j]=new CarrePos(f.maForme[i][j].getCouleur(),i, j);
     
    }
  }
  // défini la forme suivante dans la liste des formes (permet la rotation)
  public void setSuivant(Forme s) {
    suivant = s;
  }
  // retourne la forme suivante dans la liste des formes (permet la rotation)
  public Forme getSuivant() {
    return suivant;
  }

  // affiche en mode graphique la forme
  public void afficher(int x, int y, int facteur) {
    int i, j;
    /*noFill();
     stroke(0);
     rect(x, y, X*facteur, Y*facteur);*/
    for (j=0; j<Y; j++) {
      for (i=0; i<X; i++)
      {
        if (maForme[i][j]!=null) {
          maForme[i][j].afficher(x+i*facteur, y+j*facteur,facteur);
          
        }
    
      }
    }
  }

  // affiche en mode texte la forme (déprécié)
  
    public void afficher() {
    int i, j;
    for (j=0; j<Y; j++) {
      for (i=0; i<X; i++)
      {
        print(maForme[i][j]);
      }
      println();
    }
  }

  public IteratorForme creerIterateur() {
    IteratorForme it = new IteratorForme(maForme, X, Y);
    return it;
  }



}