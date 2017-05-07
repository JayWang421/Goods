package cn.mldn.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Tag implements Serializable {
	private Integer tid ;
	private String title ;
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}	
