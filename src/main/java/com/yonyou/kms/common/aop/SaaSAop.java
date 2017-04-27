package com.yonyou.kms.common.aop;

import com.yonyou.kms.modules.sys.utils.UserUtils;
import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
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
        Connection connection = DataSourceUtils.getConnection(dataSource);//获取当前线程的连接
        doChangeSchema(connection);
    }

    private void doChangeSchema(Connection connection) {
        PreparedStatement prepareStatement=null;
        try {
            String schema=(String) UserUtils.getCache("schema");
            if(StringUtils.isNotBlank(schema)){
                prepareStatement = connection.prepareStatement("set search_path="+schema);
                prepareStatement.executeUpdate();
            }/*else{
                prepareStatement = connection.prepareStatement("set search_path=\"Sys_Schema\"");
                prepareStatement.executeUpdate();
            }*/
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
