package com.braker.common.security;

import java.io.File;

/**
 * <code>FileResourceListener</code>
 */

public interface FileListener
{
	/**
	 * 文件已修改.
	 * 
	 * @param file 发生修改的文件句柄.
	 */
	void fileChanged(File file);
}
