var ipam = {};
ipam.user = {};

/**
 * 검색하기
 */
ipam.user.search = function(frm) {
	frm.key_user_id.value = jQuery('#tempkey_user_id').val();
	if(jQuery('#add_condition').val() == 'true') {
		frm.key_user_name.value = jQuery('#tempkey_user_name').val();
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
 * 사용자관리 팝업
 */
ipam.user.manage = function(user_id) {
	ipam.user.openLayer('./user_manage.jsp', user_id);
};

/**
 * 사용자관리 실행
 */
ipam.user.process = function(frm, frm_list) {
	jQuery.ajax({
		type : 'post',
		url : './user_process.jsp',
		data : jQuery(frm).serialize(),
		dataType : 'json',
		success : function(data){
			if((typeof data.RESULT) == 'string') {
				if(data.RESULT == 'SUCCESS') {
					ipam.user.list(frm_list);
					//alert('처리되었습니다.2222');
					jAlert('처리되었습니다.', '사용자관리');
					ipam.user.closeLayer();
				}else {
					//alert(data.RESULT);
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
			'z-index':'99999'
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