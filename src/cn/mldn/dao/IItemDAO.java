package cn.mldn.dao;

import java.sql.SQLException;
import java.util.Map;

import cn.mldn.util.dao.IBaseDAO;
import cn.mldn.vo.Item;

public interface IItemDAO extends IBaseDAO<Integer, Item> {
	public  Map<Integer ,String > findAllForMap()throws SQLException ;
}
