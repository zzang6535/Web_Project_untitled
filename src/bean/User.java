package bean;

public class User implements java.io.Serializable {
	private static final long serialVersionUID = 2193897931951333123L;

	private int idx;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String tel;
	private String gender;
	private String join_type;
	private String adm;
		
	public String getAdm() {
		return adm;
	}
	public void setAdm(String adm) {
		this.adm = adm;
	}
	// No-arg constructor 가 있어야 한다.
	public User() {
	}
	public User(int idx, String join_type, String id, String pw, String name, String email,
			String tel, String gender) {
		super();
		this.idx = idx;
		this.join_type = join_type;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.email = email;
		this.tel = tel;
		this.gender = gender;
	}
	public User(int idx, String join_type, String id, String pw, String name, String email,
			String tel, String gender, String adm) {
		super();
		this.idx = idx;
		this.join_type = join_type;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.email = email;
		this.tel = tel;
		this.gender = gender;
		this.adm = adm;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getJoin_type() {
		return join_type;
	}
	public void setJoin_type(String join_type) {
		this.join_type = join_type;
	}
	
	
}
