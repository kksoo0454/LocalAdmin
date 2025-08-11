package org.zerock.service;

import java.util.List;
/* ReplyService ���� Ŭ���� */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		log.info("register => " + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get => " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify => " + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("remove => " + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long post_id) {
		log.info("getList with criteria => " + post_id);
		return mapper.getListWithPaging(cri, post_id);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long post_id) {
		// ���� = �ΰ��� ������ �ϳ��� DTO ��ü�� ��Ƽ� ��ȯ
		return new ReplyPageDTO(mapper.getCountByBno(post_id), // ����� �� ����
				// �Ķ���� cri = �˻����ǿ� ���� ������ ��ȣ, �������� �׸�� ���� | bno = �Խù� ��ȣ
				mapper.getListWithPaging(cri, post_id)); // ��� ����� ��
	}
}
