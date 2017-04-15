package nc.vo.kms.entityN;

import java.io.Serializable;
import java.util.List;

public class OuterSystemRetVO implements Serializable{

	private static final long serialVersionUID = 1L;

	private String data;
	

	private boolean success;
	

	private String dataState;

	private String errorMsg;
	
	
	private String maxTs;

	public String getMaxTs() {
		return maxTs;
	}

	public void setMaxTs(String maxTs) {
		this.maxTs = maxTs;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getDataState() {
		return dataState;
	}

	public void setDataState(String dataState) {
		this.dataState = dataState;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
}
