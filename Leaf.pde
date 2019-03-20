// Feuilles de l'arbre : points générés par l'utilisateur
class Leaf
{
  // Attributs
  PVector position;
  boolean reached = false;
  
  // Constructeur avec position random
  public Leaf()
  {
    // Définition d'une position random sur l'écran
    position = PVector.random3D();
    position.mult(random((width/2)));
    position.y -= 100; // Pour avoir un bon placement initial
  }
  
  // Constructeur avec position donnée
  public Leaf(PVector pos)
  {
    position = pos;
  }
  
  // Marque la feuille comme atteinte
  public void reached()
  {
    reached = true;
  }
  
  // Fonction d'affichage
  public void show()
  {
    fill(204, 102, 0); // Couleur orangée
    noStroke(); // Pas de bordure
    pushMatrix();
    translate(position.x, position.y, position.z); // Transition au bon endroit
    ellipse(0, 0, 4, 4); // Affiché en tant que cercles (2D), moins gourmand que des spheres
    popMatrix();
  }
}
