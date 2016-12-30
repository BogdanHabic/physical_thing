
import com.codeminders.hidapi.ClassPathLibraryLoader;
import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDDeviceInfo;
import com.codeminders.hidapi.HIDManager;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;

public class Main {
    public static HIDDevice slave = null;
    
    public static Game game = null;

    //mora da postoji hidapi-jni.dll na putanji za nativne
    //biblioteke za hidapi-1.1.jar
    //desni klik na projekat -> properties ->
    //-> java build path -> libraries -> hidapi-1.1 ->
    //-> native libraries
    //na materijalima postoje hidapi-jni-32 i hidapi-jni-64
    //iskoristiti odgovarajuci prema arhitekturi
    static {
        System.loadLibrary("hidapi-jni");
    }

    private static final int BUF_SIZE = 64;
    
    public static void debugSlave(HIDManager hidMgr) {
    	try {
            while (true) {
            	HIDDeviceInfo[] infos = hidMgr.listDevices();
            	
            	if(infos == null) {
            		continue;
            	}
            	
                for (HIDDeviceInfo info : infos) {
                    if (info.getProduct_string().compareTo("SLAVEID Library") == 0) {
                        slave = info.open();
                    }
                }
                
                if (slave != null) {
                    break;
                }
            }
            
            System.out.println("Start debug slave");

            while (true) {
                byte[] slaveMsg = readSlave();
                
                if(slaveMsg != null) {
                    System.out.println((char)slaveMsg[0]);                	
                }


                Thread.sleep(20);
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException {
    	SwingUtilities.invokeLater(new Runnable() {
			
			@Override
			public void run() {
				game = new Game();
			}
		});
    	
    	
			
    	ClassPathLibraryLoader.loadNativeHIDLibrary();
        HIDManager hidMgr = HIDManager.getInstance();

//        debugSlave(hidMgr);
        
        try {
            while (true) {
            	HIDDeviceInfo[] infos = hidMgr.listDevices();
            	
            	if(infos == null) {
            		continue;
            	}
            	
                for (HIDDeviceInfo info : infos) {
                	//System.out.println(info.getProduct_string());
                    if (info.getProduct_string().compareTo("SLAVEID Library") == 0) {
                        slave = info.open();
                    }
                }
                
                if (slave != null) {
                    break;
                }
            }
            
            System.out.println("Start");

            while (true) {
                byte[] slaveMsg = readSlave();

                if (slaveMsg != null) {
                    processSlaveMessage(slaveMsg);
                }

                Thread.sleep(100);
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        } finally {
            if (slave != null) {
                slave.close();
            }

            if(hidMgr != null) {
            	hidMgr.release();
            }
        }
    }

    private static void processSlaveMessage(byte[] slaveMsg) {
        //@TODO: Check targets here
    }
    
    public static void drawRealTarget(int x, int y) {
    	sendToSlave(x, y, 0, 0);
    }
    
    public static void drawFakeTarget(int x, int y) {
    	sendToSlave(x, y, 0, 1);
    }
    
    public static void deleteTarget(int x, int y) {
    	sendToSlave(x, y, 1, 0);
    }
    
    public static void sendToSlave(int x, int y, int del, int fake) {
    	byte[] data = new byte[64];
        data[0] = (byte) 0;
        data[1] = (byte) ((short)x);
        data[3] = (byte) ((short)y);
        data[5] = (byte) ((short)del);
        data[7] = (byte) ((short)fake);
        
        try {
        	slave.write(data);
//            System.out.println("SENT TO MASTER: " + );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static byte[] readSlave() {
        byte[] slaveMsg = readHID("slave");

        if (slaveMsg != null) {
        	String msg = new String(slaveMsg);
        	String[] parts = msg.split("=");
        	int x = Integer.parseInt(parts[0].trim());
        	int y = Integer.parseInt(parts[1].trim());

        	if(game != null) {
        		game.check(x, y);
        	}
        }

        return slaveMsg;
    }

    public static byte[] readHID(String type) {
        try {
            byte[] data = new byte[64];
            int read = 0;
            switch (type) {
                case "slave":
                    slave.disableBlocking();
                    read = slave.read(data);
                    break;
            }
            if (read > 0) {
                return data;
            } else {
                return null;
            }
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }

        return null;
    }
}