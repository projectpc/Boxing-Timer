//package org.qtproject.example.notification;
//import org.qtproject.qt5.android.bindings.QtActivity
import org.qtproject.qt5.android.bindings.QtApplication;
import java.lang.String;
import android.app.Activity;
import android.os.PowerManager;
import android.content.Context;

public class WakeLock
{
    private Activity myActivity;
    protected PowerManager.WakeLock m_WakeLock = null;
public static int mod=2;

    public WakeLock(Activity a)
    {
        myActivity = a;
    }
    public static void test(int m){
     mod=m;
    }


    public int configure()
    {
        if(mod==0)
        {
        System.out.println("Inside WakeLock::configure-SCREEN_BRIGHT_WAKE_LOCK--"+mod);

         try
         {
             final PowerManager pm = (PowerManager) myActivity.getSystemService(Context.POWER_SERVICE);
              //FULL_WAKE_LOCK - полная яркость  SCREEN_DIM_WAKE_LOCK - подзатемнить  PARTIAL_WAKE_LOCK  SCREEN_BRIGHT_WAKE_LOCK
             m_WakeLock = pm.newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK , "My Tag");
         //  m_WakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "My Tag");
             // Does not work: https://stackoverflow.com/questions/5183859/partial-wake-lock-vs-screen-dim-wake-lock-in-download-thread
             m_WakeLock.acquire();

             return 42;
         }
         catch (Exception e)
         {
             System.out.println("WakeLock failed: " + e.toString());
             System.out.println("-----------------------------------------");
         }

         return -1;
         }


    else {
     System.out.println("Inside WakeLock::configure-PARTIAL_WAKE_LOCK--"+mod);

      try
      {
          final PowerManager pm = (PowerManager) myActivity.getSystemService(Context.POWER_SERVICE);
           //FULL_WAKE_LOCK - полная яркость  SCREEN_DIM_WAKE_LOCK - подзатемнить  PARTIAL_WAKE_LOCK
          m_WakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK , "My Tag");
      //  m_WakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "My Tag");
          // Does not work: https://stackoverflow.com/questions/5183859/partial-wake-lock-vs-screen-dim-wake-lock-in-download-thread
          m_WakeLock.acquire();

          return 42;
      }
      catch (Exception e)
      {
          System.out.println("-----------------------------------------");
          System.out.println("WakeLock failed: " + e.toString());
      }

      return -1;
      }
   }

}
