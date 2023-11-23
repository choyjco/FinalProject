package kr.or.ddit.controller.main;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {

    @Bean
    public JavaMailSender javaMailSender() {
 
    	Properties mailProperties = new Properties();
    	mailProperties.put("mail.transport.protocol", "smtp");
    	mailProperties.put("mail.smtp.auth", "true");
    	mailProperties.put("mail.smtp.starttls.enable", "true");
    	mailProperties.put("mail.smtp.debug", "true");
    	mailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
    	mailProperties.put("mail.smtp.ssl.protocols", "TLSv1.2");
    	
    	JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
    	mailSender.setJavaMailProperties(mailProperties);
    	mailSender.setHost("smtp.gmail.com");
    	mailSender.setPort(587);
    	mailSender.setUsername("teamwsi404@gmail.com");
    	mailSender.setPassword("앱 비밀번호");
    	mailSender.setDefaultEncoding("utf-8");
    	return mailSender;
    	
    }
    
    private Properties getMailProperties() {
        Properties properties = new Properties();
        properties.setProperty("mail.transport.protocol", "smtp"); // 프로토콜 설정
        properties.setProperty("mail.smtp.auth", "true"); // smtp 인증
        properties.setProperty("mail.smtp.starttls.enable", "true"); // smtp strattles 사용
        properties.setProperty("mail.debug", "true"); // 디버그 사용
        properties.setProperty("mail.smtp.ssl.trust","smtp.naver.com"); // ssl 인증 서버는 smtp.naver.com
        properties.setProperty("mail.smtp.ssl.enable","true"); // ssl 사용
        return properties;
    }
}