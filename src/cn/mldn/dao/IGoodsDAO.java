package cn.mldn.dao;

import java.sql.SQLException;
import java.util.Map;

import cn.mldn.util.dao.IBaseDAO;
import cn.mldn.vo.Goods;

public interface IGoodsDAO extends IBaseDAO<Integer, Goods> {
	public Goods findByName(String name)throws SQLException ;
	public Integer findCreateId()throws SQLException ;
}
