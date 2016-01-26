// variables globales
Tas unTas; // gère la zone de jeu
FormeTete maForme, prochain; // la forme qui tombe
int x, y, // coordonnées de maForme
  dy, dx, // gère le déplacement actuelle de maForme  entre 2 positions
  largeurJeu, hauteurJeu, // contour du jeu
  TAILLE, // taille des carrés en pixel
  score,nbLigneTotal, // mémorise un score
  xTas, yTas, // coordonnées de unTas dans la fenêtre
  increment, chute, vitesseChute; // nécessaire pour les déplacements de maForme
FabriqueForme maFabrique; // Fabrique de forme
boolean leJeuContinue, estEnPause;


void setup() {
  TAILLE=15;
  xTas=0;
  yTas=4*TAILLE;
  largeurJeu = TAILLE*(Tas.LARGEUR);
  hauteurJeu = TAILLE*(Tas.MAXHAUTEUR-4);
  // initialise la fabrique
  // TODO paramétrer ici la taille maximum d'une forme
  maFabrique = new FabriqueForme();
  
  // initialise la fenêtre
  size(300, 500);
  // lance la première forme
  prochain=maFabrique.getForme();
  lancerLeJeu();
}

void lancerLeJeu() {
  estEnPause = false;
  vitesseChute=1;
  score=nbLigneTotal =0;
  // initialise la zone de jeu
  unTas = new Tas();
  creerUneForme();
}

void creerUneForme() {
  // génère une forme au hasard
  maForme=prochain;
  prochain = maFabrique.getForme();

  // initialise la position 
  x=3;
  y=0;
  // initialise la vitesse de la chute
  dy=dx=increment=0;
  chute=vitesseChute;
  leJeuContinue=!(unTas.getMinHauteur()<4) && (unTas.estPossible(x, y, maForme.creerIterateur()));
}

void draw() {
  // efface la fenêtre en la remplissant d'un carré blanc
  background(255);
  noStroke();
  fill(0);
  rect(xTas, yTas, largeurJeu, hauteurJeu);
  // trace le contour de la zone de jeu
  stroke(0);
  line(xTas, yTas, xTas, yTas+hauteurJeu);
  line(xTas, yTas+ hauteurJeu, xTas+largeurJeu, yTas+hauteurJeu);
  line(xTas+largeurJeu, yTas+hauteurJeu, xTas+largeurJeu, yTas);
  // affiche la prochaine forme
  prochain.afficher(xTas+largeurJeu+10, 10, 10);
  // affiche le score
  fill(0);
  textSize(16);
  String strScore="Score : "+score+"\nNiveau : "+vitesseChute+"\nNb Ligne"+(nbLigneTotal>1?"s ":" ")+": "+nbLigneTotal;
  strScore = strScore+"\n min = "+unTas.getMinHauteur();
  afficherTexte(strScore,xTas+largeurJeu+(width-largeurJeu-xTas)/2, yTas+ 55);
  // affiche les carrés fixes
  unTas.afficher(xTas, yTas);
  // affiche la forme du moment
  maForme.afficher(TAILLE*x+dx+xTas, TAILLE* y+dy, TAILLE);
  if (estEnPause) {
    mettreEnPause();
  } else if (leJeuContinue ) {
    // la forme bouge
    bouger();
    chuter();
  }
  else afficherTexte("Voulez-vous recommencer ? (O/N)",width/2, yTas+hauteurJeu+20);
}

void mettreEnPause(){
  
    fill(255,100,100);
    noStroke();
    rect(xTas+1,yTas, largeurJeu-1, hauteurJeu);
    textSize(32);
    afficherTexte("PAUSE", largeurJeu /2,(int) (yTas+ hauteurJeu*0.5),200);
}

void afficherTexte(String m, int x, int y, int coul){
  fill(coul);
  text(m,x-textWidth(m)/2,y);
}
void afficherTexte(String m, int x, int y){
  afficherTexte(m,x,y,0);
}

void bouger() {
  // incrémente le déplacement de la forme
  dx+=increment;
  // si ce déplacement atteint la nouvelle position, alors la position est atteinte
  if (increment>0 && dx >=TAILLE) { // à droite
    increment=0; 
    x++; // alors la position est atteinte
    dx=0;
  } else if (increment<0 && dx<= -TAILLE) { // à gauche
    increment=0;
    x--;
    dx=0;
  }
  // on ne gère pas la chute ici
}

void chuter() {
  // incrémente le déplacement de la forme en chute libre
  dy+=chute;
  // si ce déplacement atteint la nouvelle position,
  if (dy>=TAILLE) {
    dy=0;
    y++; // alors la position est atteinte
    // vérifions si elle se pose
    // Si il est possible d'aller à la case en dessous
    if (!unTas.estPossible(x, y+1, maForme.creerIterateur())) {// si elle se pose, 
      // on la détruit pour alimenter le tas
      unTas.decomposer(x, y, maForme.creerIterateur());
      // on crée une nouvelle forme
      creerUneForme();
      // vérifions si une ligne a été créée
      score+=calculerScore(unTas.ChercherLigne());
    }
  }
}

int calculerScore(int n) {
  int sc=1;
  nbLigneTotal+=n;
  vitesseChute=1+(nbLigneTotal/5);
  for (int i=1; i<=n; i++) sc*=10;
  if (sc==1) return 0;
  else return sc;
}

void keyPressed() {
  // une touche a été frappée
  int delta=0;
  if (key == CODED) {//touche spéciale
    switch (keyCode) // laquelle ?
    {
    case UP :// flèche haut
      // on fait récupère la prochaine rotation de la forme actuelle
      Forme uneForme= maForme.getTete().getSuivant();
      // si il est possible de la faire tourner 
      if (unTas.estPossible(x, y, uneForme.creerIterateur())) {
        maForme.tourner();
      }
      break;
    case RIGHT :// flèche droite
      // si il est possible d'aller à droite
      if (dy>0) delta=1;
      if (unTas.estPossible(x+1, y+delta, maForme.creerIterateur()))
        increment=2;
      break;
    case DOWN :// flèche bas
      chute=10; // on accélère la chute
      break;
    case LEFT :// flèche gauche
      // si il est possible d'aller à gauche
      if (dy>0) delta=1;
      if (unTas.estPossible(x-1, y+delta, maForme.creerIterateur()))
        increment=-2;
      break;
    }
  } else if (key==32) { 

    estEnPause = !estEnPause;
  } else if (!leJeuContinue) 
    if (key=='o' || key =='O') lancerLeJeu();
    else if (key=='n' || key=='N') exit();
}