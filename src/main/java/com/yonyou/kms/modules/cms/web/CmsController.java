/**
 * 
 */
package com.yonyou.kms.modules.cms.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.service.BaseService;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.Label;
import com.yonyou.kms.modules.cms.entity.Switch;
import com.yonyou.kms.modules.cms.service.CategoryService;
import com.yonyou.kms.modules.cms.service.LabelService;
import com.yonyou.kms.modules.cms.service.SwitchService;
import com.yonyou.kms.modules.oa.service.OaNotifyService;
import com.yonyou.kms.modules.sys.utils.UserUtils;


/**
 * 内容管理Controller
 * @author hotsum
 * @version 2013-4-21
 */
@Controller
@RequestMapping(value = "${adminPath}/cms")
public class CmsController extends BaseController {

	@Autowired
	private CategoryService categoryService;
	@Autowired
	private LabelService labelservice;
	@Autowired
	private OaNotifyService oaNotifyService;
	@Autowired
	private SwitchService switchService;
	
	/*
	 * 这段代码移步ArticleController->171
	 * huangmj 2015.10.23,首页发布知识
	
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "add_article")
	public String index1(Article article, Model model) {
		// 如果当前传参有子节点，则选择取消传参选择
		if (article.getCategory()!=null && org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId())){
			List<Category> list = categoryService.findByParentId(article.getCategory().getId(), Site.getCurrentSiteId());
			if (list.size() > 0){
				article.setCategory(null);
			}else{
				article.setCategory(categoryService.get(article.getCategory().getId()));
			}
		}

        model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("article", article);
		//model.addAttribute("listArticleAttFile",listArticleAttFile);
		model.addAttribute("native", "1");
		model.addAttribute("realize", null);
		CmsUtils.addViewConfigAttribute(model, article.getCategory());
		
		return "modules/cms/articleForm";
	}
	 */
	
	/*
	 * 后台知识管理，huangmj 2015.10.23
	 */
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "")
	public String index(HttpServletRequest request ,HttpServletResponse response) {

		return "modules/cms/cmsIndex";
	}
	
	//add by luqibao 
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "tree")
	public String tree(Model model) {
		List<Category> list = categoryService.findByUser(true, null,BaseService.CATEGORY_PLACE_SYS);
//		for(Category c:list){
//			System.out.println(c.getName());
//		}
		if(list.size()==0){
			//System.out.println("后台调用方法:"+list.size());
			model.addAttribute("Message","1" );
			return "error/404";
		}
		model.addAttribute("categoryList",list );
		return "modules/cms/cmsTree";
	}
	
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "none")
	public String none() {
		return "modules/cms/cmsNone";
	}
	//add hefeng
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "index2")
	public String index2(HttpServletRequest request ,HttpServletResponse response) {
		return "modules/cms/cmsIndex2";
	}
	
	//add by luqibao
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "tree2")
	public String tree2(Model model) {
		model.addAttribute("categoryList", categoryService.findByUser(true, null,BaseService.CATEGORY_PLACE_SYS));
		return "modules/cms/cmsTree2";
	}
	
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "none2")
	public String none2() {
		return "modules/cms/cmsNone2";
	}
	//end
	//add by luqibao
	@RequestMapping(value="f")
	public String frontIndex(RedirectAttributes ra){
		UserUtils.putCache(IS_LOGIN, "1");
		return "redirect:/f";
	}
	@RequestMapping("classifyList")
	public String classifyList(){
		return "modules/cms/cmsClassifyList";
	}
	
	/**
	 * 
	 * 标签管理的controller
	 * 
	 */
	@RequestMapping(value="tagControl")
	public String tagControl(@ModelAttribute("label")Label label,Model model,HttpServletRequest request, HttpServletResponse response){
		//add by yangshw6
		//System.out.println("---------tagControl------------");
//		List<Label> LabelData=new ArrayList<Label>();
//		LabelData=labelservice.getLabelCountData();
//		for(int i=0;i<LabelData.size();i++){
//			System.out.println("用户标签为:"+LabelData.get(i).getId()+"--"+LabelData.get(i).getLabelvalue()+"--"+LabelData.get(i).getLabelcontent());
//		}
//		model.addAttribute("labeldata",LabelData);
		if(label==null)
			label=new Label();
		Page<Label> page = labelservice.findPage(new Page<Label>(request, response), label); 
        model.addAttribute("page", page);
		model.addAttribute("tagflag","1");
		//end by yangshw6
		return "modules/sys/tagControl";
	}
	@RequestMapping("addTag")
	public String addTag(String id,String tagflag,Model model){
		//System.out.println("addTag");
		Label label=new Label();
		label=labelservice.get(id);
		if(tagflag==null)
			tagflag="1";
		//System.out.println("tagflag:"+tagflag);
		model.addAttribute("label",label);
		model.addAttribute("tagflag",tagflag);
		return "modules/sys/addTag";
	}
	//add by yangshw6
	@RequestMapping("deleteTag")
	public String deleteTag(String id,String delFlag,String flag,RedirectAttributes redirectAttributes){
		//System.out.println("----------deleteTag-----------");
		Label label=new Label();
		label.setId(id);
		labelservice.delete(label);
		//System.out.println("deleteTag:delFlag"+delFlag);
		if(flag.equals("0")){
			return "redirect:"+adminPath+"/sys/user/userTag?delFlag="+delFlag;
		}
		return "redirect:"+adminPath+"/cms/tagControl?delFlag="+delFlag;
	}
	//end by yangshw6
	
	//管理员增加标签,不需要审核
	@RequestMapping(value="save",method=RequestMethod.POST)
	public String save(Label label,RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response){
		//System.out.println("保存标签");
		System.out.println("label"+JsonMapper.toJsonString(label));
		//add by yangshw6																	
		if(label.getId().equals("")){
			if(label.getLabelvalue().equals("")){
				//System.out.println("label...空"+label.getLabelvalue());
				addMessage(redirectAttributes, "信息错误，请重新填写");
				return "redirect:"+adminPath+"/cms/addTag";
			}else{
				//System.out.println("size:"+label.getLabelvalue().length());
				if(label.getLabelvalue().length()>=5){
					addMessage(redirectAttributes, "增加的标签限制在4个字符内");
					return "redirect:"+adminPath+"/cms/addTag";
				}
				boolean flag=labelservice.findRepeatLabelName(label.getLabelvalue());
				//System.out.println("标签名为:"+label.getLabelvalue());
				if(flag){
					addMessage(redirectAttributes, "标签名已被现有的标签所使用,请重新填写");
					return "redirect:"+adminPath+"/cms/addTag";
				}
				//System.out.println("label...插入"+label.getLabelvalue());
				label.setDelFlag("0");
				label.setUserid(UserUtils.getUser().getId());
				labelservice.insert(label);
				addMessage(redirectAttributes, "保存成功");
				return "redirect:"+adminPath+"/cms/tagControl";
			}
		}else{
			//System.out.println("size:"+label.getLabelvalue().length());
			if(label.getLabelvalue().length()>=5){
				addMessage(redirectAttributes, "增加的标签限制在4个字符内");
				return "redirect:"+adminPath+"/cms/addTag";
			}
			boolean flag=labelservice.findRepeatLabelName(label.getLabelvalue());
			//System.out.println("标签名为:"+label.getLabelvalue());
			if(flag){
				addMessage(redirectAttributes, "标签名已被现有的标签所使用,请重新填写");
				return "redirect:"+adminPath+"/cms/addTag";
			}
			//System.out.println("label...更新"+label.getLabelvalue());
			labelservice.update(label);
			addMessage(redirectAttributes, "更新成功");
			return "redirect:"+adminPath+"/cms/tagControl";
			}
		}
		//end by yangshw6
	//在上传知识的界面保存用户自己增加的标签,但是未审核
	@ResponseBody
	@RequestMapping(value="saveUnexamineLabel",method=RequestMethod.POST)
	public String saveUnexamineLabel(String labelflag,Label label,RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response){
//			System.out.println("saveUnexamineLabel");
//			System.out.println("labelflag"+labelflag);
//			System.out.println("label"+JsonMapper.toJsonString(label));
			if(label.getLabelvalue().equals("")){
				//System.out.println("label...空"+label.getLabelvalue());
				return "1";
			}else{
				if(label.getLabelvalue().length()>4){
					return "3";
				}
				boolean flag=labelservice.findRepeatLabelName(label.getLabelvalue());
				//System.out.println("标签名为:"+label.getLabelvalue());
				if(flag){
					return "2";
				}
				//System.out.println("label...插入"+label.getLabelvalue());
				if(UserUtils.findSysRole()){
					label.setDelFlag("0");
				}else{
					label.setDelFlag("1");
				}
				label.setUserid(UserUtils.getUser().getId());
				labelservice.insert(label);
				return "0";
			}
		
		//end by yangshw6
		}
	//审核标签，0为通过，1为不通过
	@RequestMapping(value="pass",method=RequestMethod.GET)
	public String pass(Label label,RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response){
		//System.out.println("----pass----");
		//System.out.println("tagflag:"+label.getDelFlag());
		//System.out.println("id:"+label.getId());
		if(label==null){
			return "modules/sys/tagControl?delFlag="+label.getDelFlag();
		}
		if(label.getDelFlag().equals("0")){
			labelservice.update(label);
			addMessage(redirectAttributes, "成功修改!审批通过");
			//add hefeng
			Label labelmsg=new Label();
			labelmsg=labelservice.get(label.getId());
			//oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(labelmsg));
			//end
			if(label.getIschecked()==1){
				return "redirect:"+adminPath+"/cms/tagControl?delFlag=1";
			}else{
				return "redirect:"+adminPath+"/cms/tagControl?delFlag=2";
			}
		}else if(label.getDelFlag().equals("2")){
			labelservice.update(label);
			addMessage(redirectAttributes, "成功修改!审批不通过");
			//add hefeng
			Label labelmsg=new Label();
			labelmsg=labelservice.get(label.getId());
			//oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(labelmsg));
			//end
			return "redirect:"+adminPath+"/cms/tagControl?delFlag=1";
		}else{
			labelservice.update(label);
			addMessage(redirectAttributes, "成功弃审");
			return "redirect:"+adminPath+"/cms/tagControl?delFlag="+label.getDelFlag();
		}
	}
	
	
	@RequestMapping(value = "frontswitch")
	public String frontswitch(HttpServletRequest request, HttpServletResponse response, Model model) {
		//在构造方法中设置分页大小new Page<Article>(request, response,10),第三个参数
		List<Switch> frontswitch=Lists.newArrayList();
		frontswitch=switchService.getAll();
		//System.out.println("首页轮播");
		model.addAttribute("frontswitch", frontswitch);
		//System.out.println("frontswitch"+JsonMapper.toJsonString(frontswitch));
		return "modules/sys/frontswitch";
	}
	//增加和修改轮播
	@RequestMapping(value = "frontswitchmodify")
	public String frontswitchmodify(String id, Model model) {
		//得到id.通过id,查询出对应的switch vo 返回去
		Switch switch_modify =new Switch();
		switch_modify=switchService.getByID(id);
		model.addAttribute("switch_modify", switch_modify);
		//System.out.println("switch_modify===="+JsonMapper.toJsonString(switch_modify));
		return "modules/sys/frontswitch_modify";
	}
	
	//保存轮播图的设置
	@RequestMapping(value = "frontswitchsave",method=RequestMethod.POST)
	public String frontswitchsave(Switch switch_save,RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response, Model model) {
		//得到id.通过id,查询出对应的switch vo 返回去
		//System.out.println("switch_save===="+JsonMapper.toJsonString(switch_save));
		System.out.println("switch_save===="+JsonMapper.toJsonString(switch_save));
		switchService.update(switch_save);
		addMessage(redirectAttributes, "修改成功");
		return "redirect:"+adminPath+"/cms/frontswitch";
	}
	//禁用和启用某张图
	@RequestMapping(value = "frontswitchdisabled")
	public String frontswitchdisabled(String id,String delFlag,RedirectAttributes redirectAttributes,Model model){
		//delFlag等于0表示已经是启用状态,1表示已经是禁用状态
		//System.out.println("//禁用和启用某张图"+"id=="+id+"  delFlag=="+delFlag);
		Switch switch_abled =new Switch();
		switch_abled=switchService.getByID(id);
		if(delFlag.equals("0")){
			switch_abled.setDelFlag("1");
			//System.out.println("switch_abled===="+JsonMapper.toJsonString(switch_abled.getDelFlag()));
		}
		else{
			switch_abled.setDelFlag("0");
			//System.out.println("switch_abled===="+JsonMapper.toJsonString(switch_abled.getDelFlag()));
		}
		switchService.update(switch_abled);
		addMessage(redirectAttributes, "修改成功");
		return "redirect:"+adminPath+"/cms/frontswitch";
	}
	@RequestMapping(value = "mergeTaglist")
	public String mergeTaglist(Label label,RedirectAttributes redirectAttributes,Model model){
		System.out.println("labelid="+label.getId());
		List<Label> labellist=labelservice.findUnMergeLabel(label.getId());
		if(labellist==null || labellist.size()==0){
			return "modules/sys/mergeTag";
		}
		model.addAttribute("labellist",labellist);
		return "modules/sys/mergeTag";
	}
	@ResponseBody
	@RequestMapping(value="mergeTag",method=RequestMethod.POST)
	public String mergeTag(String firstlabelid,String secondlabelid,String newname,RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response){
		System.out.println("firstlabelid"+firstlabelid+"-"+secondlabelid+"-"+newname);
		if(labelservice.findRepeatLabelByMerge(newname,secondlabelid)){
			return "1";
		}
		if(secondlabelid==null){
			return "2";
		}
		labelservice.MergeLabel(firstlabelid, secondlabelid, newname);
		return "0";
	}
}
	//end

