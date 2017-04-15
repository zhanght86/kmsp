package com.yonyou.kms.modules.pub.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yonyou.kms.common.service.CrudService;
import com.yonyou.kms.modules.pub.dao.EnterpriseDao;
import com.yonyou.kms.modules.pub.dao.TenantDao;
import com.yonyou.kms.modules.pub.entity.Enterprise;
import com.yonyou.kms.modules.pub.entity.Tenant;
@Service
@Transactional(readOnly = false)
public class TenantService extends CrudService<TenantDao, Tenant>{

}
