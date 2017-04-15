package com.yonyou.kms.modules.cms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.service.CrudService;
import com.yonyou.kms.modules.cms.dao.CategoryDao;
import com.yonyou.kms.modules.cms.dao.ShareDao;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.Share;
import com.yonyou.kms.modules.cms.entity.Store;





/**
 * 分享Service
 * @author zy
 * 
 */
@Service
public class ShareService  extends CrudService<ShareDao, Share>{
	@Autowired 
	ShareDao sharedao;
	@Autowired
	private CategoryDao categoryDao;
	
	public Page<Share> findPage(Page<Share> page, Share share) {//分页显示
//		DetachedCriteria dc = commentDao.createDetachedCriteria();
//		if (StringUtils.isNotBlank(comment.getContentId())){
//			dc.add(Restrictions.eq("contentId", comment.getContentId()));
//		}
//		if (StringUtils.isNotEmpty(comment.getTitle())){
//			dc.add(Restrictions.like("title", "%"+comment.getTitle()+"%"));
//		}
//		dc.add(Restrictions.eq(Comment.FIELD_DEL_FLAG, comment.getDelFlag()));
//		dc.addOrder(Order.desc("id"));
//		return commentDao.find(page, dc);
		share.getSqlMap().put("dsf", dataScopeFilter(share.getCurrentUser(), "o", "u"));//获取当前user
		if (share.getCategory()!=null && org.apache.commons.lang3.StringUtils.isNotBlank(share.getCategory().getId()) && !Category.isRoot(share.getCategory().getId())){
			Category category = categoryDao.get(share.getCategory().getId());
			if (category==null){
				category = new Category();
			}
			category.setParentIds(category.getId());
			category.setSite(category.getSite());
			share.setCategory(category);
		}
		else{
			share.setCategory(new Category());
		}
		return super.findPage(page, share);
	}
	
//	@Override
//	public void save(Share entity) {
//		
//		Share share= sharedao.get(entity);
//		if(share==null){
//			entity.setIsNewRecord(false);
//			entity.preInsert();
//			dao.insert(entity);
//			System.out.println(entity.getId());
//		}
//	}
	@Override
	public String save(Share entity) {
		Share share= sharedao.get(entity);
		if(share==null){
			entity.setIsNewRecord(false);
			entity.preInsert();
			dao.insert(entity);
		}else{
			entity.preUpdate();
			dao.update(entity);
		}
		return "";
	}
	
	
//	public void save(Store entity) {
//		Store store= storedao.get(entity);
//		if(store==null){
//			entity.setIsNewRecord(false);
//			entity.preInsert();
//			dao.insert(entity);
//		}else{
//			entity.preUpdate();
//			dao.update(entity);
//		}
//	}
	
	public Share getshare( String tid ){
		return sharedao.getShare(tid);
	}

//	public void delete(Shareentity) {
//		super.delete(entity);
//	}
	public void MergeArticle(String originalcategoryId,String categoryId,String articleId){
		dao.MergeArticle(originalcategoryId, categoryId, articleId);
	}

	public void MergeCategory(String originalcategoryId, String categoryId) {
		dao.MergeCategory(originalcategoryId, categoryId);
	}
}
