package com.yonyou.kms.modules.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.cms.entity.PersonContribution;
/**
 * 个人贡献DAO
 * 
 * @author yangshiwei
 *
 */

@MyBatisDao
public interface PersonContributionDao extends CrudDao<PersonContribution>{
	//将全部用户关联的知识数计算出，并取出
	public List<PersonContribution>  getUserToActi(@Param(value="str") String str);
	
	//查询个人贡献表中是否有这条记录
	public String getData(String userid);
	
	//取出数据后存入到个人贡献表中（批量插入）
	public void insertContributionData(@Param(value="list") List<PersonContribution> list,@Param(value="str") String str);
	//取出数据后存入到个人贡献表中（批量更新）
	public void updateContributionData(@Param(value="list") List<PersonContribution> list,@Param(value="str") String str);
	
	//读取个人贡献表中的数据
	public List<PersonContribution> getContributionData();
	//批量删除数据
	public void deleteData(List<String> userid,@Param(value="str") String str);
	//取得所有的用户id
	public List<String> getAllid(@Param(value="str") String str);
	//取得所属部门
	public String getOfficeName(String userid);
}
