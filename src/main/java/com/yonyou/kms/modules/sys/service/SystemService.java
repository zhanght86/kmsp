/**
 * 
 */
package com.yonyou.kms.modules.sys.service;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import javax.sql.DataSource;

import nc.itf.kms.ISynchroNCInfo.ISynchroNCInfoLocator;
import nc.itf.kms.ISynchroNCInfo.ISynchroNCInfoPortType;
import nc.vo.kms.entityN.NCUser;
import nc.vo.kms.entityN.OuterSystemRetVO;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.apache.shiro.session.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.security.Digests;
import com.yonyou.kms.common.security.shiro.session.SessionDAO;
import com.yonyou.kms.common.service.BaseService;
import com.yonyou.kms.common.service.ServiceException;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.common.utils.Encodes;
import com.yonyou.kms.common.utils.IdGen;
import com.yonyou.kms.modules.pub.utils.DataSourceUtils;
import com.yonyou.kms.modules.sys.dao.MenuDao;
import com.yonyou.kms.modules.sys.dao.OfficeDao;
import com.yonyou.kms.modules.sys.dao.RoleDao;
import com.yonyou.kms.modules.sys.dao.StatusDao;
import com.yonyou.kms.modules.sys.dao.UserDao;
import com.yonyou.kms.modules.sys.dao.UserSchemaDao;
import com.yonyou.kms.modules.sys.entity.EUser;
import com.yonyou.kms.modules.sys.entity.Menu;
import com.yonyou.kms.modules.sys.entity.Office;
import com.yonyou.kms.modules.sys.entity.Role;
import com.yonyou.kms.modules.sys.entity.Status;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;
import com.yonyou.kms.modules.sys.security.SystemAuthorizingRealm;
import com.yonyou.kms.modules.sys.utils.LogUtils;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @author luqibao
 * @version 2015-9-22
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService implements InitializingBean {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;
	
	//excel中三种操作进行
	public static String DEL_USER="删除";
	public static String UPDATE_USER="更新";
	public static String SIMPLE_USER="不变";
	/**
	 * 数据正常
	 */
	public static String DATA_NORMAL = "0";

	/**
	 * 数据异常
	 */
	public static String DATA_EXCEPTION = "1";

	/**
	 * 数据为空
	 */
	public static String DATA_NULL = "2";
	/**
	 * USER 表名
	 * 
	 */
	public String USERTAB="USER";
	
	
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private SessionDAO sessionDao;
	@Autowired
	private SystemAuthorizingRealm systemRealm;
	@Autowired
	private UserSchemaDao userSchemaDao;
	@Autowired
	private OfficeDao officeDao;
	@Autowired
	private StatusDao statusDao;
	//注入数据源
	@Value("${nc.datasource}")
	private String dataSource;
	//nc远程连接口的信息
	@Value("${nc.romateService}")
	private String romateService;
	
	public SessionDAO getSessionDao() {
		return sessionDao;
	}

	@Autowired
	private IdentityService identityService;

	//-- User Service --//
	
	/**
	 * 获取用户
	 * @param id
	 * @return
	 */
	public User getUser(String id) {
		return UserUtils.get(id);
	}

	/**
	 * 根据登录名获取用户
	 * @param loginName
	 * @return
	 */
	public User getUserByLoginName(String loginName) {
		return UserUtils.getByLoginName(loginName);
	}
	
	//addby yinshh3 2016.1.19
	/**
	 * 根据登录名获取用户1
	 * @param loginName
	 * @return
	 
	public User getUserByLoginName1(String LoginName,String password) {
		return SchemaUtils.getUserByLoginNameAndPassword(LoginName, password);
	}
	*/
	/**
	 * 
	 * @param page
	 * @param user
	 * @param flag
	 * @return
	 */
	public Page<User> findUser(Page<User> page, User user,boolean flag) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));
		// 设置分页参数
		if(flag){
			user.setPage(page);
		}
		// 执行分页查询
//		List<User> us=userDao.findList(user);
////		for(User u:us){
////			System.out.println(u.getName());
////		}
//		System.out.println("us:"+us.size());
		page.setList(userDao.findList(user));
		return page;
	}
	/**
	 * 获取所具有权限下的管理人员列表
	 * @return
	 */
	public List<User> findUserByOffice(Page<User> page, User user){
		List<User> tempUser=Lists.newArrayList();
		List<User> users=Lists.newArrayList();
		Page<User> pages=findUser(page,user,false);
		tempUser=pages.getList();
		//查询是非普通用户的所有用户
		List<User> sys=userDao.getUserRole();
		for(User u:tempUser){
			if(sys.contains(u)){
				users.add(u);
			}
		}
		return users;
	}
	/**
	 * 获取角色下面用户的id的集合
	 * @param role
	 * @return
	 */
	public List<String> hasUser(Role role){
		
		if(role==null||role.getId()==null||role.getId().equals("")){
			throw new RuntimeException("参数出错");
		}
		List<User> users=roleDao.hasUser(role);
		List<String> ids=Lists.newArrayList();
		if(users==null){
			users=Lists.newArrayList();
		}
		for(User user:users){
			ids.add(user.getId());
		}
		return ids;
	}
	
	/**
	 * 无分页查询人员列表
	 * @param user
	 * @return
	 */
	public List<User> findUser(User user){
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "a"));
		List<User> list = userDao.findList(user);
		return list;
	}

	/**
	 * 通过部门ID获取用户列表，仅返回用户id和name（树查询用户时用）
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> findUserByOfficeId(String officeId) {
		List<User> list = (List<User>)CacheUtils.get(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId);
		if (list == null){
			User user = new User();
			user.setOffice(new Office(officeId));
			list = userDao.findUserByOfficeId(user);
			CacheUtils.put(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + officeId, list);
		}
		return list;
	}
	
	@Transactional(readOnly = false)
	public void saveUser(User user) {
		if (org.apache.commons.lang3.StringUtils.isBlank(user.getId())){
			user.preInsert();
			String loginName=user.getLoginName().toUpperCase();
			user.setLoginName(loginName);
			userDao.insert(user);
			
			String sql="insert into user_ent(login_name,user_id,ent_id,tenant_schema_name,id) values(?,?,?,?,?)";
			try {
				SchemaUtils.updatePublicSchema(sql,new Object[]{user.getLoginName(),user.getId(),"1",UserUtils.getCache("schema"),IdGen.uuid()});
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//将全部缓存重新刷新
			CacheUtils.remove(SchemaUtils.CACHE_SCHEMA_MAP);
			
		}else{
			// 清除原用户机构用户缓存
			User oldUser = userDao.get(user.getId());
			if (oldUser.getOffice() != null && oldUser.getOffice().getId() != null){
				CacheUtils.remove(UserUtils.USER_CACHE, UserUtils.USER_CACHE_LIST_BY_OFFICE_ID_ + oldUser.getOffice().getId());
			}
			// 更新用户数据
			user.preUpdate();
			userDao.update(user);
		}
		if (org.apache.commons.lang3.StringUtils.isNotBlank(user.getId())){
			// 更新用户与角色关联
			userDao.deleteUserRole(user);
			if (user.getRoleList() != null && user.getRoleList().size() > 0){
				userDao.insertUserRole(user);
			}else{
				throw new ServiceException(user.getLoginName() + "没有设置角色！");
			}
			// 将当前用户同步到Activiti
			saveActivitiUser(user);
			// 清除用户缓存
			UserUtils.clearCache(user);
//			// 清除权限缓存
//			systemRealm.clearAllCachedAuthorizationInfo();
		}
	}
	
	@Transactional(readOnly = false)
	public void updateUserInfo(User user) {
		user.preUpdate();
		userDao.updateUserInfo(user);
		// 清除用户缓存
		UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public void deleteUser(User user) {
		userDao.delete(user);
		// 同步到Activiti
		deleteActivitiUser(user);
		// 清除用户缓存
		UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	//查询所属机构的管理人员
	@Transactional(readOnly = false)
	public List<User> findUserIsSys(Office office){
		
		return null;
	}
	
	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String loginName, String newPassword) {
		User user = new User(id);
		user.setPassword(entryptPassword(newPassword));
		userDao.updatePasswordById(user);
		// 清除用户缓存
		user.setLoginName(loginName);
		UserUtils.clearCache(user);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public void updateUserLoginInfo(User user) {
		// 保存上次登录信息
		user.setOldLoginIp(user.getLoginIp());
		user.setOldLoginDate(user.getLoginDate());
		// 更新本次登录信息
		user.setLoginIp(UserUtils.getSession().getHost());
		user.setLoginDate(new Date());
		userDao.updateLoginInfo(user);
	}
	
	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword);
	}
	
	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		byte[] salt = Encodes.decodeHex(password.substring(0,16));
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword));
	}
	
	/**
	 * 获得活动会话
	 * @return
	 */
	public Collection<Session> getActiveSessions(){
		return sessionDao.getActiveSessions(false);
	}
	
	//-- Role Service --//
	
	public Role getRole(String id) {
		return roleDao.get(id);
	}

	public Role getRoleByName(String name) {
		Role r = new Role();
		r.setName(name);
		return roleDao.getByName(r);
	}
	
	public Role getRoleByEnname(String enname) {
		Role r = new Role();
		r.setEnname(enname);
		return roleDao.getByEnname(r);
	}
	
	public List<Role> findRole(Role role){
		return roleDao.findList(role);
	}
	
	public List<Role> findAllRole(){
		return UserUtils.getRoleList();
	}
	
	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		if (org.apache.commons.lang3.StringUtils.isBlank(role.getId())){
			role.preInsert();
			roleDao.insert(role);
			// 同步到Activiti
			saveActivitiGroup(role);
		}else{
			role.preUpdate();
			roleDao.update(role);
		}
		// 更新角色与菜单关联
		roleDao.deleteRoleMenu(role);
		if (role.getMenuList().size() > 0){
			roleDao.insertRoleMenu(role);
		}
		// 更新角色与部门关联
		roleDao.deleteRoleOffice(role);
		if (role.getOfficeList().size() > 0){
			roleDao.insertRoleOffice(role);
		}
		// 同步到Activiti
		saveActivitiGroup(role);
		// 清除用户角色缓存
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}

	@Transactional(readOnly = false)
	public void deleteRole(Role role) {
		roleDao.delete(role);
		// 同步到Activiti
		deleteActivitiGroup(role);
		// 清除用户角色缓存
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, User user) {
		List<Role> roles = user.getRoleList();
		for (Role e : roles){
			if (e.getId().equals(role.getId())){
				roles.remove(e);
				saveUser(user);
				return true;
			}
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, User user) {
		if (user == null){
			return null;
		}
		List<String> roleIds = user.getRoleIdList();
		if (roleIds.contains(role.getId())) {
			return null;
		}
		user.getRoleList().add(role);
		saveUser(user);
		return user;
	}

	//-- Menu Service --//
	
	public Menu getMenu(String id) {
		return menuDao.get(id);
	}

	public List<Menu> findAllMenu(){
		return UserUtils.getMenuList();
	}
	
	@Transactional(readOnly = false)
	public void saveMenu(Menu menu) {
		
		// 获取父节点实体
		menu.setParent(this.getMenu(menu.getParent().getId()));
		
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = menu.getParentIds(); 
		
		// 设置新的父节点串
		menu.setParentIds(menu.getParent().getParentIds()+menu.getParent().getId()+",");

		// 保存或更新实体
		if (org.apache.commons.lang3.StringUtils.isBlank(menu.getId())){
			menu.preInsert();
			menuDao.insert(menu);
		}else{
			menu.preUpdate();
			menuDao.update(menu);
		}
		
		// 更新子节点 parentIds
		Menu m = new Menu();
		m.setParentIds("%,"+menu.getId()+",%");
		List<Menu> list = menuDao.findByParentIdsLike(m);
		for (Menu e : list){
			e.setParentIds(e.getParentIds().replace(oldParentIds, menu.getParentIds()));
			menuDao.updateParentIds(e);
		}
		// 清除用户菜单缓存
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
		// 清除日志相关缓存
		CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
	}

	@Transactional(readOnly = false)
	public void updateMenuSort(Menu menu) {
		menuDao.updateSort(menu);
		// 清除用户菜单缓存
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
		// 清除日志相关缓存
		CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(Menu menu) {
		menuDao.delete(menu);
		// 清除用户菜单缓存
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
//		// 清除权限缓存
//		systemRealm.clearAllCachedAuthorizationInfo();
		// 清除日志相关缓存
		CacheUtils.remove(LogUtils.CACHE_MENU_NAME_PATH_MAP);
	}
	
	/**
	 * 获取Key加载信息
	 */
	public static boolean printKeyLoadMessage(){
		StringBuilder sb = new StringBuilder();
		sb.append("\r\n======================================================================\r\n");
		sb.append("\r\n    知识库");
		sb.append("\r\n======================================================================\r\n");
		System.out.println(sb.toString());
		return true;
	}
	
	///////////////// Synchronized to the Activiti //////////////////
	
	// 已废弃，同步见：ActGroupEntityServiceFactory.java、ActUserEntityServiceFactory.java

	/**
	 * 是需要同步Activiti数据，如果从未同步过，则同步数据。
	 */
	private static boolean isSynActivitiIndetity = true;
	public void afterPropertiesSet() throws Exception {
		if (!Global.isSynActivitiIndetity()){
			return;
		}
		if (isSynActivitiIndetity){
			isSynActivitiIndetity = false;
	        // 同步角色数据
			List<Group> groupList = identityService.createGroupQuery().list();
			if (groupList.size() == 0){
			 	Iterator<Role> roles = roleDao.findAllList(new Role()).iterator();
			 	while(roles.hasNext()) {
			 		Role role = roles.next();
			 		saveActivitiGroup(role);
			 	}
			}
		 	// 同步用户数据
			List<org.activiti.engine.identity.User> userList = identityService.createUserQuery().list();
			if (userList.size() == 0){
			 	Iterator<User> users = userDao.findAllList(new User()).iterator();
			 	while(users.hasNext()) {
			 		saveActivitiUser(users.next());
			 	}
			}
		}
	}
	
	private void saveActivitiGroup(Role role) {
		if (!Global.isSynActivitiIndetity()){
			return;
		}
		String groupId = role.getEnname();
		
		// 如果修改了英文名，则删除原Activiti角色
		if (org.apache.commons.lang3.StringUtils.isNotBlank(role.getOldEnname()) && !role.getOldEnname().equals(role.getEnname())){
			identityService.deleteGroup(role.getOldEnname());
		}
		
		Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
		if (group == null) {
			group = identityService.newGroup(groupId);
		}
		group.setName(role.getName());
		group.setType(role.getRoleType());
		identityService.saveGroup(group);
		
		// 删除用户与用户组关系
		List<org.activiti.engine.identity.User> activitiUserList = identityService.createUserQuery().memberOfGroup(groupId).list();
		for (org.activiti.engine.identity.User activitiUser : activitiUserList){
			identityService.deleteMembership(activitiUser.getId(), groupId);
		}

		// 创建用户与用户组关系
		List<User> userList = findUser(new User(new Role(role.getId())));
		for (User e : userList){
			String userId = e.getLoginName();//ObjectUtils.toString(user.getId());
			// 如果该用户不存在，则创建一个
			org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
			if (activitiUser == null){
				activitiUser = identityService.newUser(userId);
				activitiUser.setFirstName(e.getName());
				activitiUser.setLastName(org.apache.commons.lang3.StringUtils.EMPTY);
				activitiUser.setEmail(e.getEmail());
				activitiUser.setPassword(org.apache.commons.lang3.StringUtils.EMPTY);
				identityService.saveUser(activitiUser);
			}
			identityService.createMembership(userId, groupId);
		}
	}

	public void deleteActivitiGroup(Role role) {
		if (!Global.isSynActivitiIndetity()){
			return;
		}
		if(role!=null) {
			String groupId = role.getEnname();
			identityService.deleteGroup(groupId);
		}
	}

	private void saveActivitiUser(User user) {
		if (!Global.isSynActivitiIndetity()){
			return;
		}
		String userId = user.getLoginName();//ObjectUtils.toString(user.getId());
		org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
		if (activitiUser == null) {
			activitiUser = identityService.newUser(userId);
		}
		activitiUser.setFirstName(user.getName());
		activitiUser.setLastName(org.apache.commons.lang3.StringUtils.EMPTY);
		activitiUser.setEmail(user.getEmail());
		activitiUser.setPassword(org.apache.commons.lang3.StringUtils.EMPTY);
		identityService.saveUser(activitiUser);
		
		// 删除用户与用户组关系
		List<Group> activitiGroups = identityService.createGroupQuery().groupMember(userId).list();
		for (Group group : activitiGroups) {
			identityService.deleteMembership(userId, group.getId());
		}
		// 创建用户与用户组关系
		for (Role role : user.getRoleList()) {
	 		String groupId = role.getEnname();
	 		// 如果该用户组不存在，则创建一个
		 	Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
            if(group == null) {
	            group = identityService.newGroup(groupId);
	            group.setName(role.getName());
	            group.setType(role.getRoleType());
	            identityService.saveGroup(group);
            }
			identityService.createMembership(userId, role.getEnname());
		}
	}

	private void deleteActivitiUser(User user) {
		if (!Global.isSynActivitiIndetity()){
			return;
		}
		if(user!=null) {
			String userId = user.getLoginName();//ObjectUtils.toString(user.getId());
			identityService.deleteUser(userId);
		}
	}
	
	
	/**
	 * 同步用户信息
	 * @throws ServiceException
	 * 这里还需要设置几个参数
	 */
	@SuppressWarnings("deprecation" )
	public void synchroNCInfo() throws ServiceException {
		Gson gson = new Gson();
		Logger logger = LoggerFactory.getLogger(getClass());

		try {
			/** ************获取用户的同步记录表数据(用于判断是否第一次同步)************** */
			String maxTs = statusDao.selectStatus(USERTAB);
			logger.debug("maxTs:"+maxTs);
			//设置储存用户的list
			List<User> userAddList = new ArrayList<User>();
			List<User> userUpdateList=new ArrayList<User>();
			//用户同步记录
			Status userStatus = null;
			//连接nc远程服务   调取数据
			ISynchroNCInfoLocator service = new ISynchroNCInfoLocator();
			URL url=new URL(romateService);
			//ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http();
			ISynchroNCInfoPortType client =service.getISynchroNCInfoSOAP11port_http(url);
			if (StringUtils.isEmpty(maxTs)) {// 第一次同步，所取数据为新增的数据

				/** *******************获取NC用户信息************** */
				//获取用户信息
				
				OuterSystemRetVO user = client.getNCUserInfo(dataSource, "1999-09-09 10:10:10", "", "");//调用接口getNCUserInfo
				// 调用接口成功且数据正常
				if ((user.isSuccess())
						&& (DATA_NORMAL.equals(user.getDataState()))) {
					// 获取传过来的用户数据
					 List<NCUser> retList = gson.fromJson(user.getData(),  
				                new TypeToken<List<NCUser>>() {  
				                }.getType());
					 logger.debug("更新的用户数量："+retList.size());
					 
					 /**
					  *转化用户格式
					  * 
					  */
					 NCUser2LocalUser(retList,userAddList);
//						
					//储存更新的时间  下次更新从这个时间戳开始更新数据
					userStatus = new Status();
					userStatus.setId(IdGen.uuid());
					userStatus.setTs(user.getMaxTs());
					userStatus.setFromSys(USERTAB);
					statusDao.insertStatus(userStatus);
				} else {
					return;
				}

			}else{
				//ISynchroNCInfoLocator service = new ISynchroNCInfoLocator();
				//ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http();
				//----这是直接调用URL的方式
				//URL url=new URL(romateService);
				//ISynchroNCInfoPortType client =service.getISynchroNCInfoSOAP11port_http(url);
				//-----
				OuterSystemRetVO user = client.getNCUserInfo(dataSource, maxTs, "", "");//调用接口getNCGroupInfo
				List<User> userList = new ArrayList<User>();
				logger.debug("更新数据："+userList.size());
				// 调用接口成功且数据正常
				if ((user.isSuccess())
						&& (DATA_NORMAL.equals(user.getDataState()))) {
					// 获取传过来的集团数据
					 List<NCUser> retList = gson.fromJson(user.getData(),  
				                new TypeToken<List<NCUser>>() {  
				                }.getType());
					 logger.debug(user.getData());
					 //将数据格式转化为知识库对应的数据
					 userAddList=NCUser2LocalUser(retList,userAddList);
//					 
					//设置更新的时间
					 if(!userAddList.isEmpty()){
						
							userStatus = new Status();
							userStatus.setId(IdGen.uuid());
							userStatus.setTs(user.getMaxTs());
							userStatus.setFromSys(USERTAB);
							statusDao.insertStatus(userStatus);
					 }
					//查出知识库中所有的数据  
					 
					List<User> users= userDao.batchSelect();
					 
					//验证是否为新增还是修改  新增就直接添加  修改就 删除以后再增加
					for(User u1:userAddList){
						
						if(users.contains(u1)){
							//将更新的数据加入到updateList里面
							userUpdateList.add(u1);
							//同时将数据从addList中移除
						}
					}
				}
			}
			
			List<User> tempUsers=Lists.newArrayList();
			if((userAddList != null) && (!userAddList.isEmpty())){
				//System.out.println("插入");
				//调用user批量插入接口
				//userDao.batchInsert(userAddList);
				for(User u:userAddList){
					
					//为了防止多次插入导致相同数据报错
//					if(userDao.get(u)!=null){
//						continue;
//					}
					if(tempUsers.contains(u)||userUpdateList.contains(u)){
						continue;
					}
					tempUsers.add(u);
					userDao.insert(u);
					roleDao.insertUserRole(u.getId());
				}
			}
			tempUsers.clear();
			if((userUpdateList != null) && (!userUpdateList.isEmpty())){
				//调用user批量更新接口
				//使用单个操作  不然会出现一个出现问题  全部的数据都插不进去
				
				for(User u:userUpdateList){
					if(tempUsers.contains(u)){
						continue;
					}
					tempUsers.add(u);
					userDao.update(u);
				}
			
		}
			}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	/**
	 * 数据形式的转化
	 * add:luqibao
	 * @param ncUsers 
	 * @param localUsers
	 */
	private List<User> NCUser2LocalUser(List<NCUser> ncUsers,List<User> localUsers){
		 User u=null;
		 for(NCUser nu:ncUsers){
				u=new User();
				u.setId(nu.getId());
				/*登录名都变为大写*/
				u.setLoginName(nu.getLoginName().toUpperCase());
				u.setPassword(nu.getPassword());
				u.setLoginFlag(nu.getLoginFlag());
				u.setNo(nu.getNo());
				Office office=officeDao.get(nu.getCompany());
				u.setCompany(office);
				//设置部门
				office=officeDao.get(nu.getOffice());
				u.setOffice(office);
				u.setDelFlag(nu.getDelFlag());
				if(nu.getName()==null){
					u.setName(nu.getLoginName());
				}else{
					u.setName(nu.getName());
				}
				User uu=new User();
				uu.setId("1");
				u.setCreateBy(uu);
				u.setCreateDate(new Date());
				u.setUpdateBy(uu);
				u.setUpdateDate(new Date());
				u.setPhone("123");
				u.setEmail("123@qq.com");
				u.setRemarks("111");
				u.setPhoto("1");
				u.setMobile("13678");
				u.setUserType("1");
				
				localUsers.add(u);
				
			}
		return localUsers;
	}
	//add by luqibao 将excel导入的数据转化为本地的用户 
	//并且存入数据库中
	//2016-01-13
	/***
	 * return:操作失败的用户（只有name属性）
	 */
	@Transactional(readOnly = false)
	public List<EUser> EUser2User(List<EUser> eUsers){

		
		//操作失败的用户
		List<EUser> failUser=Lists.newArrayList();
		//新增加的用户
		List<User> addUser=Lists.newArrayList();
		//修改的用户
		List<User> updateUser=Lists.newArrayList();
		User user=null;
		for(EUser e:eUsers){
			//判断用户是不是操作合法 如果不是合法的话 那么就跳出
			if(!validateUser(e)){
			failUser.add(e);continue;
			};
			
			//更新操作的用户
			if(UPDATE_USER.equals(e.getOpertaion())){
				user=new User();
				user.setLoginName(e.getLoginName().toUpperCase());
				user=userDao.getUserByLoginNameIgnoreDel(user);
				//如果不为空那么就是更新操作
				if(user!=null){
					//设置一些基本属性 保存登录标志和删除标志
					User uu=change(user,e);
					uu.setDelFlag("0");
					uu.setUserType("1");
					uu.setLoginFlag("1");
					userDao.cancelDel(uu);
					updateUser.add(uu);
				}else{
					//如果为空的话  那么就是插入操作
					user=new User();
					user.setLoginName(e.getLoginName().toUpperCase());
					user=change(user,e);
					user.preInsert();
					User u=UserUtils.getUser();
					user.setCreateBy(u);
					user.setCreateDate(new Date());
					user.setDelFlag("0");
					user.setUserType("1");
					user.setLoginFlag("1");
					user.setPhoto("1");
					user.setNo(u.getLoginName());
					addUser.add(user);
				}
			}
			//删除的操作
			if(DEL_USER.equals(e.getOpertaion())){
				User u=new User();
				u.setLoginName(e.getLoginName().toUpperCase());
				User uu=userDao.getUserByLoginNameIgnoreDel(u);
				//如果删除的用户在用户表中是没有的 那么视为失败
				if(uu==null){
					failUser.add(e);continue;
				}
				uu.setDelFlag("1");
				userDao.delete(uu);
			}
			
		}
		
		//将用户插入到数据库中
		List<User> tempUsers=Lists.newArrayList();
		//判断和其他公司有没有重复的登录名,如果登陆名重复的话，那么就将用户用户归为失败
		Map<String, UserSchema> uss = SchemaUtils.getAllUserSchema();
		List<String> alreadyExist=Lists.newArrayList();
		for(Map.Entry<String, UserSchema> us:uss.entrySet()){
			alreadyExist.add(us.getValue().getLoginName());
		}
		//获取到当前导入人的schema
		String cache = (String) UserUtils.getCache("schema");
		
		//这里是判断逻辑
		if((addUser != null) && (!addUser.isEmpty())){
			//设置CountDownLatch downLatch
			CountDownLatch  downLatch=new CountDownLatch(addUser.size());
			//创建线程池 默认设定一百个线程
			Executor executor = Executors.newFixedThreadPool(100);
			
			for(User u:addUser){
				RunnableImpl runnableImpl = new RunnableImpl(alreadyExist,downLatch,u,cache,failUser);
				executor.execute(runnableImpl);
			}
			
			try {  
	            downLatch.await();
	        } catch (InterruptedException e) {  
	        }finally{
	        	//刷新缓存
	        	CacheUtils.remove(SchemaUtils.CACHE_SCHEMA_MAP);
	        }
			
		}
		tempUsers.clear();
		//将更新的用户更新到数据库中
		if((updateUser != null) && (!updateUser.isEmpty())){
			//调用user批量更新接口
			//使用单个操作  不然会出现一个出现问题  全部的数据都插不进去
			for(User u:updateUser){
				if(tempUsers.contains(u)){
					continue;
				}
				tempUsers.add(u);
				userDao.update(u);
				//删除当前这个用户的缓存
				UserUtils.clearCache(u);
			}
		}
		return failUser;
	}
	
	//因为会有很多的插入操作，所以开启线程进行插入
	class RunnableImpl extends Thread{
			
			private List<String> alreadyExist;
			private CountDownLatch downLatch;
			private User user;
			private String schema;
			List<EUser> failUser;
	
			public RunnableImpl(List<String> alreadyExist,
					CountDownLatch downLatch, User user,String schema,List<EUser> failUser) {
				super();
				this.alreadyExist = alreadyExist;
				this.downLatch = downLatch;
				this.user = user;
				this.schema=schema;
				this.failUser=failUser;
			}
			@Override
			public void run() {
				
				downLatch.countDown();
				if(alreadyExist.contains(user.getLoginName())){
					EUser eu=new EUser();
					eu.setName(user.getName());
					failUser.add(eu);
				}else{
					try{
						//将数据插入到数据库
						userDao.insert(user);
						roleDao.insertUserRole(user.getId());
						String sql="insert into user_ent(login_name,user_id,ent_id,tenant_schema_name,id) values(?,?,?,?,?)";
						SchemaUtils.updatePublicSchema(sql,new Object[]{user.getLoginName(),IdGen.uuid(),"1",schema,user.getId()});
						//add by yinshh3 1.22 2016 9:32
						String subject="导入成功";
						String content="您好,您的信息已经成功导入到企业知识库";
						SchemaUtils.sendEmail(user, subject, content);
					}catch(Exception e){
						e.printStackTrace();
					}
				}
			}
			
		}
	
	
	//将EUser转化为User
	private User change(User user,EUser e){
		//将人员的对应到知识库的人员中
		user.setName(e.getName());
		user.setPassword(entryptPassword(e.getPassword()));
		Office o=new Office();
		o.setId(e.getCompanyId());
		user.setCompany(o);
		Office o1=new Office();
		o1.setId(e.getOfficeId());
		user.setOffice(o1);
		if(e.getPhone()!=null){
			user.setPhone(e.getPhone());
		}
		if(e.getMobile()!=null){
			user.setMobile(e.getMobile());
		}
		if(e.getEmail()!=null){
			user.setEmail(e.getEmail());
		}
		if(e.getRemark()!=null){
			user.setRemarks(e.getRemark());
		}
		User u=UserUtils.getUser();
		user.setUpdateBy(u);
		user.setUpdateDate(new Date());
		return user;
	}
	//验证客户输入的excel数据是否是合法的
	public boolean validateUser(EUser user){
		String opertaion=user.getOpertaion();
		System.out.print(opertaion);
		if(!UPDATE_USER.equals(opertaion)&&!DEL_USER.equals(opertaion)&&!SIMPLE_USER.equals(opertaion)){
			return false;
		}
		String loginName=user.getLoginName();
		String name=user.getName();
		String password=user.getPassword();
		String companyId=user.getCompanyId();
		String officeId=user.getOfficeId();
		if(companyId==null||loginName==null||name==null||password==null||password==null||officeId==null||opertaion==null){
			return false;
		}
		if("".equals(companyId)||"".equals(loginName)||"".equals(name)||"".equals(password)||"".equals(password)||"".equals(officeId)||"".equals(opertaion)){
			return false;
		}
		return true;
	}
	
	//add hefeng
	/**
	 * 初始化企业Schema数据
	 * @param schemaName
	 * @param 
	 * @return Boolean 
	 * true:成功初始化数据。
	 * 
	 */
	@Transactional(readOnly=false)
	public Boolean initSchemaData(final String schemaName,final String loginName,final String password){
			boolean flag=false;
					Connection conn=null;
					try {
						if(isSchemaExist(schemaName)){
							flag=false;
						}else{
							
							DataSource dataSourcesql = DataSourceUtils.getSchemaDataSource();
							conn=dataSourcesql.getConnection();
							conn.setAutoCommit(false);
							//创建
							PreparedStatement prepareStatement1 = conn.prepareStatement("CREATE SCHEMA "+schemaName);
							prepareStatement1.executeUpdate();
							prepareStatement1.close();
							//切换schema
							PreparedStatement prepareStatement2 = conn.prepareStatement("set search_path="+schemaName);
							prepareStatement2.executeUpdate();
							prepareStatement2.close();
							//运行sql脚本
							ScriptRunner runner=new ScriptRunner(conn);
							runner.setLogWriter(null);
							runner.setAutoCommit(false);
							//runner.runScript(Resources.getResourceAsReader("test.sql"));
							InputStream resourceAsStream = SystemService.class.getResourceAsStream("/schemadata.sql");
							runner.runScript(new InputStreamReader(resourceAsStream,"UTF-8"));
							//修改模式中默认的登录名
							//System.out.print("......进入？");
							PreparedStatement prepareStatement3=conn.prepareStatement("UPDATE "+schemaName+".sys_user SET login_name=?, password=? WHERE id=?");//修改预制的用户数据
							prepareStatement3.setString(1, loginName.toUpperCase());
							prepareStatement3.setString(2, entryptPassword(password));
							prepareStatement3.setString(3, "1");//此id为预制脚本中存在的superadmin的id
							prepareStatement3.executeUpdate();
							prepareStatement3.close();
							
							//切换到系统schema
							String sysschemaName="Sys_Schema";
							PreparedStatement prepareStatement4 = conn.prepareStatement("set search_path="+sysschemaName);
							prepareStatement4.executeUpdate();
							prepareStatement4.close();
							
							conn.commit();
							System.out.println("初始化企业数据成功了");
							flag=true;
						}
						
					} catch (Exception e) {
						try {
							conn.rollback();
						} catch (SQLException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
						e.printStackTrace();
					}finally{
						try {
							if(conn!=null){
								if(conn.isClosed()){
									
								}else{
									conn.close();
								}
							}
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
		/*ExecutorService executor = Executors.newSingleThreadExecutor();
		FutureTask<Boolean> future =new FutureTask<Boolean>(new Callable<Boolean>(){

				@Override
				public Boolean call() throws Exception {
					// TODO Auto-generated method stub
						Connection conn=null;
						try {
							if(userSchemaDao.isSchemaExist(schemaName)>0){
								return false;
							}else{
								DataSource dataSourcesql = DataSourceUtils.getSchemaDataSource();
								conn=dataSourcesql.getConnection();
								//创建
								PreparedStatement prepareStatement1 = conn.prepareStatement("CREATE SCHEMA "+schemaName);
								prepareStatement1.executeUpdate();
								prepareStatement1.close();
								//切换schema
								PreparedStatement prepareStatement2 = conn.prepareStatement("set search_path="+schemaName);
								prepareStatement2.executeUpdate();
								prepareStatement2.close();
								//运行sql脚本
								ScriptRunner runner=new ScriptRunner(conn);
								runner.setLogWriter(null);
								//runner.runScript(Resources.getResourceAsReader("test.sql"));
								InputStream resourceAsStream = SystemService.class.getResourceAsStream("/schemadata.sql");
								runner.runScript(new InputStreamReader(resourceAsStream,"UTF-8"));
								//修改模式中默认的登录名
								PreparedStatement prepareStatement3=conn.prepareStatement("UPDATE "+schemaName+".sys_user SET login_name=?, password=? WHERE id=?");//修改预制的用户数据
								prepareStatement3.setString(1, loginName);
								prepareStatement3.setString(2, entryptPassword(password));
								prepareStatement3.setString(3, "1");//此id为预制脚本中存在的superadmin的id
								prepareStatement3.executeUpdate();
								prepareStatement3.close();
								conn.commit();
								logger.info("初始化企业数据成功了");
							}
							return true;
						} catch (Exception e) {
							e.printStackTrace();
						}finally{
							try {
								if(conn!=null){
									if(conn.isClosed()){
										
									}else{
										conn.close();
									}
								}
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}//finally end
					
					return false;
				}//call end
	        	 
	         });
		executor.execute(future);
		boolean result=false;
		try {
			result=future.get();
		} catch (InterruptedException e) {
			future.cancel(true);
			e.printStackTrace();
		} catch (ExecutionException e) {
			future.cancel(true);
			e.printStackTrace();
		}finally {  
		    executor.shutdown();  
		}  */
		return flag;
	}
	
	/**
	 * 删除企业Schema 
	 * @return Boolean  
	 * true:成功删除。
	 * 
	 */
	@Transactional(readOnly=false)
	public Boolean deleteSchema(final String schemaName){
		boolean flag=false;
		Connection conn=null;
		try {
			if(isSchemaExist(schemaName)){
				DataSource dataSourcesql = DataSourceUtils.getSchemaDataSource();
				conn=dataSourcesql.getConnection();
				conn.setAutoCommit(false);
				PreparedStatement prepareStatement1 = conn.prepareStatement("DROP SCHEMA "+schemaName+" CASCADE");
				prepareStatement1.executeUpdate();
				prepareStatement1.close();
				conn.commit();
				flag=true;
			}else{
				flag=false;
			}
			
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			try {
				if(conn!=null){
					if(conn.isClosed()){
						
					}else{
						conn.close();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	public Boolean isSchemaExist(String schemaName){
		DataSource dataSourcesql = DataSourceUtils.getSchemaDataSource();
		boolean flag=false;
		Connection conn=null;
		try {
			conn=dataSourcesql.getConnection();
			PreparedStatement ps = conn.prepareStatement("select SCHEMA_NAME from information_schema.schemata where SCHEMA_NAME=?");
			ps.setString(1, schemaName);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				flag=true;
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(conn!=null){
					if(conn.isClosed()){
						
					}else{
						conn.close();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	//end hefeng
}
