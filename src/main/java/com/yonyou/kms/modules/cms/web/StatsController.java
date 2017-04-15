/**
 * 
 */
package com.yonyou.kms.modules.cms.web;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.service.BaseService;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.service.CategoryService;
import com.yonyou.kms.modules.cms.service.StatsService;

/**
 * 统计Controller
 * @author hotsum
 * @version 2013-5-21
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/stats")
public class StatsController extends BaseController {

	@Autowired
	private StatsService statsService;
	@Autowired
	private CategoryService categoryService;
	
	/**
	 * 文章信息量
	 * @param paramMap
	 * @param model
	 * @return 	
	 */
	@RequiresPermissions("cms:stats:article")
	@RequestMapping(value = "article")
	public String article(@RequestParam Map<String, Object> paramMap, Model model) {
		List<Category> tempList = statsService.article(paramMap);
		List<Category> temp=Lists.newArrayList();
		List<String> ids=Lists.newArrayList();
		//categoryService.findByUser(true, "article", BaseService.CATEGORY_PLACE_SYS);
		// add by luqibao  2015-12-30显示具有权限的分类统计
		List<Category> list =categoryService.findByUser(true, "article", BaseService.CATEGORY_PLACE_SYS);
		for(Category c:list){
			ids.add(c.getId());
		}
		for(Category c:tempList){
			System.out.println(c.getName());
			if(list.contains(c.getId())){
				temp.add(c);
			}
		}
		
		model.addAttribute("list", tempList);
		model.addAttribute("paramMap", paramMap);
		return "modules/cms/statsArticle";
	}

}
