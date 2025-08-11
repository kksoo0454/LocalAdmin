package org.zerock.service;

import java.util.List;

import org.zerock.domain.NoticeVO;

public interface NoticeService {
	// ���� �ۼ�
	public void writeNotice(NoticeVO notice);
	// ���� ���� ��� ��������
	public List<NoticeVO> getNoticeList();
	// ���� ����
	public void modifyNotice(NoticeVO notice);
	// ���� ��
	public NoticeVO getNotice(int notice_id);
	// ���� ����
	public void removeNotice(int notice_id);
}
