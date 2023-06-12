import ketai.camera.*;
KetaiCamera cam;
void setup()
{
  cam = new KetaiCamera(this, 320, 240, 24);
  cam.start();
}
void draw()
{
  background(0);
  if (cam !=null)
    image(cam, 0, 0);
}

void onCameraPreviewEvent()
{
  cam.read();
}

void mousePressed()
{

  if (cam.isFlashEnabled())
    cam.disableFlash();
  else
    cam.enableFlash();
}
