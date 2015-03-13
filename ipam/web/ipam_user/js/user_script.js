var ipam = {};
ipam.user = {};

/**
 * �˻��ϱ�
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
//			alert("�˻��� ����� �Է��Ͽ� �ּ���.");
//			return;
//		}
		frm.key_user_name.value = '';
		frm.key_ip_list.value = '';
		frm.key_allow_excp.value = '';
	}
	ipam.user.list(frm, 1);
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
					alert('ó���Ǿ����ϴ�.');
					ipam.user.closeLayer();
				}else {
					alert(data.RESULT);
				}
			}
		}
	});	
};

/**
 * ����� ����
 */
ipam.user.del = function(frm, user_id) {
	if((typeof user_id) != 'string' || user_id == '') {
		alert('�ش��ϴ� ����ڰ� �����ϴ�.');
		return;
	}
	if(confirm('�����('+user_id+')�� �����Ͻðڽ��ϱ�?')) {
		jQuery.ajax({
			type : 'post',
			url : './user_process.jsp',
			data : {'proc':'delete','user_id':user_id},
			dataType : 'json',
			success : function(data){
				if((typeof data.RESULT) == 'string') {
					if(data.RESULT == 'SUCCESS') {
						ipam.user.list(frm);
						alert('�����Ǿ����ϴ�.');
					}else {
						alert(data.RESULT);
					}
				}
			}
		});		
	}
};

/**
 * ���̾��˾� ����
 */
ipam.user.openLayer = function(url, user_id) {
	
	jQuery.post(url, 'user_id=' + user_id, function(data) {
		
		ipam.user.closeLayer();
		var layer = jQuery('<div id="layerpopup" class="pop-layer"><div id="layercontents" class="pop-container"></div></div></div>');
		jQuery('body').append(layer);
		jQuery('#layercontents').append(data);
		
		var temp = jQuery('#layerpopup');		//���̾��� id�� temp������ ����
		var bg = temp.prev().hasClass('bg');	//dimmed ���̾ �����ϱ� ���� boolean ����
	
		if(bg){
			jQuery('.layer').fadeIn();
		}else{
			temp.fadeIn();	//bg Ŭ������ ������ �Ϲݷ��̾�� �����Ѵ�.
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
		
	
//		// ȭ���� �߾ӿ� ���̾ ����.
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
				temp.fadeOut();		//'�ݱ�'��ư�� Ŭ���ϸ� ���̾ �������.
			}
		});
	
		jQuery('.layer .bg').click(function(e){
			jQuery('.layer').fadeOut();
		});
	});

};

/**
 * ���̾��˾� �ݱ�
 */
ipam.user.closeLayer = function() {
	
	jQuery('#layerpopup').fadeOut(function() {
		jQuery(this).remove();
	});
};