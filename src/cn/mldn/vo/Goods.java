package cn.mldn.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Goods implements Serializable {
	private Integer gid ;
	private String name ;
	private Double price ;
	private String photo ;
	private Integer iid ;
	public Integer getGid() {
		return gid;
	}
	public void setGid(Integer gid) {
		this.gid = gid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public Integer getIid() {
		return iid;
	}
	public void setIid(Integer iid) {
		this.iid = iid;
	}
	@Override
	public String toString() {
		return "Goods [gid=" + gid + ", name=" + name + ", price=" + price + ", photo=" + photo + ", iid=" + iid + "]";
	}
	
}
