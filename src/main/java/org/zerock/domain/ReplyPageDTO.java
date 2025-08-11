package org.zerock.domain;
/* ��۰� ��� �� ó�� 
	= ����� ����¡ ó���� �ʿ��� ��쿡�� ��� ��ϰ� �Բ� ��ü ����� ���� ���� �����ؾ߸� ��
	  => ReplyService �������̽�, ReplyServiceImpl ���� Ŭ������ ��� ���� ���� ������ �� �ִ� ������ ����
	    => ��� �������� ���� ������ �����ϱ� ���� Ŭ������
*/

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReplyPageDTO {
	private int replyCnt; // ����� �� ����
	private List<ReplyVO> list; // ��� ��� ����
	
}
