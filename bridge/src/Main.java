
import com.codeminders.hidapi.ClassPathLibraryLoader;
import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDDeviceInfo;
import com.codeminders.hidapi.HIDManager;

import java.io.IOException;

public class Main {
    public static HIDDevice slave = null;
    public static HIDDevice master = null;
    static final char start_msg = 'S';
    static final char reset_msg = 'R';
    static final char pause_msg = 'P';

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
                	System.out.println(info.getProduct_string());
                    if (info.getProduct_string().compareTo("SLAVEID Library") == 0) {
                        slave = info.open();
                    }

                    if (info.getProduct_string().compareTo("HOST ID Library") == 0) {
                        master = info.open();
                    }
                }
                
                if (slave != null && master != null) {
                    break;
                }
            }
            
            System.out.println("Start");

            while (true) {
                byte[] slaveMsg = readSlave();

                if (slaveMsg != null) {
                    processSlaveMessage(slaveMsg);
                } else {
                    byte[] masterMsg = readMaster();
                    if(masterMsg != null) {
//                    	System.out.println("Master message " + masterMsg);
                    	sendToSlave(masterMsg);
                    }
                }

                Thread.sleep(100);
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        } finally {
            if (slave != null) {
                slave.close();
            }
            if (master != null) {
                master.close();
            }

            if(hidMgr != null) {
            	hidMgr.release();
            }
        }
    }

    private static void processSlaveMessage(byte[] slaveMsg) {
        sendToMaster((char)slaveMsg[0]);
    }

    private static void sendToMaster(char msg) {
        byte[] possibleMasterMsg = readMaster();
        writeToMaster(msg);
    }
    
    private static void sendToSlave(byte[] msg) {
    	byte[] data = new byte[64];
        data[0] = (byte) 0;
        data[1] = msg[0];
        data[2] = msg[1];
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
//            System.out.println("RECEIVED FROM SLAVE: " + (char)slaveMsg[0]);
        }

        return slaveMsg;
    }

    public static byte[] readMaster() {
        byte[] masterMsg = readHID("master");

        if (masterMsg != null) {
//            System.out.println("RECEIVED FROM MASTER: " + masterMsg);
        }

        return masterMsg;
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
                case "master":
                    master.disableBlocking();
                    read = master.read(data);
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

    public static void writeToMaster(char value) {
        byte[] data = new byte[64];
        data[0] = (byte) 0;
        data[1] = (byte) value;
        try {
        	master.write(data);
//            System.out.println("SENT TO MASTER: " +);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}