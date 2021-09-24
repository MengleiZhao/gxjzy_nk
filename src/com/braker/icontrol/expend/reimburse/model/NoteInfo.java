package com.braker.icontrol.expend.reimburse.model;


/**
 * 接收app传过来的发票各种信息的model
 * @author 沈帆
 * @createtime 2020-07-03
 * @updatetime 2020-07-03
 */
public class NoteInfo   {
	
	// 发票代码
    public String code;
    // 发票总金额
    public String total_money;
    // 备注
    public String mark;
    // 发票Base64图片
    public String img_base64;
    // 发票号码
    public String number;
    // 校验码后6位(专票、机动车票、二手车票可为空，普票不为空)
    public String check_code;
    // 金额 专票(税前金额)、机动车票(税前金额)、二手车票(总价)不为空，普票可为空
    public String pretax_amount;
    // 开票日期
    public String date;
    // 发票类型
    public String type;
    
    
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getTotal_money() {
		return total_money;
	}
	public void setTotal_money(String total_money) {
		this.total_money = total_money;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public String getImg_base64() {
		return img_base64;
	}
	public void setImg_base64(String img_base64) {
		this.img_base64 = img_base64;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getCheck_code() {
		return check_code;
	}
	public void setCheck_code(String check_code) {
		this.check_code = check_code;
	}
	public String getPretax_amount() {
		return pretax_amount;
	}
	public void setPretax_amount(String pretax_amount) {
		this.pretax_amount = pretax_amount;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	

	
	
}
