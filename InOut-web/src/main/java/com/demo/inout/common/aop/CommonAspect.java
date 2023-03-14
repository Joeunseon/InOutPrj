package com.demo.inout.common.aop;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

/**
 * Aspect
 * implementation 'org.springframework.boot:spring-boot-starter-aop'
 * @AfterReturning
 * - @Aspect 클래스의 메서드 레벨에 @AfterReturning 명시하면 해당 메써드의 실행이 종료되어 값 리턴할 때 끼어 들 수 있다. 
 *   리턴 값 확인할 수 있 뿐 대상 메서드의 제어나 가공은 불가능하다.
 *
 */
@Aspect
@Component
public class CommonAspect {
    
    /** logger */
    protected final Log logger = LogFactory.getLog(getClass());
    
    /**
     * 로딩할 자바 스크립트 명을 설정
     * @param joinPoint
     * @param viewName
     */
    @AfterReturning(value = "execution(public String com.demo.inout..*Controller.*(..))", returning = "viewName") 
    public void afterRetuning(JoinPoint joinPoint, String viewName) {
        /** 파라미터 ModelMap */
        ModelMap map = null;
        
        /** 파라미터 */
        for ( Object obj : joinPoint.getArgs() )
        { 
            /** Object 분기 */
            if ( obj instanceof ModelMap )
            { 
                /** ModelMap 취득 */
                map = (ModelMap) obj;
                /** break */
                break;
            }
        }
        
        /** 파라미터 ModelMap이 없을 경우 return */ 
        if ( map == null ) return;
        
        /** js Name replace */
        String jsName = viewName.replaceAll("/?(\\w+)([\\w/]+)", "/$1/js$2.js");
        
        /** js Object Name */
        String jsObjName = "";
        
        /** / 유무 분기 */
        if ( viewName.contains("/") )
        { /** / 포함되어 있을 경우 */
            /** js Object Name = / 이후의 문자가 된다 */
            jsObjName = viewName.substring(viewName.lastIndexOf("/") + 1);
        }
        else
        { /** / 포함되어 안되어 있을 경우 */
            /** js Object Name = view Name*/
            jsObjName = viewName;
        }
        
        /** js Object Name 첫자리 대문자 */
        if ( jsObjName != null && jsObjName.length() > 0 )
            jsObjName = StringUtils.upperCase(jsObjName.substring(0, 1)) + jsObjName.substring(1);
        
        /** 설정 : js Name */
        map.put("jsName", jsName);
        /** 설정 : js Object Name */
        map.put("jsObjName", jsObjName);
        
        /** 로그 출력 */
        logger.info("jsName    "+jsName);
        logger.info("jsObjName "+jsObjName);
    }
}
