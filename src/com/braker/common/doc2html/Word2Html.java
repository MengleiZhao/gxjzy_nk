package com.braker.common.doc2html;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.core.FileURIResolver;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;

public class Word2Html {

	
	
	/**
	 * 文件预览方法
	 * @param fileName 要转换word文件的路径
	 * @param outPutFile 转换成html文件放在哪个路径下
	 * @param imgFilePath 图片文件的存放路径
	 * @throws Exception
	 */
	public void wordToHtml(String fileName,String outPutFile,String imgFilePath) throws Exception{
		if (fileName.endsWith(".docx") || fileName.endsWith(".DOCX")){
			canExtractImage(fileName, outPutFile, imgFilePath);
		}else if(fileName.endsWith(".doc") || fileName.endsWith(".DOC")){
			convert2Html(fileName, outPutFile, imgFilePath);
		}
		
	}
	
	/**
	 * word07版本(.docx)转html
	 * poi:word07在线预览
	 * @param fileName 要转换word文件的路径
	 * @param outPutFile 转换成html文件放在哪个路径下
	 * @param imgFilePath 图片文件的存放路径
	 * @throws IOException
	 * @author 陈睿超
	 * @createtime 2018-07-31
	 */
	public static void canExtractImage(String fileName,String outPutFile,String imgFilePath) throws IOException {
		File f = new File(fileName);
		if (!f.exists()) {
			System.out.println("Sorry File does not Exists!");
		} else {
			if (fileName.endsWith(".docx") || fileName.endsWith(".DOCX")) {
				InputStream in =null;
				OutputStream out =null;
				try {
					// 1) Load DOCX into XWPFDocument
					in = new FileInputStream(f);
					XWPFDocument document = new XWPFDocument(in);

					// 2) Prepare XHTML options (here we set the IURIResolver to
					// load images from a "word/media" folder)
					File imageFolderFile = new File(imgFilePath);
					XHTMLOptions options = XHTMLOptions.create().URIResolver(
							new FileURIResolver(imageFolderFile));
					options.setExtractor(new FileImageExtractor(imageFolderFile));

					// 3) Convert XWPFDocument to XHTML
					out = new FileOutputStream(new File(outPutFile));
					XHTMLConverter.getInstance().convert(document, out, options);
				} catch (Exception e) {
					e.printStackTrace();
					// TODO: handle exception
				}finally{
					if(in !=null){
						in.close();
					}
					if(out !=null){
						out.close();
					}
				}
				
			} else {
				System.out.println("Enter only MS Office 2007+ files");
			}
		}
	}
	
	
	/**
	 * word03版本(.doc)转html
	 * poi:word03在线预览
	 * @param fileName 要转换word文件的路径
	 * @param outPutFile 转换成html文件放在哪个路径下
	 * @param imgFilePath 图片文件的存放路径
	 * @throws TransformerException
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @author 陈睿超
	 * @createtime 2018-07-31
	 */
	public static void convert2Html(String fileName, String outPutFile,String imgFilePath)
			throws TransformerException, IOException,
			ParserConfigurationException {
		ByteArrayOutputStream out =null;
		FileInputStream fis=null;
		FileOutputStream fos=null;
		try {
			fis=new FileInputStream(fileName);
			HWPFDocument wordDocument = new HWPFDocument(fis);//WordToHtmlUtils.loadDoc(new FileInputStream(inputFile));
			WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(
					DocumentBuilderFactory.newInstance().newDocumentBuilder()
							.newDocument());
			 wordToHtmlConverter.setPicturesManager( new PicturesManager()
	         {
	             public String savePicture( byte[] content,
	                     PictureType pictureType, String suggestedName,
	                     float widthInches, float heightInches )
	             {
	                 return "images/"+suggestedName;
	             }
	         } );
			wordToHtmlConverter.processDocument(wordDocument);
			//save pictures
			List pics=wordDocument.getPicturesTable().getAllPictures();
			if(pics!=null){
				for(int i=0;i<pics.size();i++){
					Picture pic = (Picture)pics.get(i);
					System.out.println();
					try {
						fos=new FileOutputStream(imgFilePath+ pic.suggestFullFileName());
						pic.writeImageContent(fos);
					} catch (FileNotFoundException e) {
						e.printStackTrace();
					}  
				}
			}
		
			
			Document htmlDocument = wordToHtmlConverter.getDocument();
			out = new ByteArrayOutputStream();
			DOMSource domSource = new DOMSource(htmlDocument);
			StreamResult streamResult = new StreamResult(out);
	
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer serializer = tf.newTransformer();
			serializer.setOutputProperty(OutputKeys.ENCODING, "gbk");
			serializer.setOutputProperty(OutputKeys.INDENT, "yes");
			serializer.setOutputProperty(OutputKeys.METHOD, "html");
			serializer.transform(domSource, streamResult);
			writeFile(new String(out.toByteArray()), outPutFile);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
			if(out!=null){
				out.close();
			}
			if(fos!=null){
				fos.close();
			}
			if(fis!=null){
				fis.close();
			}
		}
	}

	public static void writeFile(String content, String path) {
		FileOutputStream fos = null;
		BufferedWriter bw = null;
		try {
			File file = new File(path);
			fos = new FileOutputStream(file);
			bw = new BufferedWriter(new OutputStreamWriter(fos,"gbk"));
			bw.write(content);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			try {
				if (bw != null)
					bw.close();
				if (fos != null)
					fos.close();
			} catch (IOException ie) {
			}
		}
	}
}
