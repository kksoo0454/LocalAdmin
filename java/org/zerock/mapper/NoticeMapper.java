package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.NoticeVO;

public interface NoticeMapper {
	// ���� ����Ʈ ��������
	public List<NoticeVO> getNoticeList();
	// ���� ���
	public void insertNotice(NoticeVO notice);
	// ���� ����
	public void updateNotice(NoticeVO notice);
	// ���� �б�
	public NoticeVO readNotice(int notice_id);
	// ���� ����
	public void deleteNotice(int notice_id);
}
