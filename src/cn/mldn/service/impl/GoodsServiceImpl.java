package cn.mldn.service.impl;


import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import cn.mldn.dao.IGoodsDAO;
import cn.mldn.dao.IItemDAO;
import cn.mldn.dao.ITagDAO;
import cn.mldn.service.IGoodsService;
import cn.mldn.service.abs.AbstractService;
import cn.mldn.util.factory.Factory;
import cn.mldn.vo.Goods;


public class GoodsServiceImpl extends AbstractService implements IGoodsService {
	@Override
	public Map<String, Object> list(int currentPage, int lineSize, String column, String keyWord)
			throws Exception {
		Map<String ,Object> map=new HashMap<String,Object>() ;
		IItemDAO itemDao=Factory.getDAOInstance("item.dao") ;
		map.put("allItems", itemDao.findAllForMap()) ;
		IGoodsDAO goodsDao=Factory.getDAOInstance("goods.dao") ;
		if(column==null || keyWord==null || "".equals(keyWord) || "".equals(column)){
			map.put("allGoodss", goodsDao.findAllSplit(currentPage, lineSize)) ;
			map.put("goodsCount", goodsDao.getAllCount()) ;
		}else{
			map.put("allGoodss", goodsDao.findAllSplit(currentPage, lineSize,column,keyWord)) ;
			map.put("goodsCount", goodsDao.getAllCount(column,keyWord)) ;
		}
		return map ;
	}
	@Override
	public Map<String, Object> getAddPre() throws Exception {
		IItemDAO itemDao=Factory.getDAOInstance("item.dao") ;
		ITagDAO tagDao=Factory.getDAOInstance("tag.dao") ;
		Map<String,Object> map=new HashMap<String ,Object>() ;
		map.put("allItems", itemDao.findAll()) ;
		map.put("allTags", tagDao.findAll()) ;
		return map ;
	}

	@Override
	public boolean add(Goods vo, Set<Integer> tids) throws Exception {
		if(vo.getIid()==null || vo.getIid().equals(0) || vo.getPrice()<=0 || vo.getPhoto()==null || "".equals(vo.getPhoto())){
			return false ; 
		}
		IGoodsDAO goodsDao=Factory.getDAOInstance("goods.dao") ;
		if(goodsDao.findByName(vo.getName())==null){
			if(goodsDao.doCreate(vo)){
				Integer gid=goodsDao.findCreateId() ;
				ITagDAO tagDao=Factory.getDAOInstance("tag.dao") ;
				tagDao.doCreateGoodsAndTag(gid, tids) ;
				return true ;
			}
		}
		return false ;
	}
	@Override
	public Map<String, Object> getEditPre(int gid) throws Exception {
		IItemDAO itemDao=Factory.getDAOInstance("item.dao") ;
		ITagDAO tagDao=Factory.getDAOInstance("tag.dao") ;
		IGoodsDAO goodsDao=Factory.getDAOInstance("goods.dao") ;
		Map<String,Object> map=new HashMap<String ,Object>() ;
		map.put("allItems", itemDao.findAll()) ;
		map.put("allTags", tagDao.findAll()) ;
		map.put("goods", goodsDao.findById(gid)) ;
		map.put("goodsTag", tagDao.findAllByGoods(gid)) ;
		return map ;
	}
	
	@Override
	public boolean edit(Goods vo, Set<Integer> tids) throws Exception {
		if(vo.getIid()==null || vo.getIid().equals(0) || vo.getPrice()<=0){
			return false ; 
		}
		IGoodsDAO goodsDao=Factory.getDAOInstance("goods.dao") ;
		Goods nameGoods=goodsDao.findByName(vo.getName()) ;
		if(nameGoods==null || vo.getGid().equals(nameGoods.getGid())){
			if(goodsDao.doUpdate(vo)){
				ITagDAO tagDao=Factory.getDAOInstance("tag.dao") ;
				tagDao.doRemoveGoodsAndTag(vo.getGid()) ;
				tagDao.doCreateGoodsAndTag(vo.getGid(), tids) ;
				return true ;
			}
		}
		return false ;
	}
	@Override
	public boolean delete(Set<Integer> ids) throws Exception {
		if(ids==null || ids.size()==0){
			return false ;
		}
		IGoodsDAO goodsDao=Factory.getDAOInstance("goods.dao") ;
		return goodsDao.doRemoveBatch(ids) ;
	}
}
