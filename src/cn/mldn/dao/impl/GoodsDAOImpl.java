package cn.mldn.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.Iterator;
import java.util.List;

import java.util.Set;

import cn.mldn.dao.IGoodsDAO;

import cn.mldn.dao.abs.AbstractDAO;

import cn.mldn.vo.Goods;

public class GoodsDAOImpl extends AbstractDAO implements IGoodsDAO {
	
	@Override
	public Goods findByName(String name) throws SQLException {
		Goods vo=null ;
		String sql="select gid,name,price,photo,iid from goods where name=? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setString(1, name);
		ResultSet rs=super.ps.executeQuery() ;
		if(rs.next()){
			vo=new Goods() ;
			vo.setGid(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setPrice(rs.getDouble(3));
			vo.setPhoto(rs.getString(4));
			vo.setIid(rs.getInt(5));
		}
		return vo ;
	}
	
	@Override
	public boolean doCreate(Goods vo) throws SQLException {
		String sql="insert into goods(gid,name,price,photo,iid) values (goods_seq.nextval,?,?,?,?) " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setString(1, vo.getName());
		super.ps.setDouble(2, vo.getPrice());
		super.ps.setString(3, vo.getPhoto());
		super.ps.setInt(4, vo.getIid());
		return super.ps.executeUpdate() > 0 ;
	}
	
	@Override
	public Integer findCreateId() throws SQLException {
		String sql="select goods_seq.currval from dual " ;
		super.ps=super.conn.prepareStatement(sql) ;
		ResultSet rs=super.ps.executeQuery() ;
		if(rs.next()){
			return rs.getInt(1) ;
		}
		return 0 ;
	}
	
	
	
	@Override
	public boolean doUpdate(Goods vo) throws SQLException {
		String sql="update goods set name=?,price=?,photo=? where gid=? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setString(1, vo.getName());
		super.ps.setDouble(2, vo.getPrice());
		super.ps.setString(3, vo.getPhoto());
		super.ps.setInt(4, vo.getGid());
		return super.ps.executeUpdate() > 0 ;
	}

	@Override
	public boolean doRemoveBatch(Set<Integer> ids) throws SQLException {
		StringBuffer buf=new StringBuffer() ;
		buf.append("delete from goods where gid in ( ") ;
		Iterator<Integer> iter=ids.iterator() ;
		while(iter.hasNext()){
			buf.append(iter.next()).append(",") ;
		}
		buf.delete(buf.length()-1, buf.length()).append(")") ;
		super.ps=super.conn.prepareStatement(buf.toString()) ;
		return super.ps.executeUpdate() > 0 ;
	}
	
	@Override
	public boolean doRemove(Integer id) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Goods findById(Integer id) throws SQLException {
		Goods vo=null ;
		String sql=" select gid,name,price,photo,iid from goods where gid=? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setInt(1, id);
		ResultSet rs=super.ps.executeQuery() ;
		if(rs.next()){
			vo=new Goods() ;
			vo.setGid(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setPrice(rs.getDouble(3));
			vo.setPhoto(rs.getString(4));
			vo.setIid(rs.getInt(5));
		}
		return vo ;
	}

	@Override
	public List<Goods> findAll() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Goods> findAllSplit(Integer currentPage, Integer lineSize) throws SQLException {
		List<Goods> all=new ArrayList<Goods>() ;
		Goods vo=null ;
		String sql="select * from "
				+ " (select gid,name,price,photo,iid,rownum rn from goods where rownum<=? ) temp "
				+ " where temp.rn>? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setInt(1, currentPage*lineSize);
		super.ps.setInt(2, (currentPage-1)*lineSize);
		ResultSet rs=super.ps.executeQuery() ;
		while(rs.next()){
			vo=new Goods() ;
			vo.setGid(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setPrice(rs.getDouble(3));
			vo.setPhoto(rs.getString(4));
			vo.setIid(rs.getInt(5));
			all.add(vo) ;
		}
		return all ;
	}

	@Override
	public List<Goods> findAllSplit(Integer currentPage, Integer lineSize, String column, String keyWord)
			throws SQLException {
		List<Goods> all=new ArrayList<Goods>() ;
		Goods vo=null ;
		String sql="select * from  "
				+ " (select gid,name,price,photo,iid,rownum rn from goods where "+column+" like ? and rownum<=? )temp  "
				+ " where temp.rn>=? " ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setString(1, "%"+keyWord+"%");
		super.ps.setInt(2, currentPage*lineSize);
		super.ps.setInt(3, (currentPage-1)*lineSize);
		ResultSet rs=super.ps.executeQuery() ;
		while(rs.next()){
			vo=new Goods() ;
			vo.setGid(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setPrice(rs.getDouble(3));
			vo.setPhoto(rs.getString(4));
			vo.setIid(rs.getInt(5));
			all.add(vo) ;
		}
		return all ;
	}

	@Override
	public Integer getAllCount() throws SQLException {
		String sql="select count(*) from goods " ;
		super.ps=super.conn.prepareStatement(sql) ;
		ResultSet rs=super.ps.executeQuery() ;
		if(rs.next()){
			return rs.getInt(1) ;
		}
		return 0 ;
	}

	@Override
	public Integer getAllCount(String column, String keyWord) throws SQLException {
		String sql="select count(*) from goods where "+column+" like ?" ;
		super.ps=super.conn.prepareStatement(sql) ;
		super.ps.setString(1, "%"+keyWord+"%");
		ResultSet rs=super.ps.executeQuery() ;
		if(rs.next()){
			return rs.getInt(1) ;
		}
		return 0 ;
	}

}
