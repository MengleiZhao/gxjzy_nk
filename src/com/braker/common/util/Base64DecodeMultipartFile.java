package com.braker.common.util;

import org.springframework.web.multipart.MultipartFile;

import sun.misc.BASE64Decoder;

import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.*;

import javax.imageio.ImageIO;

/**
 * base64转为multipartFile工具类
 *
 */

public class Base64DecodeMultipartFile implements MultipartFile {

    private final byte[] imgContent;
    private final String header;

    public Base64DecodeMultipartFile(byte[] imgContent, String header) {
        this.imgContent = imgContent;
        this.header = header.split(";")[0];
    }

    @Override
    public String getName() {
        return System.currentTimeMillis() + Math.random() + "." + header.split("/")[1];
    }

    @Override
    public String getOriginalFilename() {
        return System.currentTimeMillis() + (int)Math.random() * 10000 + "." + header.split("/")[1];
    }

    @Override
    public String getContentType() {
        return header.split(":")[1];
    }

    @Override
    public boolean isEmpty() {
        return imgContent == null || imgContent.length == 0;
    }

    @Override
    public long getSize() {
        return imgContent.length;
    }

    @Override
    public byte[] getBytes() throws IOException {
        return imgContent;
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return new ByteArrayInputStream(imgContent);
    }

    @Override
    public void transferTo(File dest) throws IOException, IllegalStateException {
        new FileOutputStream(dest).write(imgContent);
    }

    /**
     * base64转multipartFile
     *
     * @param base64
     * @return
     */
    public static MultipartFile base64Convert(String base64) {

        String[] baseStrs = base64.split(",");

        BASE64Decoder decoder = new BASE64Decoder();
        byte[] b = new byte[0];
        try {
            b = decoder.decodeBuffer(baseStrs[1]);
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (int i = 0; i < b.length; ++i) {
            if (b[i] < 0) {
                b[i] += 256;
            }
        }
        return new Base64DecodeMultipartFile(b, baseStrs[0]);
    }
    
    /**生成缩略图
     * @param path
     * @author 沈帆
     * @param files 
     * @createtime 2020年10月15日
     * @updator 沈帆
     * @updatetime 2020年10月15日
     */
    public static void  getThumb(String path,String root, MultipartFile files) {
        try {
            //File fi = files.getInputStream(); //大图文件
            File fo = new File(path.replace("attachment", "thumb").replace("\\", "//")); //将要转换出的小图文件
            String copyRoot=root.replace("attachment", "thumb");
            File fileRoot=new File(copyRoot);
			if(!fileRoot.exists()){//判断是否存在这个目录,不存在创建 
				fileRoot.mkdirs();
			}
            AffineTransform transform = new AffineTransform();
            BufferedImage bis = ImageIO.read(files.getInputStream());

            int w = bis.getWidth();
            int h = bis.getHeight();
            double scale = (double)w/h;

            int nw = 120;
            int nh = (nw * h) / w;
            if(nh>120) {
                nh = 120;
                nw = (nh * w) / h;
            }

            double sx = (double)nw / w;
            double sy = (double)nh / h;

            transform.setToScale(sx,sy);

            AffineTransformOp ato = new AffineTransformOp(transform, null);
            BufferedImage bid = new BufferedImage(nw, nh, BufferedImage.TYPE_3BYTE_BGR);
            ato.filter(bis,bid);
            ImageIO.write(bid, "jpeg", fo);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}