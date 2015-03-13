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
					alert('처리되었습니다.');
					ipam.user.closeLayer();
				}else {
					alert(data.RESULT);
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
		alert('해당하는 사용자가 없습니다.');
		return;
	}
	if(confirm('사용자('+user_id+')를 삭제하시겠습니까?')) {
		jQuery.ajax({
			type : 'post',
			url : './user_process.jsp',
			data : {'proc':'delete','user_id':user_id},
			dataType : 'json',
			success : function(data){
				if((typeof data.RESULT) == 'string') {
					if(data.RESULT == 'SUCCESS') {
						ipam.user.list(frm);
						alert('삭제되었습니다.');
					}else {
						alert(data.RESULT);
					}
				}
			}
		});		
	}
};

/**
 * 레이어팝업 열기
 */
ipam.user.openLayer = function(url, user_id) {
	
	jQuery.post(url, 'user_id=' + user_id, function(data) {
		
		ipam.user.closeLayer();
		var layer = jQuery('<div id="layerpopup" class="pop-layer"><div id="layercontents" class="pop-container"></div></div></div>');
		jQuery('body').append(layer);
		jQuery('#layercontents').append(data);
		
		var temp = jQuery('#layerpopup');		//레이어의 id를 temp변수에 저장
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수
	
		if(bg){
			jQuery('.layer').fadeIn();
		}else{
			temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
		}
		
		if(temp.height() > jQuery(window).height()) {
			temp.css('top', '0px');
		}else {
			temp.css('top', (jQuery(window).height() / 2) - (temp.height() / 2) + jQuery(window).scrollTop());
		}
		
		if(temp.width() > jQuery(window).width()) {
			temp.css('left', '0px');
		}else {
			temp.css('left', (jQuery(window).width() / 2) - (temp.width() / 2) + jQuery(window).scrollLeft());
		}
		
	
//		// 화면의 중앙에 레이어를 띄운다.
//		if (temp.outerHeight() < jQuery(document).height()) {
//			temp.css('margin-top', '-'+(temp.outerHeight()/2)+'px');
//		}else {
//			temp.css('top', '0px');
//		}
//		if (temp.outerWidth() < jQuery(document).width()) {
//			temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
//		}else {
//			temp.css('left', '0px');
//		}
	
		temp.find('a.cbtn').click(function(e){
			if(bg){
				jQuery('.layer').fadeOut();
			}else{
				temp.fadeOut();		//'닫기'버튼을 클릭하면 레이어가 사라진다.
			}
		});
	
		jQuery('.layer .bg').click(function(e){
			jQuery('.layer').fadeOut();
		});
	});

};

/**
 * 레이어팝업 닫기
 */
ipam.user.closeLayer = function() {
	
	jQuery('#layerpopup').fadeOut(function() {
		jQuery(this).remove();
	});
};