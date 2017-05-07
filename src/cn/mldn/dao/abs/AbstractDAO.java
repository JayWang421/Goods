package cn.mldn.dao.abs;

import java.sql.Connection;
import java.sql.PreparedStatement;

import cn.mldn.util.dbc.DatabaseConnection;

public abstract class AbstractDAO {
	protected PreparedStatement ps ;
	protected Connection conn ;
	public AbstractDAO() {
		this.conn=DatabaseConnection.getConnection() ;
	}
}
