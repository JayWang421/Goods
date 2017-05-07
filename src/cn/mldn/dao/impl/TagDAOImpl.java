package cn.mldn.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import cn.mldn.dao.ITagDAO;
import cn.mldn.dao.abs.AbstractDAO;
import cn.mldn.vo.Tag;

public class TagDAOImpl extends AbstractDAO implements ITagDAO {
	
	@Override
	public Set<Integer> findAllByGoods(Integer gid) throws SQLException {
		Set<Integer> set=new HashSet<Integer>() ;
		String sql=" select tid from goods_tag where gid=? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setInt(1, gid);
		ResultSet rs=super.ps.executeQuery() ;
		while(rs.next()){
			set.add(rs.getInt(1)) ;
		}
		return set ;
	}
	
	@Override
	public boolean doCreateGoodsAndTag(Integer gid, Set<Integer> tids) throws SQLException {
		String sql="insert into goods_tag(gid,tid) values(?,?) "  ;
		super.ps=super.conn.prepareStatement(sql) ;
		Iterator<Integer> iter=tids.iterator() ;
		while(iter.hasNext()){
			super.ps.setInt(1, gid);
			super.ps.setInt(2, iter.next());
			super.ps.addBatch();
		}
		super.ps.executeBatch() ;
		return true ;
	}
	
	@Override
	public boolean doRemoveGoodsAndTag(Integer gid) throws SQLException {
		String sql="delete from goods_tag where gid=? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setInt(1, gid);
		return super.ps.executeUpdate()>0 ;
	}

	@Override
	public boolean doCreate(Tag vo) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doUpdate(Tag vo) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doRemove(Integer id) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Tag findById(Integer id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Tag> findAll() throws SQLException {
		List<Tag> all=new ArrayList<Tag>() ;
		String sql="select tid,title from tag " ;
		super.ps=super.conn.prepareStatement(sql) ;
		ResultSet rs=super.ps.executeQuery() ;
		while(rs.next()){
			Tag vo=new Tag() ;
			vo.setTid(rs.getInt(1));
			vo.setTitle(rs.getString(2));
			all.add(vo) ;
		}
		return all ;
	}

	@Override
	public List<Tag> findAllSplit(Integer currentPage, Integer lineSize) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Tag> findAllSplit(Integer currentPage, Integer lineSize, String column, String keyWord)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getAllCount() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getAllCount(String column, String keyWord) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public boolean doRemoveBatch(Set<Integer> ids) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}
}
