package com.braker.common.jdbc;

import java.io.IOException;
import java.math.BigInteger;
import java.util.Enumeration;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class ConvertPwdPropertyConfigurer extends PropertyPlaceholderConfigurer {

	@Override
    protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props) throws BeansException {
        
        Enumeration<?> keys = props.propertyNames();
        while (keys.hasMoreElements()) {
            String key = (String)keys.nextElement();
            String value = props.getProperty(key);
            if ("jdbc.password".equals(key)) {
            	//Base64解密
            	try {
            		BASE64Decoder decoder = new BASE64Decoder();
					byte valueArray [] = decoder.decodeBuffer(value);
					value = new String(valueArray);
					props.setProperty("jdbc.password", value);
				} catch (Exception e) {
					e.printStackTrace();
				}
            }
            //System.out.println(key+"-----"+value);
            //System.setProperty(key, value);
        }
        super.processProperties(beanFactoryToProcess, props);
    }
	

	
	
	public static void main(String[] args) {
		BASE64Encoder encoder = new BASE64Encoder();// 加密
		 System.out.println(encoder.encode("tzzj@001".getBytes()));
	}
}
