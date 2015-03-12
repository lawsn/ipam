var ipam = {};
ipam.user = {};

/**
 * �˻��ϱ�
 */
ipam.user.search = function(frm) {
	if(window.event.keyCode == 13) {
		frm.key_user_id.value = jQuery('#tempkey_user_id').val();
		ipam.user.list(frm, 1);
	}
};

/**
 * ��Ϻ���
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
 * ����ڰ��� �˾�
 */
ipam.user.manage = function(user_id) {
	ipam.user.openLayer('./user_manage.jsp', user_id);
};

/**
 * ����ڰ��� ����
 */
ipam.user.process = function(frm) {
	jQuery.post('./user_manage.jsp', jQuery(frm).serialize(), function(data) {
		if('SUCCESS' == data) {
			ipam.user.closeLayer('layer1');
		}
	});
};

/**
 * ����� ����
 */
ipam.user.del = function(user_id) {
	jQuery.post('./user_manage.jsp', 'proc=delete&user_id=' + user_id, function(data) {
		ipam.user.list(document.forms['frm_list']);
	});
};

/**
 * ���̾��˾� ����
 */
ipam.user.openLayer = function(url, user_id) {
	
	jQuery.post(url, 'user_id=' + user_id, function(data) {
		
		jQuery('body').append(data);
		
		var temp = jQuery('#layer1');		//���̾��� id�� temp������ ����
		var bg = temp.prev().hasClass('bg');	//dimmed ���̾ �����ϱ� ���� boolean ����
	
		if(bg){
			jQuery('.layer').fadeIn();
		}else{
			temp.fadeIn();	//bg Ŭ������ ������ �Ϲݷ��̾�� �����Ѵ�.
		}
	
		// ȭ���� �߾ӿ� ���̾ ����.
		if (temp.outerHeight() < jQuery(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < jQuery(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
	
		temp.find('a.cbtn').click(function(e){
			if(bg){
				jQuery('.layer').fadeOut();
			}else{
				temp.fadeOut();		//'�ݱ�'��ư�� Ŭ���ϸ� ���̾ �������.
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
 * ���̾��˾� �ݱ�
 */
ipam.user.closeLayer = function(id) {
	
	jQuery('#'+id).fadeOut(function() {
		jQuery(this).remove();
	});
	e.preventDefault();
};