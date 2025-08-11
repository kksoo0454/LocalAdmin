package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

/* Mapper �������̽� = ��۵� ����¡ó���� �ʿ��ϹǷ� Criteria�̿��� ó�� */
public interface ReplyMapper {

	   /* a. ���(create) */
	   public int insert(ReplyVO vo);
	   /* b. ��ȸ(read) */
	   public ReplyVO read(Long rno); // Ư�� ��� �б�
	   /* c. ����(delete) = ����� ��ȣ(rno)������ ó�� */
	   public int delete(Long rno);
	   /* d. ����(update) = ����� ����(reply), �����ð�(updatedate) ���� */
	   public int update(ReplyVO vo);
	   
	   /* ��۸�� = @Param ���
	       	= ����� ��ϰ� ����¡ó���� ���� �Խù� ����¡ ó���� ����
	       	  => (�߰���) Ư���� �Խù��� ��۵鸸�� ������� �ϱ� ������ �߰��� �Խù��� �۹�ȣ�� �ʿ�
	   		#. MyBatis�� �ΰ��̻��� �����͸� �Ķ���ͷ� �����ϴ� ������� ���� ���Ѱ� = @Param
	   		  = @Param�� �Ӽ����� MyBatis���� SQL�� �̿��� �� #{}�� �̸����� ����� ������
	   */
	   public List<ReplyVO> getListWithPaging(
			   // XML�� ó���Ҷ� ������ cri�� bno��� ��� ����
			   @Param("cri") Criteria cri, // ����¡ ó���� ������ �����ϰ� Criteria �̿�
			   @Param("post_id") Long post_id); // �߰������� �ش� �Խù��� ��ȣ�� �Ķ���ͷ� �����ϵ��� ��
	   /* ��� �����ľ� = post_id�� �ش��ϴ� ��� ���� ���ϱ� */
	   public int getCountByBno(Long post_id);
}
