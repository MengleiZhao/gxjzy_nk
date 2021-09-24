package com.braker.common.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.ObjectWriter;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.type.TypeReference;


/**
 * 一个方便的json工具包
 * 
 * @author cj
 *
 */
public class JSONUtils {
	
	/**
	 * 将任意一个java对象转化为json字符串
	 * <pre>
	 *     Map<String,String> user = new Map<String,String>();
	 *     user.add("name","cdj");
	 *     <b>String json = JSONUtils.toJson(user);</b>
	 * </pre>
	 * 输出：<code>{"name":"cdj"}</code>
	 * @param pojo
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	public static String toJson(Object pojo) throws JsonGenerationException, JsonMappingException, IOException{
		return toJson(pojo, false);
		
	}
	
	/**
	 * 将任意一个java对象转化为json字符串
	 * <pre>
	 *     Map<String,String> user = new Map<String,String>();
	 *     user.add("name","cdj");
	 *     <b>String json = JSONUtils.toJson(user);</b>
	 * </pre>
	 * 输出：<code>{"name":"cdj"}</code>
	 * @param pojo
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	public static String toJson(Object pojo, boolean indent) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper m = new ObjectMapper();
		if(indent){
			m.configure(SerializationConfig.Feature.INDENT_OUTPUT, true);
		}
		m.getSerializationConfig().disable(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS);
		return m.writeValueAsString(pojo);
		
	}
	
	/**
	 * 从文件中读取json数据将其转化为指定对象
	 * <pre>
	 * Map<String,User> result = JSONUtils.getObjFromFile(new File("/root/pathtofile/file") 
	 * 	   ,new TypeReference&lt;Map&lt;String,User&gt;&gt;() { });
	 * </pre>
	 * @param <T>
	 * @param src
	 * @param valueTypeRef
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getObjFromFile(File jsonFile, TypeReference<?> valueTypeRef) throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		return (T)objectMapper.readValue(jsonFile, valueTypeRef);
	}
	
	/**
	 * 将json数据转化为指定对象
	 * <pre>
	 * Map<String,User> result = JSONUtils.getObjFromFile(new File("/root/pathtofile/file") 
	 * 	   ,new TypeReference&lt;Map&lt;String,User&gt;&gt;() { });
	 * </pre>
	 * @param <T>
	 * @param src
	 * @param valueTypeRef
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getObjFromFile(String json, TypeReference<?> valueTypeRef) throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		return (T)objectMapper.readValue(json, valueTypeRef);
	}
	
	/**
	 * 将对象序列化为json字符串并存储到文件中
	 * @param jsonFile json文件
	 * @param pojo 对象
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void writeObjToFile(File jsonFile,Object pojo) throws JsonGenerationException, JsonMappingException, FileNotFoundException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		ObjectWriter writer = mapper.defaultPrettyPrintingWriter();
		writer.writeValue(new FileOutputStream(jsonFile), pojo);
	}
	
	/**
	 * 将一个json字符串转化为指定对象,注意json字符串不支持单引号，请使用\"
	 * <pre>
	 *     Map<String,User> result = JSONUtils.getObjFromString("{\"meng\" : { \"name\" : \"lan\"},}"
	 *         , new TypeReference&lt;Map&lt;String,User&gt;&gt;() { });
	 * </pre>
	 * @param <T>
	 * @param json
	 * @param valueTypeRef
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getObjFromString(String json, TypeReference<?> valueTypeRef) throws JsonParseException, JsonMappingException, IOException{
		return (T)new ObjectMapper().readValue(json, valueTypeRef);
	}
	
	
	/** 
     * 将json转换为bean 
     * @param json 
     * @param type 
     * @return 
     */  
    public static <T> Object json2bean(String json, Class<T> type) {  
        JSONObject jsonObject = JSONObject.fromObject(json);  //转换成json对象
        return JSONObject.toBean(jsonObject, type);  
    }
	
    /** 
     * 将bean转换为json 
     * @param object 
     * @return 
     */  
    public static JSONObject bean2json(Object object) {
    	JSONObject jsonObject = JSONObject.fromObject(object);
    	return jsonObject;
    }
    /** 
     * 将json格式转换成list对象 
     * @param <T>
     * @param jsonStr 
     * @return 
     */  
    public static <T> List<?> jsonToList(String jsonStr, Class<T> type){  
    	JSONArray  array = JSONArray.fromObject(jsonStr);  //转换成json对象
    	List<?> list = JSONArray.toList(array, type);// 过时方法 
    	//List<?> list = JSONArray.toList(array, type, new JsonConfig());//参数1为要转换的JSONArray数据，参数2为要转换的目标数据，即List盛装的数据
        return list;  
    }
	public static void main(String[] args){
		try {
			Map<String,String> map = JSONUtils.getObjFromString("{\"meng\" : \"cdjjjjjjj\"}", new TypeReference<Map<String,String>>() { });
			System.out.println(map.get("meng"));
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
