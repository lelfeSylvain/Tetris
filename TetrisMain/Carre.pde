class Carre {
  private Couleur couleur ;
  
 public Carre(Couleur coul){
   couleur =coul;
 }

 public void afficher(int x, int y, int facteur){
   stroke(0);
   int [] c = couleur.getCouleur();
  fill(c[0],c[1],c[2]);
  rect(x, y, facteur, facteur);
 }
 
 public Couleur getCouleur(){return couleur;}
 
 
}