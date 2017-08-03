package com.cml.springboot.framework.argument;

import org.springframework.core.MethodParameter;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

public class CacheableModelMethodProcessor implements HandlerMethodArgumentResolver {

	public static final String KEY_MODEL = "com.cml.springboot.framework.argument.CacheableModelMethodProcessor.KEY_MODEL";

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return Model.class.isAssignableFrom(parameter.getParameterType());
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest,
			WebDataBinderFactory binderFactory) throws Exception {
		ModelMap map = mavContainer.getModel();
		webRequest.setAttribute(KEY_MODEL, map, NativeWebRequest.SCOPE_REQUEST);
		return map;
	}

}
