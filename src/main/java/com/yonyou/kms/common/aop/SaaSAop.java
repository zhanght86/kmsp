package com.yonyou.kms.common.aop;

import com.yonyou.kms.modules.sys.utils.UserUtils;
import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by 何锋 on 2017/4/02.
 * 切换数据库schema
 */
@Aspect
@Component
@Order(1)
public class SaaSAop {

    private static final Logger log= LoggerFactory.getLogger(SaaSAop.class);

    @Autowired
    private DataSource dataSource;

    /**
     * 定义切点
     */
    @Pointcut("execution(* com.yonyou.kms.modules..*Service.*(..))")
    public void serviceAspect() {

    }

    @Before("serviceAspect()")
    public void doBefore(JoinPoint joinPoint) {
        Connection connection = DataSourceUtils.getConnection(dataSource);//获取当前线程的连接，此连接为自动提交模式
        doChangeSchema(connection);
    }

    private void doChangeSchema(Connection connection) {
        PreparedStatement prepareStatement=null;
        try {
            String schema=(String) UserUtils.getCache("schema");
            if(StringUtils.isNotBlank(schema)){

            }else{
                schema="Sys_Schema";
            }
            prepareStatement = connection.prepareStatement("set search_path="+schema);
            prepareStatement.executeUpdate();
            log.debug("SaaSAop change schema :"+schema);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
