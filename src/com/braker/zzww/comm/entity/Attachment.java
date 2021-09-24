package com.braker.zzww.comm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.braker.common.entity.GenericEntityNow;

@Entity
@Table(name = "T_ATTACHMENT")
public class Attachment extends GenericEntityNow implements Serializable{
	private static final long serialVersionUID = 8338410524496174123L;

	@Column(name="ENTRY_ID")
	private String entryId;
	
	@Column(name="JOIN_TABLE")
	private String joinTable;
	
	@Column(name="FILE_NAME")
	private String fileName;
	
	@Column(name="ORIGINAL_NAME")
	private String originalName;
	
	@Column(name="FILE_URL")
	private String fileUrl;
	
	@Column(name="FILE_TYPE")
	private String fileType;
	
	@Column(name="FILE_SIZE")
	private String fileSize;
	
	@Column(name="SERVICE_TYPE")
	private String serviceType;
	
	@Column(name="COMMITED")
	private String commited;
	
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getEntryId() {
		return entryId;
	}
	public void setEntryId(String entryId) {
		this.entryId = entryId;
	}
	public String getJoinTable() {
		return joinTable;
	}
	public void setJoinTable(String joinTable) {
		this.joinTable = joinTable;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getCommited() {
		return commited;
	}
	public void setCommited(String commited) {
		this.commited = commited;
	}
	
}
