class Button
{
  // Attributs
  String label;
  float x;    // Position du coin gauche en x
  float y;    // Position du coin gauche en y
  float w;    // Largeur du bouton
  float h;    // Hauteur du bouton
  
  // Constructeur
  public Button(String labelB, float xpos, float ypos, float widthB, float heightB)
  {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  // Fonction qui affiche le bouton
  public void show()
  {
    fill(255);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  // Fonction qui détermine si la souris est sur le bouton
  // Pas utilisé présentement, mais pourrait l'être pour une version future plus avancée
  public boolean mouseIsOver()
  {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h))
    {
      return true;
    }
    return false;
  }
  
  // Fonction qui change le label
  public void changeLabel(String newLabel)
  {
    label = newLabel;
  }
}
