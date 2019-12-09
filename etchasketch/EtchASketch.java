/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package etchasketch;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;
import java.io.InputStream;
import java.io.OutputStream;

/**
 *
 * @author Dave
 */
public class EtchASketch {
    
    static InputStream input;
    static OutputStream output;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception {
        
        // System.out.println(args[0]);

        CommPortIdentifier portId = CommPortIdentifier.getPortIdentifier("COM6");


        SerialPort port = (SerialPort)portId.open("serial talk", 4000);
        input = port.getInputStream();
        output = port.getOutputStream();
        port.setSerialPortParams(115200,
        SerialPort.DATABITS_8,
        SerialPort.STOPBITS_1,
        SerialPort.PARITY_NONE);

       
        Thread.sleep(3000);
        
        output.write('a');
        System.out.println("Starting...");
        while(true){
            if(input.read()=='b')
                System.out.println("Handshake!");
                break;
        }

        
        try{
  // Open the file that is the first 
  // command line parameter
  FileInputStream fstream = new FileInputStream("Program.txt");
  // Get the object of DataInputStream
  DataInputStream in = new DataInputStream(fstream);
  BufferedReader br = new BufferedReader(new InputStreamReader(in));
  String strLine;
  //Read File Line By Line
  while ((strLine = br.readLine()) != null)   {
  // Print the content on the console
  while(true){
      if(input.read()=='N'){
  System.out.println (strLine);
  output.write(strLine.getBytes());
      break;
      }
  }
  }
  
  //Close the input stream
  in.close();
    }catch (Exception e){//Catch exception if any
  System.err.println("Error: " + e.getMessage());
  }
        System.exit(0);
  }
}
