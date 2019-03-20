import peasy.*; // PeasyCam nécessaire pour vue 3D
PeasyCam camera;
Tree tree;
float minDistance = 5; // Distance mini pour l'algorithme
float maxDistance = 300; // Distance maxi pour l'algorithme
boolean isBrushing = true;
Button button;

void setup()
{
  // Définition de la taille de l'écran + appli 3D
  size(800, 1000, P3D);
  
  // Initialisation caméra
  camera = new PeasyCam(this, 900);
  camera.setActive(false);
  camera.beginHUD();
  
  // Création du premier arbre
  tree = new Tree();
  
  // Création du "bouton"
  button = new Button("Mouse click to spray points \n Press Z to construct tree in 3D", width/2 - 100, 20, 200, 40);
}

void draw()
{
  background(200, 150, 150);
  button.show();
   
  if (isBrushing)  // Phase de spray : on crée les feuilles en appuyant sur la souris
  {
    if (mousePressed)
    {
      spray();
    }
  }
  else // Phase d'observation : on peut observer l'arbre créé
  {
    tree.grow();
  }
  
  tree.show(); // Affichage de l'arbre
}

// Fonction qui gère les inputs
public void keyPressed()
{
  if (key == 'z')
  {
    isBrushing = !isBrushing;
    
    // Changement de phase en fonction
    if (isBrushing)
    {
      camera.reset();
      camera.lookAt(0, 0, 0);
      camera.setActive(false);
      camera.beginHUD();
      tree = new Tree();
      button.changeLabel("Mouse click to spray points \n Press Z to construct tree in 3D");
    }
    else
    {
      camera.setActive(true);
      camera.endHUD();
      camera.lookAt(width/2, height/2, 0);
      tree.initialize();
      button.changeLabel("Explore with the camera ! \n Press Z to create another tree");
    }
  }
}

// Fonction pour créer les feuilles de l'arbre avec un spray
private void spray()
{
  PVector randomPosition = PVector.random3D();
  randomPosition.x = mouseX + randomPosition.x * 10;
  randomPosition.y = mouseY + randomPosition.y * 10;
  randomPosition.z *= width/3;
  tree.addLeaf(randomPosition);
}
