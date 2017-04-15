package com.yonyou.kms.modules.sys.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.mail.MailSenderInfo;
import com.yonyou.kms.common.mail.SimpleMailSender;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.common.utils.SpringContextHolder;
import com.yonyou.kms.modules.pub.utils.DataSourceUtils;
import com.yonyou.kms.modules.sys.dao.UserSchemaDao;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;

/**
 * 数据库模式工具类
 * @author Hotusm
 *2016-01-18
 */
public class SchemaUtils {

	public static final String CACHE_SCHEMA_MAP = "schemaMap";
	private static UserSchemaDao UserSchemaDao = SpringContextHolder.getBean(UserSchemaDao.class);

	private static DataSource dataSourcesql=SpringContextHolder.getBean("dataSource");
	//连接公共schema

	/**
	 * 获取所以的用户schema信息
	 * map的key是用户名 value是vo属性
	 * @return
	 */
	public static Map<String,UserSchema> getAllUserSchema(){
		
		@SuppressWarnings("unchecked")
		Map<String,UserSchema> userSchemas=(Map<String, UserSchema>) CacheUtils.get(CACHE_SCHEMA_MAP);
		if(userSchemas==null||userSchemas.size()<=0){
			userSchemas=new HashMap<String,UserSchema>();
			String sql="select login_name,user_id,ent_id,tenant_schema_name,id from \"Sys_Schema\".user_ent";
			List<UserSchema> all=Lists.newArrayList();
			try {
				all = queryPublicSchema(sql,UserSchema.class,null,new String[]{"loginName","userId","entId","tenantSchemaName","id"},new Class[]{String.class,String.class,String.class,String.class,String.class});
			} catch (Exception e) {
				e.printStackTrace();
				//如果操作失败,
				CacheUtils.remove(SchemaUtils.CACHE_SCHEMA_MAP);
			}
			for(UserSchema us:all){
				userSchemas.put(us.getLoginName(), us);
			}
			
			CacheUtils.put(CACHE_SCHEMA_MAP, userSchemas);
		}
		
		return userSchemas;
	}
//	
//	changetopublicschema
//	{
//		cache[]="sys_schema";
//	}
//	
//	changetoprivateschema()
//	{
//		cache[]="ent1_schema";
//	}
	
	/**
	 * 
	 * @param id 用户的id
	 * @return 返回这个用户的schema的信息
	 */
	public static UserSchema findUserSchemaByLoginName(String loginName){
		Map<String, UserSchema> users = getAllUserSchema();
		UserSchema user = users.get(loginName);
		return user;
	}
	/**
	 * 获取当前用户的schema的名称
	 * @return
	 */
	public static String getCurrentUserSchema(){
		User user = UserUtils.getUser();
		String id=user.getId();
		if(id!=null){
//			UserSchema userSchema = (UserSchema) CacheUtils.get("schemaInfo"+id);
//			if(userSchema==null){
//				userSchema = UserSchemaDao.findByUserId(user.getId());
//				CacheUtils.put("schemaInfo"+id,userSchema);
//			} 
//			id=userSchema.getTenantSchemaName();
			String cache=(String) CacheUtils.get("schemaInfo"+id);
			if(cache==null){
				Connection conn=null;
				try {
					conn = dataSourcesql.getConnection();
					PreparedStatement p2 = conn.prepareStatement("set search_path=Sys_Schema");
					p2.execute();
					p2.close();
					PreparedStatement prepareStatement = conn.prepareStatement("select tenant_schema_name from user_ent where user_id=?");
					prepareStatement.setString(1, id);
					ResultSet rs=prepareStatement.executeQuery();
					while(rs.next()){
						cache=rs.getString(1);
						UserUtils.putCache("schemaInfo"+id, cache);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					try {
						if(!conn.isClosed()){
							conn.close();
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			
			return cache;
		}else{
			return "public";
		}
	}

	
	/**
	 * 根据登录名获取对应的userSchema集.//未登录前 1.20 2016 yinshh3
	 * @param LoginName
	 * @return
	 */
	public static UserSchema getUserSchemaByLoginName(String LoginName){
		UserSchema userSchema=new UserSchema();
		userSchema=UserSchemaDao.getUserSchemaByLoginName(LoginName);
		return userSchema;
	}
	/**
	 * 根据登录名和密码来验证得到user.//未登录前  1.20 2016 yinshh3
	 * @param LoginName
	 * @param password
	 * @return
	 
	public static User getUserByLoginNameAndPassword(String LoginName,String password){
		UserSchema userSchema=new UserSchema();
		User user=new User();
		userSchema=getUserSchemaByLoginName(LoginName);
		//通过userSchema找到user
		user=UserSchemaDao.getUserByUserSchema(userSchema);
		//如果验证正确,就返回这个user
		if(SystemService.validatePassword(password,user.getPassword())){
			return user;
			
		}
		else{
			return null;
		}
	}
*/
	//add by luqibao 2016-01-20
	/**
	 * 这个方法是操作公共schema的
	 * @param sql 更新的sql语句比如
	 * @param params 参数名称
	 * 参考：
	 * <code>
	 * String sql="insert into user_ent(login_name,user_id,ent_id,tenant_schema_name,id) values(?,?,?,?,?)";
			try {
				SchemaUtils.updatePublicSchema(sql,new Object[]{user.getLoginName(),user.getId(),"1",UserUtils.getCache("schema"),IdGen.uuid()});
			} catch (SQLException e) {
				e.printStackTrace();
			}
		
	 * </code>
	 * 
	 */
	public static void updatePublicSchema(String sql,Object...params) throws SQLException{
		
		DataSource dataSource = DataSourceUtils.getSchemaDataSource();
		Connection conn=dataSource.getConnection();
		conn.setAutoCommit(false);
		PreparedStatement p = conn.prepareStatement(sql);
		if(params!=null){
			for(int i=0;i<params.length;i++){
				Object o=params[i];
				//获取类型的名字
				p.setObject(i+1, o);
			}
		}
		int executeUpdate = p.executeUpdate();
		System.out.println(executeUpdate);
		p.close();
		conn.commit();
		//没有关闭connection的时候  那么就关闭连接
		if(!conn.isClosed()){
			conn.close();
		}
	}
	//end
	/***
	 * 这个方法是操作公共schema的
	 * @param sql 查询语句
	 * @param clazz vo的类
	 * @param params sql语句中的参数值 和查询语句中的必须一致
	 * @param propertis 返回的属性 需要和查询语句的顺序是一样的
	 * @param clazzs 返回值属性的类型
	 * @return 返回值的集合
	 * 参考：
	 * <code>String sql="select login_name,tenant_schema_name from user_ent";
		try {
			List<UserSchema> results = SchemaUtils.queryPublicSchema(<strong>sql</strong>, UserSchema.class, null, new String[]{"loginName","tenantSchemaName"},new Class[]{String.class,String.class});
			for(UserSchema u:results){
				System.out.println(u.getLoginName()+" "+u.getTenantSchemaName());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		<code>
	 * 
	 */
	public static <T>  List<T> queryPublicSchema(String sql,Class<T> clazz,String[] params,String[] properties,Class<?>[] clazzs) throws Exception{
		
		T t = null;
		List<T> ts=Lists.newArrayList();
		//执行查询语句
		DataSource dataSource = DataSourceUtils.getSchemaDataSource();
		Connection conn=dataSource.getConnection();
		conn.setAutoCommit(false);
		PreparedStatement p = conn.prepareStatement(sql);
		if(params!=null){
			for(int i=0;i<params.length;i++){
				Object o=params[i];
				//获取类型的名字
				p.setObject(i+1, o);
			}
		}
		//获取查询到的数据
		ResultSet result = p.executeQuery();
		//获取所有的字段
		Field[] dfs = clazz.getDeclaredFields();
		List<String> pros=Lists.newArrayList();;
		for(Field f:dfs){
			pros.add(f.getName());
		}
		//验证参数合不合法
		for(String param:properties){
			if(!pros.contains(param)){
				throw new RuntimeException("参数错误");
			}
		}
		//将属性放入到实体中
		while(result.next()){
			t=clazz.newInstance();
			for(int i=0;i<properties.length;i++){
				 Object b = result.getObject(i+1);
	   			 String methodName="set"+properties[i].substring(0,1).toUpperCase()+
	   			 properties[i].substring(1);
	   			 //根据set方法和参数类型获取这个方法
	   			 Method method = clazz.getMethod(methodName, new Class[]{clazzs[i]});
	   			 method.invoke(t,new Object[]{b});
			}
			ts.add(t);
		}
		p.close();
		conn.commit();
		//没有关闭connection的时候  那么就关闭连接
		if(!conn.isClosed()){
			conn.close();
		}
		return ts;
	}
	
	
	/**
	 * 
	 * @param user 接收的用户
	 * @param subject 发送邮件的主题
	 * @param content 发送邮件的内容
	 */
	public static void sendEmail(User user,String subject,String content){
		if(user.getEmail()!=null&&!"".equals(user.getEmail())){
			MailSenderInfo mailInfo = new MailSenderInfo();
			  StringBuffer buffer1 = new StringBuffer();
			  StringBuffer buffer2 = new StringBuffer();
			 mailInfo.setMailServerHost("smtp.163.com");
			  mailInfo.setMailServerPort("25");
			  mailInfo.setValidate(true);
			 // 邮箱用户名
			  mailInfo.setUserName("kms_pub@163.com");
			  // 邮箱密码cobfqswvbqpjduwd
			  mailInfo.setPassword("cobfqswvbqpjduwd");
			  // 发件人邮箱
			  mailInfo.setFromAddress("kms_pub@163.com");
			  // 收件人邮箱
			  mailInfo.setToAddress(user.getEmail());
			  // 邮件标题
			  buffer1.append(subject);
			  buffer2.append(content);
			  mailInfo.setSubject(buffer1.toString());
			  // 邮件内容
			  mailInfo.setContent(buffer2.toString());
			  SimpleMailSender.sendHtmlMail(mailInfo);
		}
	}

}
