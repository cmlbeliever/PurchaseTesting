package com.cml.springboot.framework.argument;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

/**
 * 添加自定义argumentResolver可以覆盖系统默认处理
 * 
 * @author cml
 *
 */
@Configuration
public class CustomModelArgumentResolverConfiguration {


	@Bean
	public RequestMappingHandlerAdapter adapter(RequestMappingHandlerAdapter adapter) {
		List<HandlerMethodArgumentResolver> argumentResolvers = new ArrayList<>(adapter.getArgumentResolvers());
		argumentResolvers.add(0, new CacheableModelMethodProcessor());
		adapter.setArgumentResolvers(argumentResolvers);
		return adapter;
	}
}
