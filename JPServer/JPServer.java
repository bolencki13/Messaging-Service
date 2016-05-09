/*
 * https://systembash.com/a-simple-java-udp-server-and-udp-client/
 */

import java.io.*;
import java.net.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.*;
import java.math.*;

public class JPServer {
    boolean ranOnce = false;
    
    public static void main(String args[]) {
        new JPServer().run();
    }
    
    public void run() {
        int myPort = 8080;
        String ipAddress = "Unknown";
        try {
            ipAddress = ((InetAddress)InetAddress.getLocalHost()).toString();
        } catch (UnknownHostException uhe) {
            uhe.printStackTrace();
        }
        System.out.println("IPAddress: "+ipAddress.substring(ipAddress.lastIndexOf("/")+1)+"\nPort: "+myPort);
        
        try {
            ArrayList<Connection> list = new ArrayList<Connection>();
            
            DatagramSocket serverSocket = new DatagramSocket(myPort);
            while(true) {
                byte[] receiveData = new byte[1024];
                byte[] sendData = new byte[1024];
                DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
                serverSocket.receive(receivePacket);
                
                InetAddress clientIP = receivePacket.getAddress();
                int clientPort = receivePacket.getPort();
                boolean containsObject = false;
                for (int x = 0; x < list.size(); x++) {
                    String ip = ((Connection)list.get(x)).ipAddress.getHostAddress();
                    if (ip.equals(clientIP.getHostAddress())) {
                        containsObject = true;
                    }
                }
                if (containsObject == false) {
                    Connection cnt = new Connection(clientIP,clientPort);
                    list.add(cnt);
                }
                
                String inputString = new String(receivePacket.getData());
                System.out.println("RECEIVED: " + inputString);
                
                sendData = inputString.getBytes();
                
                for (int x = 0; x < list.size(); x++) {
                    InetAddress ip = ((Connection)list.get(x)).ipAddress;
                    int port = ((Connection)list.get(x)).port;
                    
                    if (ip.getHostAddress().equals(clientIP.getHostAddress()) == false || ranOnce == false) {
                        ranOnce = true;
                        
                        DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, ip, port);
                        serverSocket.send(sendPacket);
                        System.out.println("SENT: " + inputString);
                    }
                }
            }
        } catch (SocketException se) {
            se.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }
}

class Connection {
    public InetAddress ipAddress;
    public int port;
    
    public Connection(InetAddress ipAddress, int port) {
        this.ipAddress = ipAddress;
        this.port = port;
    }
    
}