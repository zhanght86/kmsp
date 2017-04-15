package com.yonyou.kms.modules.cms.utils;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import com.yonyou.kms.modules.sys.utils.FileStorageUtils;
public class ConvertVideo {
    
    private static String inputPath = "";
    
    private static String outputPath = "";
    
    private static String ffmpegPath = "";
    
    
   public  ConvertVideo(String inputFilePath,String outputFilePath){
	   inputPath = inputFilePath;
	   outputPath = outputFilePath;
	   //配置文件配置ffmpeg放置路径，eg:ffmpegPath = c:\\ffmpeg\\
	   ffmpegPath  = FileStorageUtils.ffmpegPath;
   }
   
    public static boolean process() {
        int type = checkContentType();
        boolean status = false;
        if (type == 0) {
        	System.out.println("直接转成flv格式");
            status = processFLV(inputPath);// 直接转成flv格式
        } else if (type == 1) {
        	 String avifilepath = processAVI(type);
             if (avifilepath == null)
                 return false;// 没有得到avi格式
             status = processFLV(avifilepath);// 将avi转成flv格式
         }
         return status;
    }

    private static int checkContentType() {
        String type = inputPath.substring(inputPath.lastIndexOf(".") + 1, inputPath.length())
                .toLowerCase();
     // ffmpeg能解析的格式：（asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv等
        if (type.equals("avi")) {
            return 0;
        } else if (type.equals("mpg")) {
            return 0;
        } else if (type.equals("wmv")) {
            return 0;
        } else if (type.equals("3gp")) {
            return 0;
        } else if (type.equals("mov")) {
            return 0;
        } else if (type.equals("mp4")) {
            return 0;
        } else if (type.equals("asf")) {
            return 0;
        } else if (type.equals("asx")) {
            return 0;
        } else if (type.equals("flv")) {
            return 0;
        }
        // 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等),
        // 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
        else if (type.equals("wmv9")) {
            return 1;
        } else if (type.equals("rm")) {
            return 1;
        } else if (type.equals("rmvb")) {
            return 1;
        }
        return 9;
    }

    private static boolean checkfile(String path) {
        File file = new File(path);
        if (!file.isFile()) {
            return false;
        }
        return true;
    }

    // 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等), 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
    private static String processAVI(int type) {
        List<String> commend = new ArrayList<String>();
        commend.add(ffmpegPath + "mencoder");
        commend.add(inputPath);
        commend.add("-oac");
        commend.add("lavc");
        commend.add("-lavcopts");
        commend.add("acodec=mp3:abitrate=64");
        commend.add("-ovc");
        commend.add("xvid");
        commend.add("-xvidencopts");
        commend.add("bitrate=600");
        commend.add("-of");
        commend.add("avi");
        commend.add("-o");
        commend.add(outputPath + "a.avi");
        try {
            ProcessBuilder builder = new ProcessBuilder();
            Process process = builder.command(commend).redirectErrorStream(true).start();
            new PrintStream(process.getInputStream());
            new PrintStream(process.getErrorStream());
            process.waitFor();
            return outputPath + "a.avi";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

 // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
    private static boolean processFLV(String oldfilepath) {

        if (!checkfile(inputPath)) {
            System.out.println(oldfilepath + " is not file");
            return false;
        }
        
        List<String> command = new ArrayList<String>();
        command.add(ffmpegPath + "ffmpeg");
        command.add("-i");
        command.add(oldfilepath);
        command.add("-ab");
        command.add("56");
        command.add("-ar");
        command.add("22050");
        command.add("-qscale");
        command.add("8");
        command.add("-r");
        command.add("15");
      //command.add("-c");
      //command.add("libx264");
      //command.add("-strict");
      //command.add("-2");
      //command.add("-s");
      //command.add("600x500");
        command.add(outputPath);
        try {
            
            // 方案1
//            Process videoProcess = Runtime.getRuntime().exec(ffmpegPath + "ffmpeg -i " + oldfilepath 
//                    + " -ab 56 -ar 22050 -qscale 8 -r 15 -s 600x500 "
//                    + outputPath + "a.flv");
            
            // 方案2
            Process videoProcess = new ProcessBuilder(command).redirectErrorStream(true).start();
            
            new PrintStream(videoProcess.getErrorStream()).start();
            
            new PrintStream(videoProcess.getInputStream()).start();
            
            videoProcess.waitFor();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /*
    //test方法
    public static void main(String args[]) throws IOException {    
        getPath();
        if (!checkfile(inputPath)) {
            System.out.println(inputPath + " is not file");
            return;
        }
        if (process()) {
            System.out.println("ok");
        }
    }
     private static void getPath() { 
         File diretory = new File("");
         try {
             //String currPath = diretory.getAbsolutePath();
             inputPath 	= "c:\\ffmpeg\\input\\avi.avi";
             outputPath  = "c:\\ffmpeg\\output\\";
             ffmpegPath  = "c:\\ffmpeg\\";
         }
         catch (Exception e) {
             System.out.println("getPath���");
         }
     }
     */
}

class PrintStream extends Thread {
    java.io.InputStream __is = null;
    public PrintStream(java.io.InputStream is) {
        __is = is;
    } 
    
    public void run() {
        try {
            while(this != null) {
                int _ch = __is.read();
                if(_ch != -1) 
                    System.out.print((char)_ch); 
                else break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
}