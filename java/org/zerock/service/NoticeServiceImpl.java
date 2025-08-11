package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.NoticeVO;
import org.zerock.mapper.NoticeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	private NoticeMapper mapper;
	
	@Override
	public void writeNotice(NoticeVO notice) {
		log.info("���� �ۼ� �޼��� �۵�");
		mapper.insertNotice(notice);
	}

	@Override
	public List<NoticeVO> getNoticeList() {
		log.info("���� ����Ʈ �������� �޼��� �۵�");
		return mapper.getNoticeList();
	}

	@Override
	public void modifyNotice(NoticeVO notice) {
		log.info("���� ���� �޼��� �۵�");
		mapper.updateNotice(notice);
	}

	@Override
	public NoticeVO getNotice(int notice_id) {
		log.info("���� �� �޼��� �۵�");
		return mapper.readNotice(notice_id);
	}

	@Override
	public void removeNotice(int notice_id) {
		log.info("���� ���� �޼��� �۵�");
		mapper.deleteNotice(notice_id);
	}

}
