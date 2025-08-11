package org.zerock.service;
/* ReplyService �������̽� = ���񽺰��� */



import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	/* a. ��� */
	public int register(ReplyVO vo);
	/* b. ��� �������� */
	public ReplyVO get(Long rno);
	/* c. ��� ���� */
	public int modify(ReplyVO vo);
	/* d. ��� ���� */
	public int remove(Long rno);
	/* e. �ش� �� ��� ��� */
	public List<ReplyVO> getList(Criteria cri, Long post_id); 
	
	public ReplyPageDTO getListPage(Criteria cri, Long post_id);
}
