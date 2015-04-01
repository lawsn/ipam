var ipam = {};
ipam.user = {};
ipam.audit = {};


ipam.user.trim = function(s) {
	  s += ''; // 숫자라도 문자열로 변환
	  return s.replace(/^\s*|\s*$/g, '');
};

/*********************
 * 특수문자 체크
**********************/
ipam.user.isSpacChar = function(string) {
	  //var stringRegx=/^[0-9a-zA-Z가-힝]*$/; 
	  var stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
	  var isValid = false; 
	  if(stringRegx.test(string)) { 
	       isValid = true; 
	  } 
	        
	  return isValid; 
		 
};


ipam.user.ipamuser = function() {
	location.href = './user_template.jsp';
};

ipam.user.ipamaudit = function() {
	location.href = './user_template_audit.jsp';
};


/**
 * 검색하기
 */
ipam.user.search = function(frm) {
	frm.key_user_id.value = jQuery('#tempkey_user_id').val();
	if(jQuery('#add_condition').val() == 'true') {
		frm.key_user_name.value = jQuery('#tempkey_user_name').val();
		if( ipam.user.isSpacChar(frm.key_user_name.value)){
			jAlert('특수문자는 사용할수 없습니다.이름을 올바르게 입력 후<br />다시 시도하여 주십시요.', '검색어 입력오류');
			return;
		}
		
		frm.key_ip_list.value = jQuery('#tempkey_ip_list').val();
		if(jQuery('#tempkey_allow_excp').attr('checked') == 'checked') {
			frm.key_allow_excp.value = 't';
		}else {
			frm.key_allow_excp.value = '';
		}
	}else {
//		if(frm.key_user_id.value == '') {
//			alert("검색할 사번을 입력하여 주세요.");
//			return;
//		}
		frm.key_user_name.value = '';
		frm.key_ip_list.value = '';
		frm.key_allow_excp.value = '';
	}
	ipam.user.list(frm, 1);
};

ipam.audit.search = function(frm) {
	frm.key_operator_id.value = jQuery('#tempkey_operator_id').val();
	if(jQuery('#add_condition').val() == 'true') {
		frm.key_audit_type.value = jQuery('#tempkey_audit_type').val();
		if( ipam.user.isSpacChar(frm.key_audit_type.value)){
			jAlert('특수문자는 사용할수 없습니다.타입을 올바르게 입력 후<br />다시 시도하여 주십시요.', '검색어 입력오류');
			return;
		}
		
		frm.key_ip_list.value = jQuery('#tempkey_ip_list').val();
		if(jQuery('#tempkey_allow_excp').attr('checked') == 'checked') {
			frm.key_allow_excp.value = 't';
		}else {
			frm.key_allow_excp.value = '';
		}
	}else {
//		if(frm.key_user_id.value == '') {
//			alert("검색할 사번을 입력하여 주세요.");
//			return;
//		}
		frm.key_audit_type.value = '';
		frm.key_ip_list.value = '';
		frm.key_allow_excp.value = '';
	}
	ipam.audit.list(frm, 1);
};


/**
 * 목록보기
 */
ipam.user.list = function(frm, page_no) {
	if((typeof page_no) == 'number') {
		frm.page_no.value = page_no;
	}
	jQuery.post('./user_list.jsp', jQuery(frm).serialize(), function(data) {
		jQuery('#contents').html(data);
	});
};

/**
 * 목록보기
 */
ipam.audit.list = function(frm, page_no) {
	if((typeof page_no) == 'number') {
		frm.page_no.value = page_no;
	}
	jQuery.post('./audit_list.jsp', jQuery(frm).serialize(), function(data) {
		jQuery('#contents').html(data);
	});
};



/**
 * 사용자관리 팝업
 */
ipam.user.manage = function(user_id) {
	ipam.user.openLayer('./user_manage.jsp', user_id);
};

/**
 * 사용자관리 실행
 */
ipam.user.process = function(frm, frm_list) {
	// 입력값 validation
	var user_id = jQuery.trim(frm.user_id.value);
	if((typeof user_id) != 'string' || user_id.length == 0) {
		jAlert('사번을 올바르게 입력 후<br />다시 시도하여 주십시요.', '사번 입력오류', function() {
			frm.user_id.focus();
		});
		return;
	}
	var user_name = jQuery.trim(frm.user_name.value);
	if((typeof user_name) != 'string' || user_name.length == 0) {
		jAlert('이름을 올바르게 입력 후<br />다시 시도하여 주십시요.', '이름 입력오류', function() {
			frm.user_name.focus();
		});
		return;
	}
	var ip_list = jQuery.trim(frm.ip_list.value);
	var valid_ip = false;
	if((typeof ip_list) == 'string' && ip_list.length > 0) {
		var _ip = ip_list.split(',');
		for(var i=0; i<_ip.length; i++) {
			if(!(/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/.test(_ip[i]) && (RegExp.$1 <256 && RegExp.$2 <256 && RegExp.$3 <256 && RegExp.$4 <256))) {
				valid_ip = false; //검증실패
				break;
			}
			valid_ip = true; //검증성공
		}
	}
	if(valid_ip == false) { // IP 입력 오류
		jAlert('사용자 IP를 올바르게 입력 후<br />다시 시도하여 주십시요.', 'IP 입력오류', function() {
			frm.ip_list.focus();
		});
		return;
	}
	
	jQuery.ajax({
		type : 'post',
		url : './user_process.jsp',
		data : jQuery(frm).serialize(),
		dataType : 'json',
		success : function(data){
			if((typeof data.RESULT) == 'string') {
				if(data.RESULT == 'SUCCESS') {
					ipam.user.list(frm_list);
					jAlert('처리되었습니다.', '사용자관리');
					ipam.user.closeLayer();
				}else {
					jAlert(data.RESULT, '사용자관리');
				}
			}
		}
	});	
};

/**
 * 사용자 삭제
 */
ipam.user.del = function(frm, user_id) {
	if((typeof user_id) != 'string' || user_id == '') {
		jAlert('해당하는 사용자가 없습니다.', '사용자관리');
		//alert('해당하는 사용자가 없습니다.');
		return;
	}
	
	jConfirm ('사용자('+user_id+')를 삭제하시겠습니까?', '사용자삭제', function(r){
		if(r==true){
	//if(confirm('사용자('+user_id+')를 삭제하시겠습니까?')) {
		jQuery.ajax({
			type : 'post',
			url : './user_process.jsp',
			data : {'proc':'delete','user_id':user_id},
			dataType : 'json',
			success : function(data){
				if((typeof data.RESULT) == 'string') {
					if(data.RESULT == 'SUCCESS') {
						ipam.user.list(frm);
						jAlert('삭제되었습니다.', '사용자관리');
						//alert('삭제되었습니다.');
					}else {
						jAlert(data.RESULT, '사용자관리');
						//alert(data.RESULT);
					}
				}
			}
		});		
	 }
	});
};

/**
 * 레이어팝업 열기
 */
ipam.user.openLayer = function(url, user_id) {
	
	jQuery.post(url, 'user_id=' + user_id, function(data) {
		
		ipam.user.closeLayer();
		
		var _mask = jQuery('<div id="layerpopupMask"></div>');
		jQuery('body').append(_mask);
		_mask.css({
			'position': 'absolute',
			'z-index': 99998,
			'top': '0px',
			'left': '0px',
			'width': '100%',
			'height': jQuery(document).height(),
			'background': '#FFFFFF',
			'filter': 'alpha(opacity=1)',
			'opacity': '0.01'
		});		

		var _layer = jQuery('<div id="layerpopup" class="pop-layer"><div id="layercontents" class="pop-container"></div></div>');
		jQuery('body').append(_layer);
		jQuery('#layercontents').append(data);
		
		var left = ( jQuery(window).scrollLeft() + (jQuery(window).width() - _layer.width()) / 2 );
		var top = ( jQuery(window).scrollTop() + (jQuery(window).height() - _layer.height()) / 2 );
		_layer.css({
			'left':left,'top':top,
			'position':'absolute',
			'z-index':'99999',
			'max-width': '400px'
		});
		jQuery('body').css('position','relative').append(_layer);		
		
		_layer.show();
	});

};

/**
 * 레이어팝업 닫기
 */
ipam.user.closeLayer = function() {
	
	jQuery('#layerpopup').remove();
	jQuery('#layerpopupMask').remove();
	
};