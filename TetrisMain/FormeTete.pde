class FormeTete {
  private Forme tete;
  public FormeTete(Forme t) {
    tete = t;
  }
  public void tourner() {
    tete = tete.getSuivant();
  }

  public void afficher() {
    tete.afficher();
  }

  public void afficher(int x, int y, int f) {
    tete.afficher(x, y, f);
  }

  

  public Forme getTete() {
    return tete;
  }



  public IteratorForme creerIterateur() {
    return tete.creerIterateur();
  }
}