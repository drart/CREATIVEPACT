import javax.media.opengl.*;
import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader shader;
GLModel myshape;

int r;

void setup()
{
    size(640, 480, GLConstants.GLGRAPHICS);

    shader = new GLSLShader(this, "toonvert.glsl", "Pixelate.glsl");
}

void draw()
{
    myshape = newmodel();
  GLGraphics renderer = (GLGraphics)g;
  renderer.beginGL();
  translate(width/2, height/2);
  
  background(180);

  rotateY((float)r/100);
  //shader.start(); // Enabling shader.
  //shader.setVecUniform("camera_pos", 0, 0, 0);
  
  renderer.model(myshape);
 //shader.stop(); // Disabling shader.
  renderer.endGL();  
}

void keyPressed()
{
 if (key == ' ')
  saveFrame(); 
}

void mousePressed()
{
  r++;
}

GLModel newmodel ( )
{
  ArrayList vertices = new ArrayList();
  //ArrayList normals = new ArrayList();
  for (int i = 0; i < 400; i++)
  {
    //strokeWeight(random(3));
    //line(random(width),random(height), random(width), random(height));
    vertices.add(new PVector(random(width)-width/2,random(height)-height/2, random(width)-width/2));
    //normals.add(new PVector(random(width)-width/2,random(height)-height/2, random(width)-width/2));
  }  
  GLModel model = new GLModel(this, vertices.size() , LINES, GLModel.DYNAMIC );
  model.updateVertices(vertices);  
  
  //model.initNormals();  
  //model.updateNormals(normals);  
  
  //model.initColors();
 // model.setColors(0,0,0,255);  
  
  return model;
}

