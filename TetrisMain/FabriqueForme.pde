class FabriqueForme {
  String pieces ="oiljtzs";
  Couleur [] tabCoul;
  
  public FabriqueForme() {
     tabCoul= new Couleur [20];
     tabCoul[0]= new Couleur(0,0,0);
     tabCoul[1]= new Couleur(255,0,0);
     tabCoul[2]= new Couleur(0,255,0);
     tabCoul[3]= new Couleur(0,0,255);
     tabCoul[4]= new Couleur(255,255,0);
     tabCoul[5]= new Couleur(255,0,255);
     tabCoul[6]= new Couleur(0,255,255);
     tabCoul[7]= new Couleur(255,150,0);
     tabCoul[8]= new Couleur(190,0,210);
     tabCoul[8]= new Couleur(64,64,64);
     tabCoul[8]= new Couleur(255,190,160);
     
    
  
  }
  
  private char getRandom(){
    char c = pieces.charAt((int) random(0,pieces.length()));
    return c;
  }
  
  public FormeTete getForme(){
    return getForme(getRandom());
  }
  
  public FormeTete getForme(char type) {
    Forme f, f1, f2, f3;
    FormeTete t = null;
    f=f1=f2=f3=null;
    switch (type) {
    case 'o':
    case 'O': 
      f = new Forme ("0000011001100000",tabCoul[1]);
      f.setSuivant(f);
      break;
    case 'i' :
    case 'I' : 
      f = new Forme ("0010001000100010",tabCoul[2]);
      f1 = new Forme ("0000000011110000",tabCoul[2]);
      f.setSuivant(f1);
      f1.setSuivant(f);
      break;
      case 'l':
      case 'L': 
        f = new Forme ("0100010001100000",tabCoul[3]);
        f1 = new Forme ("0000111010000000",tabCoul[3]);
        f2 = new Forme ("1100010001000000",tabCoul[3]);
        f3 = new Forme ("0010111000000000",tabCoul[3]);
        f.setSuivant(f1);
        f1.setSuivant(f2);
        f2.setSuivant(f3);
        f3.setSuivant(f);
      break;
      case 'j':
      case 'J': 
        f = new Forme ("0100010011000000", tabCoul[4]);
        f1 = new Forme ("1000111000000000", tabCoul[4]);
        f2 = new Forme ("0110010001000000", tabCoul[4]);
        f3 = new Forme ("0000111000100000", tabCoul[4]);
        f.setSuivant(f1);
        f1.setSuivant(f2);
        f2.setSuivant(f3);
        f3.setSuivant(f);
      break;
      case 't':
      case 'T': 
        f = new Forme ("0000011100100000",tabCoul[5]);
        f1 = new Forme ("0010011000100000",tabCoul[5]);
        f2 = new Forme ("0010011100000000",tabCoul[5]);
        f3 = new Forme ("0010001100100000",tabCoul[5]);
        f.setSuivant(f1);
        f1.setSuivant(f2);
        f2.setSuivant(f3);
        f3.setSuivant(f);
      break;
      case 'z':
      case 'Z': 
        f = new Forme ("0000011000110000",tabCoul[6]);
        f1 = new Forme ("0010011001000000",tabCoul[6]);
        
        f.setSuivant(f1);
        f1.setSuivant(f);
        
      break;
      case 's':
      case 'S': 
        f = new Forme ("0000001101100000",tabCoul[7]);
        f1 = new Forme ("0100011000100000",tabCoul[7]);
        
        f.setSuivant(f1);
        f1.setSuivant(f);
        
      break;
    default: 
      break;
    }
    t= new FormeTete(f);
    return t;
  }
}