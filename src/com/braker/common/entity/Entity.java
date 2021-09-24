package com.braker.common.entity;

import java.io.Serializable;

public interface Entity extends Serializable {
    
    public String getId();
    
    public void setId(String id);
}
