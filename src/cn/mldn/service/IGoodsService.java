package cn.mldn.service;


import java.util.Map;
import java.util.Set;

import cn.mldn.vo.Goods;

public interface IGoodsService {
	public Map<String ,Object> getAddPre()throws Exception ;
	public boolean add(Goods vo,Set<Integer> tids)throws Exception ;
	public Map<String ,Object> list(int currentPage,int lineSize,String column,String keyword)throws Exception ;
	public Map<String ,Object> getEditPre(int gid) throws  Exception ;
	public boolean edit(Goods vo,Set<Integer> tids)throws Exception ;
	public boolean delete(Set<Integer> ids)throws Exception ;
}
