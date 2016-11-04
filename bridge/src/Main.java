
import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDDeviceInfo;
import com.codeminders.hidapi.HIDManager;

import java.io.IOException;

public class Main {

    //ucitavanje nativne HID biblioteke

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
        //slave ce predstavljati uredjaj sa kojim komuniciramo
        HIDDevice slave = null;

        HIDManager hidMgr;
        try {
            hidMgr = HIDManager.getInstance();

            //dohvatamo listu svih HID USB uredjaja

            boolean nasao = false;
            while (true) {
                HIDDeviceInfo[] infos = hidMgr.listDevices();

                for (HIDDeviceInfo info : infos) {
                    //pronadjemo USB vezu sa mikrokontrolerom
                    if (info.getProduct_string().compareTo("USB HID Library") == 0) {
                        nasao = true;
                        slave = info.open();
                        break;

                    }
                    //System.out.println(info.getProduct_string());
                }
                if (nasao) break;

            }

            System.out.println("nasao");


            try {
                //bafer za citanje
                byte[] readBuf = new byte[BUF_SIZE];
                //IO je blokirajuci, a ne asinhron
                //asinhron IO bi podrazumevao prekide
                slave.enableBlocking();

                //bafer za pisanje
                byte[] writeBuf = new byte[BUF_SIZE];
                //kada pisemo, prvi bajt naznacava
                //'report', koji odredjuje format USB komunikacije
                //kod nas postoji samo jedan report, sa rednim brojem 0
                //tako da ce nam prvi bajt uvek biti 0
                writeBuf[0] = 0;
                writeBuf[1] = 'A';
                writeBuf[2] = 'S';
                writeBuf[3] = 'D';

                slave.write(writeBuf);
                slave.read(readBuf);
                String bufString = new String(readBuf);
                System.out.println(bufString);

                try {
                    Thread.sleep(20);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {

                slave.close();
                hidMgr.release();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}