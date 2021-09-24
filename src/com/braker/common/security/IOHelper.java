package com.braker.common.security;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Timer;
import java.util.TimerTask;
import java.util.zip.DeflaterOutputStream;
import java.util.zip.InflaterInputStream;

import com.braker.common.util.StringUtil;

/**
 * <code>IOHelper</code>
 */

public final class IOHelper
{
	private static final int BUFFERSIZE = 1024 * 8;

	private static final Timer TIMER = new Timer(true);

	private static final char[] BASE64_CHARS = {
			'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
			'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
			'0','1','2','3','4','5','6','7','8','9','+','/'
		};

	private static final char BASE64_PAD = '=';

	private static final String BASE64_CRLF = "\r\n";

	private static final int MASK6 = 0x3f,MASK8 = 0xff;
	/**
	 * 监控文件状态
	 * @param file
	 * @param listener
	 * @param interval
	 */
	public static void monitor(final File file,final FileListener listener,long interval)
	{
		if( file == null )
			throw new NullPointerException("file is null.");
		if( listener == null )
			throw new NullPointerException("listener is null.");
		TIMER.schedule(new TimerTask(){
			private long mLastModified = file.exists() ? file.lastModified() : -1;
			public void run()
			{
				long lastModified = file.exists() ? file.lastModified() : -1;
				if( lastModified != mLastModified )
				{
					mLastModified = lastModified;
					listener.fileChanged(file);
				}
			}
		},0,interval);
	}
	/**
	 * 读文件
	 * @param is
	 * @param result
	 * @return
	 * @throws IOException
	 */
	public static long read(InputStream is,byte[] result) throws IOException
	{
		return read(is,result,0,result.length);
	}
	/**
	 * 读文件
	 * @param is
	 * @param result
	 * @param length
	 * @return
	 * @throws IOException
	 */
	public static long read(InputStream is,byte[] result,int length) throws IOException
	{
		return read(is,result,0,length);
	}
	/**
	 * 读文件
	 * @param is
	 * @param result
	 * @param offset
	 * @param length
	 * @return
	 * @throws IOException
	 */
	public static long read(InputStream is,byte[] result,int offset,int length) throws IOException
	{
		int read,total = 0;
		do
		{
			if( ( read = is.read(result,offset+total,length-total) ) <= 0 )
				break;
			total += read;
		}
		while( total < length );
		return total;
	}
	/**
	 * 读文件
	 * @param reader
	 * @return
	 * @throws IOException
	 */
	public static String read(Reader reader) throws IOException
	{
		StringWriter writer = new StringWriter();
		write(reader,writer);
		writer.close();
		return writer.getBuffer().toString();
	}
	/**
	 * 向目标输出字符流中写入内容
	 * @param os
	 * @param content
	 * @throws IOException
	 */
	public static void write(OutputStream os,String content) throws IOException
	{
		write(os,content.getBytes());
	}
	/**
	 * 向目标输出字符流中写入内容,指定Charset
	 * @param os
	 * @param content
	 * @param charset
	 * @throws IOException
	 */
	public static void write(OutputStream os,String content,String charset) throws IOException
	{
		write(os,content.getBytes(charset));
	}
	/**
	 * 向目标输出字符流中写入内容
	 * @param os
	 * @param bytes
	 * @throws IOException
	 */
	public static void write(OutputStream os,byte[] bytes) throws IOException
	{
		write(os,bytes,0,bytes.length);
	}
	/**
	 * 向目标输出字符流中写入内容
	 * @param os
	 * @param bytes
	 * @param offset
	 * @param length
	 * @throws IOException
	 */
	public static void write(OutputStream os,byte[] bytes,int offset,int length) throws IOException
	{
		os.write(bytes,offset,length);
	}
	/**
	 * 将输入字符流中的内容写入输出字符流中
	 * @param is
	 * @param os
	 * @return
	 * @throws IOException
	 */
	public static int write(InputStream is,OutputStream os) throws IOException
	{
		return write(is,os,BUFFERSIZE);
	}
	/**
	 * 将输入字符流中的内容写入输出流字符中,指定缓存大小
	 * @param is
	 * @param os
	 * @param bufferSize
	 * @return
	 * @throws IOException
	 */
	public static int write(InputStream is,OutputStream os,int bufferSize) throws IOException
	{
		int read,total = 0;
		byte[] buff = new byte[bufferSize];
		while( is.available() > 0 )
		{
			read = is.read(buff,0,buff.length);
			if( read > 0 )
			{
				os.write(buff,0,read);
				total += read;
			}
		}
		return total;
	}
	/**
	 * 将内容写入输出字节流
	 * @param content
	 * @param writer
	 * @throws IOException
	 */
	public static void write(String content,Writer writer) throws IOException
	{
		Reader reader = new StringReader(content);
		write(reader,writer);
		reader.close();
	}
	/**
	 * 将输入字节流中的内容写入输出字节流
	 * @param reader
	 * @param writer
	 * @throws IOException
	 */
	public static void write(Reader reader,Writer writer) throws IOException
	{
		int read;
		char[] buf = new char[BUFFERSIZE];
		while( ( read = reader.read(buf) ) != -1 )
			writer.write(buf,0,read);
	}
	/**
	 * ZIP 压缩
	 * @param bytes
	 * @return
	 * @throws IOException
	 */
	public static byte[] zip(byte[] bytes) throws IOException
	{
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		DeflaterOutputStream zos = new DeflaterOutputStream(bos);
		try
		{
			zos.write(bytes);		
		}
		finally
		{
			zos.close();
			bos.close();
		}
		return bos.toByteArray();
	}
	/**
	 * ZIP 解压
	 * @param bytes
	 * @return
	 * @throws IOException
	 */
	public static byte[] unzip(byte[] bytes) throws IOException
	{
		ByteArrayInputStream bis = new ByteArrayInputStream(bytes);
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		InflaterInputStream zis = new InflaterInputStream(bis);
		try
		{
			write(zis,bos);
		}
		finally
		{
			zis.close();
			bis.close();
			bos.close();
		}
		return bos.toByteArray();
	}
	/**
	 * 异或
	 * @param source
	 * @param key
	 * @return
	 */
	public static byte[] xor(byte[] source,String key)
	{
		return xor(source,getMD5(key));
	}
	/**
	 * 异或
	 * @param source
	 * @param key
	 * @return
	 */
	public static byte[] xor(byte[] source,byte[] key)
	{
		return xor(source,0,source.length,key);
	}
	/**
	 * 异或
	 * @param source
	 * @param offset
	 * @param length
	 * @param key
	 * @return
	 */
	public static byte[] xor(byte[] source,int offset,int length,byte[] key)
	{
		if( source == null )
			throw new NullPointerException();
		if( ( offset | length | ( offset + length ) | ( source.length - ( offset + length ) ) ) < 0 )
			throw new IndexOutOfBoundsException();
		if( key == null || key.length == 0 )
			throw new IllegalArgumentException("key is null or empty");
		if( length == 0 )
			return new byte[0];
		byte[] result = new byte[length];
		for(int i=0;i<length;i++)
			result[i] = (byte)(source[offset+i] ^ key[i%key.length]);
		return result;
	}
	/**
	 * 异或
	 * @param source
	 * @param offset
	 * @param length
	 * @param key
	 * @param result
	 * @param resultOffset
	 */
	public static void xor(byte[] source,int offset,int length,byte[] key,byte[] result,int resultOffset)
	{
		byte[] tmp = xor(source,offset,length,key);
		System.arraycopy(tmp,0,result,resultOffset,length);
	}
	/**
	 * MD5 String
	 * @param str
	 * @return
	 */
	public static byte[] getMD5(String str)
	{
		return getMD5(str.getBytes());
	}
	/**
	 * MD5 byte[]
	 * @param source
	 * @return
	 */
	public static byte[] getMD5(byte[] source)
	{
		MessageDigest md = newMessageDigest();
		return md.digest(source);
	}
	/**
	 * MD5 File
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public static byte[] getMD5(File file) throws IOException
	{
		InputStream is = new FileInputStream(file);
		try{ return getMD5(is); }
		finally{ is.close(); }
	}
	/**
	 * MD5 InputStream
	 * @param is
	 * @return
	 * @throws IOException
	 */
	private static byte[] getMD5(InputStream is) throws IOException
	{
		return getMD5(is,1024*8);
	}
	/**
	 * MD5 InputStream 指定缓存大小
	 * @param is
	 * @param buffer
	 * @return
	 * @throws IOException
	 */
	private static byte[] getMD5(InputStream is,int buffer) throws IOException
	{
		MessageDigest md = newMessageDigest();
		byte[] buf = new byte[buffer];
		while( is.available() > 0 )
		{
			IOHelper.read(is,buf);
			md.update(buf);
		}
		return md.digest();
	}
	public static String toHex(byte[] bytes)
	{
		String tmp;
		StringBuffer sb = new StringBuffer();
		for(int i=bytes.length;i>0;i--)
		{
			tmp = Integer.toHexString(bytes[i-1] & 0xff);
			if( tmp.length() == 1 )
				sb.append("0");
			sb.append(tmp);
		}
		return sb.toString();
	}

	public static byte[] fromHex(String hex)
	{
		if( hex == null )
			throw new NullPointerException();
		if( hex.length() == 0 )
			return new byte[0];
		String str = hex.toLowerCase();
		if( str.length() % 2 == 1 )
			str = "0" + str;
		byte[] result = new byte[str.length()/2];
		for(int i=result.length;i>0;i--)
			result[i-1] = (byte)( ( parseChar(str.charAt(2*(i-1))) << 4 ) | parseChar(str.charAt(2*(i-1)+1)) );
		return result;
	}
	/**
	 * 转换为Base64字符串
	 * @param source
	 * @return
	 */
	public static String toBase64(byte[] source)
	{
		int buffer;
		StringBuffer output = new StringBuffer();
		for(int i=0;i<source.length;i+=3)
		{
			buffer = 0;
			if( ( i % 54 ) == 0 && i != 0 )
				output.append(BASE64_CRLF);
			if( source.length <= i + 1 )
			{
				buffer = ( ( source[i] & MASK8 ) << 16 );
				output.append( BASE64_CHARS[ ( buffer >> 18 ) & MASK6 ] );
				output.append( BASE64_CHARS[ ( buffer >> 12 ) & MASK6 ] );
				output.append( BASE64_PAD );
				output.append( BASE64_PAD );
			}
			else if( source.length <= i + 2 )
			{
				buffer = ( ( source[i] & MASK8 ) << 16 ) | ( ( source[ i + 1 ] & MASK8 ) << 8 );
				output.append( BASE64_CHARS[ ( buffer >> 18 ) & MASK6 ] );
				output.append( BASE64_CHARS[ ( buffer >> 12 ) & MASK6 ] );
				output.append( BASE64_CHARS[ ( buffer >> 6 ) & MASK6 ] );
				output.append( BASE64_PAD );
			}
			else
			{
				buffer = ( ( source[i] & MASK8 ) << 16) | ( ( source[i+1] & MASK8 ) << 8 ) | ( ( source[i+2] & MASK8 ) );
				output.append( BASE64_CHARS[ ( buffer >> 18 ) & MASK6 ] );
				output.append( BASE64_CHARS[ ( buffer >> 12 ) & MASK6 ] );
				output.append( BASE64_CHARS[ ( buffer >> 6 ) & MASK6 ] );
				output.append( BASE64_CHARS[ buffer & MASK6 ] );
			}
		}
		return output.toString();
	}
	/**
	 * 将Base64字符串转为byte[]
	 * @param str
	 * @return
	 */
	public static byte[] fromBase64(String str)
	{
		byte[] source = str.getBytes();
		int data = 0,buffer = 0,read = 0;
		ByteArrayOutputStream output = null;
		try {
			output=new ByteArrayOutputStream();
			for(int i=0;i<source.length;i++)
			{
				if( read < 4 )
				{
					data = decode(source[i]);
					if( data == -1 )
						continue;
					if( data == -2 && read != 2 && read != 3 )
					{
						return null;
					}
					else if( data == -2 && read == 2 )
					{
						output.write( ( buffer >> 4 ) & MASK8 );
						return output.toByteArray();
					}
					else if(data == -2 && read == 3)
					{
						output.write( ( buffer >> 10 ) & MASK8 );
						output.write( ( buffer >> 2 ) & MASK8 );
						return output.toByteArray();
					}
					else
					{
						buffer = ( buffer << 6 ) | ( data & MASK6 );
						read++;
					}
				}
				if( read == 4 )
				{
					output.write( ( buffer >> 16 ) & MASK8 );
					output.write( ( buffer >> 8 ) & MASK8 );
					output.write( buffer & MASK8 );
					buffer = 0;
					read = 0;
				}
			}
			return output.toByteArray();
		} catch (Exception e) {
			return source;
			// TODO: handle exception
		}finally{
			if(output!=null){
				try {
					output.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	
	/**
	 * 将 String 进行 BASE64 编码
	 * @param source
	 * @return
	 */
	public static String toBase64Misc(String source){
		if (StringUtil.isEmpty(source))
			return null;
		return toBase64Misc(source.getBytes());
	}
	
	public static String toBase64Misc(byte[] source){
		return (new sun.misc.BASE64Encoder()).encode(source);
	}
	/**
	 * 将 BASE64 编码的字符串 code 进行解码
	 * @param code
	 * @return
	 */
	public static String fromBase64Misc(String code){
		if (StringUtil.isEmpty(code)){
			return null;
		}
		sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
		try 
		{
			byte[] b = decoder.decodeBuffer(code);
			return new String(b);
		}
		catch (Exception e) 
		{
			return null;
		}
	}
	public static String fromBase64Misc(byte[] code){
		return fromBase64Misc(new String(code));
	}

	private static byte parseChar(char c)
	{
		if( c < '0' || (c > '9' && c < 'a') || c > 'f' )
			throw new RuntimeException("hex format error");
		if( c > '9' )
			return (byte)( c-'a'+10 );
		else
			return (byte)( c-'0' );
	}

	private static int decode(int input)
	{
		if( input >= 'A' && input <= 'Z' )
			return input - 'A';
		if( input >= 'a' && input <= 'z' )
			return input - 'a' + 26;
		if( input >= '0' && input <= '9' )
			return input - '0' + 52;
		if( input == '+' )
			return 62;
		if( input == '/' )
			return 63;
		if( input == '=' )
			return -2;
		return -1;
	}

	private static MessageDigest newMessageDigest()
	{
		try
		{
			return MessageDigest.getInstance("MD5");
		}
		catch(NoSuchAlgorithmException e)
		{
			throw new RuntimeException(e);
		}
	}
	public static void main(String [] ages){
		System.out.println(toHex(IOHelper.getMD5("admineip")));
	}
	private IOHelper(){}
}