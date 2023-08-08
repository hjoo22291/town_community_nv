package Dto;

import java.sql.Date;

public class AdminDto {

    private String memberId;
    private String name;
    private String phone;
    private String email;
    private String password;
    private Date signupDate;
    private Date deleteDate;
    private Integer stopDate;
    private Date stopclearDate;
    private String address;
    private Integer reportCount;
    private String role;
    private Integer townId;
    private Integer point;
    private String profileImage;
    private Integer inviteSum;
//



  
    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public Integer getStopDate() {
        return stopDate;
    }

    public void setStopDate(Integer stopDate) {
        this.stopDate = stopDate;
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }
}