(function($){
    function getRows(target){
        var state = $(target).data('datagrid');
        if (state.filterSource){
            return state.filterSource.rows;
        } else {
            return state.data.rows;
        }
    }
    function toHtml(target, rows){
        rows = rows || getRows(target);
        var dg = $(target);
        var data = ['<table border="1" rull="all" style="border-collapse:collapse">'];
        var fields = dg.datagrid('getColumnFields',true).concat(dg.datagrid('getColumnFields',false));
        var trStyle = 'height:32px';
        var tdStyle0 = 'vertical-align:middle;padding:0 4px';
        
        if(target.id=='data_analysis'){	//table数据表格的Id
        	data.push(	
        			'<tr style="height:50px;">'
        				+'<th colspan="'+fields.length+'" style="height:50px;font-weight:bold;vertical-align:middle;font-size:19px;text-align:left;">报表一</th>'
        			+'</tr>');	//增加表头
        	//-------------报表一标题表头------begin
        	var titleTr = dg[0].rows;
        	
    		var titleTd=titleTr[2].cells;	//前四列：序号~合计;（固定）
    		data.push('<tr style="'+trStyle+'">');
    		for(var i=0; i<titleTd.length; i++){
            	var t=titleTd[i].innerText;
                var col = dg.datagrid('getColumnOption', fields[i]);
                var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
                //隐藏空列
        		/*if(col.title===undefined) {
        			continue;
        		}*/
               	//第一行合并前4列
                data.push('<th rowspan="2" style="'+tdStyle+'">'+t+'</th>');
                
            }
    		
    		for(var y=0; y<2; y++){	//基本工资编码和名称 两行
        		titleTd=titleTr[y].cells;	//合计后面的列	（动态）
        		if(y==1){ //基本工资....名称
        			data.push('<tr style="'+trStyle+'">');	
        		}
                for(var i=0; i<titleTd.length; i++){
                	var t=titleTd[i].innerText;
                    var col = dg.datagrid('getColumnOption', fields[i]);
                    var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
                	data.push('<th style="'+tdStyle+'">'+t+'</th>');
                }
                data.push('</tr>');
    		}
           /*-------------报表一标题表头------end-----------*/
    		
        }else if(target.id=='report_forms'){
    		/*--------------报表二表头------begin-----------*/
        	data.push(	
        			'<tr style="height:50px;">'
        				+'<th colspan="'+fields.length+'" style="height:50px;font-weight:bold;vertical-align:middle;font-size:19px;text-align:left;">报表二 </th>'
        			+'</tr>');	//增加表头
        	
        	var titleTr = dg[0].rows;
        	var titleTd=titleTr[2].cells;	//前5列：类型~项目总额;（固定）
    		data.push('<tr style="'+trStyle+'">');
    		for(var i=0; i<titleTd.length; i++){
            	var t=titleTd[i].innerText;
                var col = dg.datagrid('getColumnOption', fields[i]);
                var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
               	//第一行合并前5列
                if(i==0){
                	//项目类型
                	data.push('<th colspan="2" style="'+tdStyle+'">'+t+'</th>');
                }else{
                	if(i==1){
                		data.push('<th rowspan="2" style="'+tdStyle0 + ';width:'+col.boxWidth*2+'px'+'">'+t+'</th>');
                	}else{
                		data.push('<th rowspan="2" style="'+tdStyle+'">'+t+'</th>');
                	}
                }
            }
    		for(var y=0; y<2; y++){	//基本工资编码和名称 两行
        		titleTd=titleTr[y].cells;	//合计后面的列	（动态）
        		if(y==1){ //基本工资....名称
        			data.push('<tr style="'+trStyle+'">');
        			var tTd=titleTr[3].cells;	//项目类型  两列
        			for(var i=0; i<tTd.length; i++){
                    	var t=tTd[i].innerText;
                        var col = dg.datagrid('getColumnOption', fields[i]);
                        var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
                    	data.push('<th style="'+tdStyle+'">'+t+'</th>');
                    }
        		}
                for(var i=0; i<titleTd.length; i++){
                	var t=titleTd[i].innerText;
                    var col = dg.datagrid('getColumnOption', fields[i]);
                    var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
                	data.push('<th style="'+tdStyle+'">'+t+'</th>');
                }
                data.push('</tr>');
    		}
        	/*--------------报表二表头------end-----------*/
        
        } else if(target.id=='report_collect_three'){
        	/*--------------报表3表头------begin-----------*/ 
        	data.push(	
        			'<tr style="height:50px;">'
        				+'<th colspan="'+fields.length+'" style="height:50px;font-weight:bold;vertical-align:middle;font-size:19px;text-align:left;">报表三</th>'
        			+'</tr>');	//增加表头
    		var titleTr = dg[0].rows;
    		var titleTd=titleTr[0].cells;	//前四列：序号~合计;（固定）
    		data.push('<tr style="'+trStyle+'">');
    		for(var i=0; i<titleTd.length; i++){
            	var t=titleTd[i].innerText;
                var col = dg.datagrid('getColumnOption', fields[i]);
                var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
               	//第一行合并前4列
                if(i==2|| i==3){
                	data.push('<th colspan="3" style="'+tdStyle+'">'+t+'</th>');
                }else{
                	data.push('<th rowspan="2" style="'+tdStyle+'">'+t+'</th>');
                }
            }
    		data.push('</tr>');
    		titleTds=titleTr[1].cells;	//
    			data.push('<tr style="'+trStyle+'">');	
    			for(var y=0; y<titleTds.length; y++){
    				var tt=titleTds[y].innerText;
    				var cols = dg.datagrid('getColumnOption', fields[y]);
    				var tdStyles = tdStyle0 + ';width:'+cols.boxWidth+'px;';
    				data.push('<th style="'+tdStyles+'">'+tt+'</th>');
    			}
    			data.push('</tr>');
        	/*--------------报表3表头------end-----------*/ 
        } else{
        	/*-------------默认标题表头------begin---------*/
            data.push('<tr style="'+trStyle+'">');
            for(var i=0; i<fields.length; i++){
                var col = dg.datagrid('getColumnOption', fields[i]);
                var tdStyle = tdStyle0 + ';width:'+col.boxWidth+'px;';
                //隐藏空列
        		if(col.title===undefined) {
        			continue;
        		}
                data.push('<th style="'+tdStyle+'">'+col.title+'</th>');
            }
            data.push('</tr>');
           //-------------默认标题表头------end
        }
        
        //---------------报表一报表行数据导出-------begin------
        if(target.id=='data_analysis'|| target.id=='report_collect_three'){
        	var indexRow=0;	//多少行
        	$.map(rows, function(row){
        		//第一行样式
        		if(indexRow==0){
        			data.push('<tr style="'+trStyle+';color:black;background-color:#D8D8D8;font-weight:bold;">');
        		}else{
        			data.push('<tr style="'+trStyle+'">');
        		}
                for(var i=0; i<fields.length; i++){
                    //隐藏空列
                    var col = dg.datagrid('getColumnOption', fields[i]);
                    if(col.title===undefined) {
                        continue;
                    }
                    var field = fields[i];
                    if(field==3){
                    	//合计列
                    	if(row[field]=='' || row[field]==null || row[field]==0){
                    		data.push('<td style="'+tdStyle0+';color:black;background-color:#D8D8D8;font-weight:bold;"></td>');
                    	}else{
                    		data.push('<td style="'+tdStyle0+';color:black;background-color:#D8D8D8;font-weight:bold;">'+row[field]+'</td>');
                    	}
                    }else{
                    	if(row[field]=='' || row[field]==null){
                    		data.push('<td style="'+tdStyle0+'"></td>');
                    	}else{
                    		data.push('<td style="'+tdStyle0+'">'+row[field]+'</td>');
                    	}
                    }
                }
                data.push('</tr>');
                indexRow++;
            });
        	 //---------------报表一报表行数据导出------end-------
        	
        }else if(target.id=='report_forms'){
        	/*-----------------报表二行数据导出----------------begin---------*/
        	var rowNum=0;	//行数
        	/*-----------第一列合并变量--------------*/
        	var preType1="";	//当前行 项目类型
        	var upType1="";	//上一行数据 项目类型
        	var rowspan1=1;	//合并行
        	
        	/*-----------第二列合并变量--------------*/
        	var preType2="";	//当前行 项目类型
        	var upType2="";	//上一行数据 项目类型
        	var rowspan2=1;	//合并行
        	
        	$.map(rows, function(row){
        		preType1=rows[rowNum][1];	//当前行数据
        		preType2=rows[rowNum][2];	//当前行数据
        		data.push('<tr style="'+trStyle+'">');
                for(var i=0; i<fields.length; i++){
                    //隐藏空列
                    var col = dg.datagrid('getColumnOption', fields[i]);
                    if(col.title===undefined) {
                        continue;
                    }
                    //列名
	                var field = fields[i];
                    if(row[field]=='' || row[field]==null){
                    	data.push('<td style="'+tdStyle0+'"></td>');
                    }else{
                    	//第一列 合并
                    	if(field==1){
                    		var nextType1='';
                    		if(rowNum<rows.length-1){
                    			nextType1=rows[rowNum+1][1];	//下一行数据
                    		}
                    		if(preType1==nextType1){	//当前行数据和下一行数据 比较
                    			if(rowspan1==1){	//需要合并几行
                    				for(var n=rowNum;n<rows.length-1;n++){
                            			if (preType1 == rows[n+1][1]) {
                            				rowspan1++;
                            			}else{
                            				break;
                            			}
                            		}
                    				data.push('<td rowspan="'+rowspan1+'" style="'+tdStyle0+'">'+row[field]+'</td>');
                    			}
                    		}else{
                    			//上一条数据和当前行数据比较
                        		if(upType1==preType1){
                        			rowspan1=1;
                        		}else{
                        			data.push('<td style="'+tdStyle0+'">'+row[field]+'</td>');
                        		}
                        	}
                    		//把当前行数据 赋值给 upType1（作为上一条数据）
                    		upType1=preType1;
                    		//console.log("上一行数据："+upType1+"--当前行数据："+preType1+"--下一行数据："+nextType1);
                    	}else if(field==2){
                    		var nextType2='';
                    		if(rowNum<rows.length-1){
                    			nextType2=rows[rowNum+1][2];	//下一行数据
                    		}
                    		if(preType2==nextType2){	//当前行数据和下一行数据 比较
                    			if(rowspan2==1){	//需要合并几行
                    				for(var n=rowNum;n<rows.length-1;n++){
                            			if (preType2 == rows[n+1][2]) {
                            				rowspan2++;
                            			}else{
                            				break;
                            			}
                            		}
                    				data.push('<td rowspan="'+rowspan2+'" style="'+tdStyle0+'">'+row[field]+'</td>');
                    			}
                    		}else{
                    			//上一条数据和当前行数据比较
                        		if(upType2==preType2){
                        			rowspan2=1;
                        		}else{
                        			data.push('<td style="'+tdStyle0+'">'+row[field]+'</td>');
                        		}
                        	}
                    		//把当前行数据 赋值给 upType1（作为上一条数据）
                    		upType2=preType2;
	                    }else{
	                		data.push('<td style="'+tdStyle0+'">'+row[field]+'</td>');
	                    }
                		
	                }
	            }
	            data.push('</tr>');
	            rowNum++;
        	});
        	
        	/*-----------------报表二行数据导出----------------end---------*/
        	
        }else{
        	//-------------默认行数据导出
        	$.map(rows, function(row){
                data.push('<tr style="'+trStyle+'">');
                for(var i=0; i<fields.length; i++){
                    //隐藏空列
                    var col = dg.datagrid('getColumnOption', fields[i]);
                    if(col.title===undefined) {
                        continue;
                    }
                    var field = fields[i];
                    if(row[field]=='' || row[field]==null){
                    	data.push('<td style="'+tdStyle0+'"></td>');
                    }else{
                    	data.push('<td style="'+tdStyle0+'">'+row[field]+'</td>');
                    }
                }
                data.push('</tr>');
            });
        }
        
        data.push('</table>');
        return data.join('');
    }

    function toArray(target, rows){
        rows = rows || getRows(target);
        var dg = $(target);
        var fields = dg.datagrid('getColumnFields',true).concat(dg.datagrid('getColumnFields',false));
        var data = [];
        var r = [];
        for(var i=0; i<fields.length; i++){
            var col = dg.datagrid('getColumnOption', fields[i]);
            r.push(col.title);
        }
        data.push(r);
        $.map(rows, function(row){
            var r = [];
            for(var i=0; i<fields.length; i++){
                r.push(row[fields[i]]);
            }
            data.push(r);
        });
        return data;
    }

    function print(target, param){
        var title = null;
        var rows = null;
        if (typeof param == 'string'){
            title = param;
        } else {
            title = param['title'];
            rows = param['rows'];
        }
        var newWindow = window.open('', '', 'width=800, height=500');
        var document = newWindow.document.open();
        var content = 
            '<!doctype html>' +
            '<html>' +
            '<head>' +
            '<meta charset="utf-8">' +
            '<title>'+title+'</title>' +
            '</head>' +
            '<body>' + toHtml(target, rows) + '</body>' +
            '</html>';
        document.write(content);
        document.close();
        newWindow.print();
    }

    function b64toBlob(data){
        var sliceSize = 512;
        var chars = atob(data);
        var byteArrays = [];
        for(var offset=0; offset<chars.length; offset+=sliceSize){
            var slice = chars.slice(offset, offset+sliceSize);
            var byteNumbers = new Array(slice.length);
            for(var i=0; i<slice.length; i++){
                byteNumbers[i] = slice.charCodeAt(i);
            }
            var byteArray = new Uint8Array(byteNumbers);
            byteArrays.push(byteArray);
        }
        return new Blob(byteArrays, {
            type: ''
        });
    }

    function toExcel(target, param){
        var filename = null;
        var rows = null;
        var worksheet = 'Worksheet';
        if (typeof param == 'string'){
            filename = param;
        } else {
            filename = param['filename'];
            rows = param['rows'];
            worksheet = param['worksheet'] || 'Worksheet';
        }
        var dg = $(target);
        var uri = 'data:application/vnd.ms-excel;base64,'
        , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body>{table}</body></html>'
        , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
        , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }

        var table = toHtml(target, rows);
        var ctx = { worksheet: worksheet, table: table };
        var data = base64(format(template, ctx));
        if (window.navigator.msSaveBlob){
            var blob = b64toBlob(data);
            window.navigator.msSaveBlob(blob, filename);
        } else {
            var alink = $('<a style="display:none"></a>').appendTo('body');
            alink[0].href = uri + data;
            alink[0].download = filename;
            alink[0].click();
            alink.remove();
        }
    }

    $.extend($.fn.datagrid.methods, {
        toHtml: function(jq, rows){
            return toHtml(jq[0], rows);
        },
        toArray: function(jq, rows){
            return toArray(jq[0], rows);
        },
        toExcel: function(jq, param){
            return jq.each(function(){
                toExcel(this, param);
            });
        },
        print: function(jq, param){
            return jq.each(function(){
                print(this, param);
            });
        }
    });
})(jQuery);
