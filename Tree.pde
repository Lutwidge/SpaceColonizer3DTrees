// Arbre complet qui contient l'algorithme de Space Colonization
class Tree
{
  // Attributs
  ArrayList<Leaf> leaves = new ArrayList<Leaf>(); // Feuilles de l'arbre
  ArrayList<Branch> branches = new ArrayList<Branch>(); // Branches de l'arbre
       
  // Constructeur
  public Tree()
  { }
  
  // Fonction pour ajouter des feuilles
  public void addLeaf(PVector position)
  {
    leaves.add(new Leaf(position));
  }
  
  // Fonction pour initialiser l'arbre
  public void initialize()
  {
    // On initialise les branches avec une racine sans parent, qui pointe vers le haut
    Branch root = new Branch(new PVector(width/2, height + 300), new PVector(0, -1), null);  
    branches.add(root); 
    Branch currentBranch = root;
    
    // On construit des branches tant qu'aucune feuille n'est à portée : tronc de l'arbre
    // On utilise un compteur pour limiter le nombre d'itérations si aucune feuille nest à portée
    int compteur = 0;
    while (!isCloseToLeaf(currentBranch) && compteur < 220)
    {
      Branch trunk = new Branch(currentBranch);
      branches.add(trunk);
      currentBranch = trunk;
      compteur++;
    }
  }
  
  // Fonction qui vérifie la distance de chaque feuille à une branche
  // Algorithme lancé que si elle est inférieure à maxDistance
  private boolean isCloseToLeaf(Branch branch)
  {
    for (Leaf leaf : leaves)
    {
      float distToRoot = PVector.dist(branch.position, leaf.position);
      if (distToRoot < maxDistance)
      {
        return true;
      }
    }
    return false;
  }
  
  // Algorithme pour la progression de l'arbre (space colonization)
  public void grow()
  {
    // Pour chaque feuille, voir quelle est la branche la plus proche, puis l'attirer s'il y en a une
    for (Leaf leaf : leaves)
    {
      Branch closestBranch = null;
      PVector closestDirection = null;
      float recordedDistance = maxDistance + 1;
      
      for (Branch branch : branches)
      {
        // Calcul de la distance entre la branche et la feuille
        PVector direction = PVector.sub(leaf.position, branch.position);
        float distance = direction.mag();
        
        if (distance < minDistance) // La feuille a été atteinte, on a trouvé la feuille la plus proche, on peut arrêter
        {
          leaf.reached();
          closestBranch = null;
          break;
        }
        else if (distance > maxDistance) // La feuille est trop loin pour la branche
        {
          // Ne rien faire
        }
        else if (closestBranch == null || distance < recordedDistance) // C'est alors la branche la plus proche
        {
          closestBranch = branch;
          closestDirection = direction;
          recordedDistance = distance;
        }
      }
      
      if (closestBranch != null) // Une plus proche branche a été trouvée
      {
        // On attire la branche vers la feuille en lui ajoutant la direction vers cette feuille
        closestDirection.normalize();
        closestBranch.direction.add(closestDirection);
        closestBranch.count++;
      }     
    }
    
    // Destruction des feuilles atteintes
    // On détruit en partant de la fin, plus efficace
    for (int i = leaves.size() - 1; i >= 0; i--)
    {
      if (leaves.get(i).reached)
      {
        leaves.remove(i);
      }
    }
    
    // Créer une nouvelle branche pour chaque branche attirée
    for (int i = branches.size() - 1; i>= 0; i--)
    {
      Branch branch = branches.get(i);
      if (branch.count > 0)
      {
        // Création d'une nouvelle branche ayant branch pour parent
        branch.direction.div(branch.count); // Moyenne des directions ajoutées
        PVector noise = PVector.random2D();
        noise.setMag(0.4);
        branch.direction.add(noise); // Ajout d'un léger bruit pour que 2 feuilles ne soient pas équidistantes
        branch.direction.normalize();
        Branch newBranch = new Branch(branch);
        branches.add(newBranch);
        branch.reset(); // Reset de la branche d'origine
      }
    }
  }
  
  // Fonction pour afficher toutes les feuilles et branches
  public void show()
  {
    // On parcourt toutes les feuilles et on les affiche
    for (Leaf leaf : leaves)
    {
      leaf.show();
    }
    
    // On parcourt les branches et on crée des lignes en utilisant la position de leur parent
     for (int i = 0; i < branches.size(); i++)
     {
      Branch branch = branches.get(i);
      if (branch.parent != null)
      {
        strokeWeight(map(i, 0, branches.size(), 8, 0.5)); // Réduit l'épaisseur au fur et à mesure
        stroke(i * 0.1f); // Eclaircit au fur et à mesure
        line(branch.position.x, branch.position.y, branch.position.z, branch.parent.position.x, branch.parent.position.y, branch.parent.position.z);
      }
    }
  }
}
