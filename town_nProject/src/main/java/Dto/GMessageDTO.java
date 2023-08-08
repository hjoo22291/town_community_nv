package Dto;

import org.springframework.stereotype.Component;

@Component
public class GMessageDTO {
	int gmessage_id;
	String gmessage_content, gmessage_sendAt;
	int g_isread;
	String member_id;
	int gchat_id;
	public int getGmessage_id() {
		return gmessage_id;
	}
	public void setGmessage_id(int gmessage_id) {
		this.gmessage_id = gmessage_id;
	}
	public String getGmessage_content() {
		return gmessage_content;
	}
	public void setGmessage_content(String gmessage_content) {
		this.gmessage_content = gmessage_content;
	}
	public String getGmessage_sendAt() {
		return gmessage_sendAt;
	}
	public void setGmessage_sendAt(String gmessage_sendAt) {
		this.gmessage_sendAt = gmessage_sendAt;
	}
	public int getG_isread() {
		return g_isread;
	}
	public void setG_isread(int g_isread) {
		this.g_isread = g_isread;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getGchat_id() {
		return gchat_id;
	}
	public void setGchat_id(int gchat_id) {
		this.gchat_id = gchat_id;
	}
	
	
}
