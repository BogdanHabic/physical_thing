
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

    public static void main(String[] args) throws IOException {
        HIDManager hidMgr = HIDManager.getInstance();

        try {
            while (true) {
                for (HIDDeviceInfo info : hidMgr.listDevices()) {
                    if (info.getProduct_string().compareTo("SLAVEID Library") == 0) {
                        slave = info.open();
                        break;
                    }

                    if (info.getProduct_string().compareTo("HOST ID Library") == 0) {
                        master = info.open();
                        break;
                    }
                }

                if (slave != null && master != null) {
                    break;
                }
            }

            while (true) {
                String slaveMsg = readSlave();
                if (slaveMsg != null) {
                    processSlaveMessage(slaveMsg);
                } else {
                    String masterMsg = readMaster();
                }

                Thread.sleep(20);
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

            hidMgr.release();
        }
    }

    private static void processSlaveMessage(String slaveMsg) {
        char msg = slaveMsg.charAt(0);
        sendToMaster(msg);
    }

    private static void sendToMaster(char msg) {
        String possibleMasterMsg = readMaster();
        writeToMaster(msg);
    }

    public static String readSlave() {
        String slaveMsg = readHID("slave");

        if (slaveMsg != null) {
            System.out.println("RECEIVED FROM SLAVE: " + slaveMsg);
        }

        return slaveMsg;
    }

    public static String readMaster() {
        String masterMsg = readHID("master");

        if (masterMsg != null) {
            System.out.println("RECEIVED FROM MASTER: " + masterMsg);
        }

        return masterMsg;
    }

    public static String readHID(String type) {
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
                String str = "";
                for (int i = 0; i < read; i++) {
                    if (data[i] != 0) {
                        str += data[i];
                    }
                }
                return str;
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
        data[0] = (byte) 1;
        data[1] = (byte) value;
        try {
            System.out.println("SENT TO MASTER: " + master.write(data));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}