// Branche définie comme une position + direction + parent (une autre branche) : permet de tracer les lignes
class Branch
{
  // Attributs
  PVector position;
  PVector direction;
  Branch parent;
  float length = 5;
  int count = 0; // Pour compter le nombre d'attirance vers les feuilles
  PVector initialDirection; // Pour reset la branche
  
  // Constructeur
  Branch(PVector pos, PVector dir, Branch par)
  {
    position = pos;
    direction = dir;
    parent = par;
    initialDirection = direction.copy();
  }
  
  // Autre constructeur : construit une branche à partir d'une branche précédente
  Branch(Branch previousBranch)
  {
    position = previousBranch.nextPosition();
    direction = previousBranch.direction.copy(); // Garde la même direction
    parent = previousBranch;
    initialDirection = direction.copy();
  }
  
  public PVector nextPosition()
  {
    PVector movement = PVector.mult(direction, length);
    PVector nextPosition = PVector.add(position, movement);
    return nextPosition;
  }
  
  public void reset()
  {
    count = 0;
    direction = initialDirection.copy();
  }
}
