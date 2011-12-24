import javax.media.opengl.*;
import processing.opengl.*;
import codeanticode.glgraphics.*;

GLSLShader shader;
GLModel model;
int numPoints = 1024;
int r;
float[] coords;
float[] colors;
boolean mybool = true;

float denominator = 4000;

void setup()
{
    // DVD resolution
    size(720, 480, GLConstants.GLGRAPHICS);
    hint( DISABLE_OPENGL_2X_SMOOTH );  
    hint( ENABLE_OPENGL_4X_SMOOTH );  
    
    
    model = new GLModel(this, numPoints, GLModel.QUAD_STRIP, GLModel.DYNAMIC);
    //model.setBlendMode(SUBTRACT);    
    model.initColors();
    coords = new float[4 * numPoints];
    colors = new float[4 * numPoints];
    for (int i = 0; i < numPoints; i++)
    {
        for (int j = 0; j < 3; j++) 
          coords[4 * i + j] = height * random(-1, 1);
        coords[4 * i + 3] = 1.0; // The W coordinate of each point must be 1.
        for (int j = 0; j < 3; j++) 
          colors[4 * i + j] = random(0, 1);
        colors[4 * i + 3] = 0.9;      
    }    
     model.updateVertices(coords);  
     model.updateColors(colors);
     
     shader = new GLSLShader(this, "fishvert.glsl", "fishfrag.glsl");
}

void draw()
{
  GLGraphics renderer = (GLGraphics)g;
  renderer.beginGL();
  
  translate(width/2, height/2);

  background(160);
  if (mybool)
  {
    rotateY((float)r++/denominator);
    rotateX((float)r/denominator);
  }
  else
  {
    rotateY( (float)r/denominator - PI) ;
    rotateX( (float)r/denominator - PI) ;
  }
  shader.start(); // Enabling shader.
  
  model.render();
  
  shader.stop(); // Disabling shader.

  renderer.endGL();  
}

void keyPressed()
{
 if (key == ' ')
  saveFrame(); 
}

void mousePressed()
{
  mybool = !mybool;
}


