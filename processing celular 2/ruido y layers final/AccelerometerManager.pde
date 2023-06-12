import processing.core.PApplet;

import java.lang.reflect.*;
import java.util.List;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

public class AccelerometerManager {

  private Sensor sensor;
  private SensorManager sensorManager;
  Method accelerationEventMethod;

  /** indicates whether or not Accelerometer Sensor is supported */
  private Boolean supported;
  /** indicates whether or not Accelerometer Sensor is running */
  private boolean running = false;
  PApplet parent;
  Context context;

  public AccelerometerManager(PApplet parent) {
    this.parent = parent;
    this.context = parent.getContext();

    try {
      accelerationEventMethod =
        parent.getClass().getMethod("accelerationEvent", new Class[] { Float.TYPE, Float.TYPE, Float.TYPE });
    } 
    catch (Exception e) {
      // no such method, or an error.. which is fine, just ignore
    }
    resume();
  }

  public void resume() {
    if (isSupported()) {
      startListening();
    }
  }

  public void pause() {
    if (isListening()) {
      stopListening();
    }
  }

  /*
   Returns true if the manager is listening to orientation changes
   */
  public boolean isListening() {
    return running;
  }

  /*
   Unregisters listeners
   */
  public void stopListening() {
    running = false;
    try {
      if (sensorManager != null && sensorEventListener != null) {
        sensorManager.unregisterListener(sensorEventListener);
      }
    }
    catch (Exception e) {
    }
  }

  /*
   Returns true if at least one Accelerometer sensor is available
   */
  public boolean isSupported() {
    if (supported == null) {
      sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
      List<Sensor> sensors = sensorManager.getSensorList(Sensor.TYPE_GRAVITY);
      supported = new Boolean(sensors.size() > 0);
    }
    return supported;
  }

  /*
   Registers a listener and start listening
   */
  public void startListening() {
    sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
    List<Sensor> sensors = sensorManager.getSensorList(Sensor.TYPE_GRAVITY);
    if (sensors.size() > 0) {
      sensor = sensors.get(0);
      running = sensorManager.registerListener(sensorEventListener, sensor, SensorManager.SENSOR_DELAY_UI);
    }
  }


  /*
   The listener that listen to events from the accelerometer listener
   */
  public SensorEventListener sensorEventListener = new SensorEventListener() {
    private float x = 0;
    private float y = 0;
    private float z = 0;
    
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
    }

    public void onSensorChanged(SensorEvent event) {

      x = event.values[0];
      y = event.values[1];
      z = event.values[2];
      
      // trigger change event
      
      if (accelerationEventMethod != null) {
        try {
          accelerationEventMethod.invoke(parent, new Object[] { x, y, z });
        } 
        catch (Exception e) {
          e.printStackTrace();
          accelerationEventMethod = null;
        }    
      
      }
    }
  };
}

