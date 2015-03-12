var ipam = {};
ipam.user = {};

/**
 * 검색하기
 */
ipam.user.search = function(frm) {
	if(window.event.keyCode == 13) {
		frm.key_user_id.value = jQuery('#tempkey_user_id').val();
		ipam.user.list(frm, 1);
	}
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
ipam.user.process = function(frm) {
	jQuery.post('./user_manage.jsp', jQuery(frm).serialize(), function(data) {
		if('SUCCESS' == data) {
			ipam.user.closeLayer('layer1');
		}
	});
};

/**
 * 사용자 삭제
 */
ipam.user.del = function(user_id) {
	jQuery.post('./user_manage.jsp', 'proc=delete&user_id=' + user_id, function(data) {
		ipam.user.list(document.forms['frm_list']);
	});
};

/**
 * 레이어팝업 열기
 */
ipam.user.openLayer = function(url, user_id) {
	
	jQuery.post(url, 'user_id=' + user_id, function(data) {
		
		jQuery('body').append(data);
		
		var temp = jQuery('#layer1');		//레이어의 id를 temp변수에 저장
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수
	
		if(bg){
			jQuery('.layer').fadeIn();
		}else{
			temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
		}
	
		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < jQuery(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < jQuery(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
	
		temp.find('a.cbtn').click(function(e){
			if(bg){
				jQuery('.layer').fadeOut();
			}else{
				temp.fadeOut();		//'닫기'버튼을 클릭하면 레이어가 사라진다.
			}
			e.preventDefault();
		});
	
		jQuery('.layer .bg').click(function(e){
			jQuery('.layer').fadeOut();
			e.preventDefault();
		});
	});

};

/**
 * 레이어팝업 닫기
 */
ipam.user.closeLayer = function(id) {
	
	jQuery('#'+id).fadeOut(function() {
		jQuery(this).remove();
	});
	e.preventDefault();
};