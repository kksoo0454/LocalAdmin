package org.zerock.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
/* ReplyController ����
 	= REST ������� ����
 	= REST ��� URL ����� PK �������� �ۼ��ϴ� ���� ����
 	  PK������ ��ȸ, ����, ������ �����ϱ� ����
 	= �ٸ�, ����� ����� PK�� ����� �� ���� ������ �Ķ���ͷ� �Խù��� ��ȣ(bno)�� ��������ȣ(page)�������� URL���� ǥ���ϴ� ��� ���
 	#. REST ������� ó���� ������ ��
 	  a. �������� �ܺο��� ������ ȣ���� ��
 	     �������� ���˰� �������� �����ִ� �������� Ÿ���� ��Ȯ�ϰ� �����ؾ� ��
 	     (����) ��� ����� ���
 	       ��. (������) JSONŸ������ �� ��� �����͸� ������ ����
 	       ��. (����) ����� ó�� ����� ���������� �Ǿ����� ���ڿ��� ����� �˷��ֵ��� ��
*/
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReplyController {
	@Setter(onMethod_ = {@Autowired})
	private ReplyService service;
	
	@PostMapping(value="/new", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		log.info("ReplyVO => " + vo);
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT => " + insertCount);
		// �������� ������ = ����߰� ������ ���� 200�� OK, 500�� Server Error ��ȯ
		return insertCount == 1 ? new ResponseEntity<>("success 200",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	/* �׽�Ʈ�۾� = ũ�� YARC ��� | select * from tbl_board ��ȸ �� ���� �����ϴ� bno��ȣ�� �׽�Ʈ
	 	URL : http://localhost:8080/replies/new
	 	Payload : {"bno":27,"reply":"hello","replyer":"hj"}
	 	- bno�� ���� DB���ִ� �۹�ȣ
	 	- reply, replyer�� �÷���
	 	Custom Headers : Content-Type application/json
	 	=> �׽�Ʈ ������ 200 OK
	 	=> select * from tbl_reply where bno = 27; => ���� ���Ӽ� ó���Ǿ����� Ȯ�� */
	
	/*
	 * @GetMapping(value="/pages/{bno}/{page}",
	 * produces={MediaType.APPLICATION_ATOM_XML_VALUE,
	 * MediaType.APPLICATION_JSON_UTF8_VALUE}) public ResponseEntity<List<ReplyVO>>
	 * getList(
	 * 
	 * @PathVariable("page") int page,
	 * 
	 * @PathVariable("bno") Long bno) {
	 * log.info("getList.............................."); // Criteria ���� �Ķ���� ����
	 * {page}�� page���� Criteria�� �����ؼ� ���� ó�� Criteria cri = new Criteria(page, 10); //
	 * Criteria(pageNum=1, amount=10, type=null, keyword=null)
	 * log.info("Criteria�� page => " + cri); return new
	 * ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK); }
	 */
	/* (�������׽�Ʈ) http://localhost:8080/replies/pages/1/1.json */
	
	@GetMapping(value="/{rno}", 
			produces={MediaType.APPLICATION_ATOM_XML_VALUE,
					  MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		log.info("get => " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	/* (�������׽�Ʈ) http://localhost:8080/replies/11 */
	
	// ���������� HTTP DELETE��û�� ó���ϴµ� ���Ǵ� ������̼�
	// RESTful �� ���񽺿��� �ڿ��� �����ϱ� ���� �޼��忡 ����
	@DeleteMapping(value="/{rno}", produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("delete => " + rno);
		return service.remove(rno) == 1 ? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	/* �׽�Ʈ�۾� = ũ�� YARC ��� | select * from tbl_board ��ȸ �� ���� �����ϴ� rno��ȣ�� �׽�Ʈ
 	URL : http://localhost:8080/replies/6
 	- rno�� ���� DB���ִ� �۹�ȣ
 	Custom Headers : Content-Type application/json
 	=> �׽�Ʈ ������ 200 OK
 	=> ���� ���Ӽ� ó���Ǿ����� Ȯ�� */
	
	// JSON���·� ���޵Ǵ� �����Ϳ� �Ķ���ͷ� ���޵Ǵ� ��۹�ȣ(rno)�� ó����
	// ���� = PUT�̳� PATCH ����� �̿��Ͽ� ó��
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
	         value = "/{rno}", // ��۹�ȣ
	         consumes = "application/json", // ���� �����Ǵ� �����ʹ� JSON �������� ���� = @RequestBody ���� ó��
	         produces = { MediaType.TEXT_PLAIN_VALUE })
	   public ResponseEntity<String> modify(
	         @RequestBody ReplyVO vo,
	         @PathVariable("rno") Long rno) {
	      vo.setRno(rno); // �Է� �Ķ���� rno�� setter�̿��Ͽ� ����
	      log.info("rno => " + rno);
	      log.info("modify => " + vo);
	      return service.modify(vo) == 1
	            ? new ResponseEntity<>("success", HttpStatus.OK)
	            : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	/* (ũ�� YARC ��� �׽�Ʈ) 
	 	URL : http://localhost:8080/replies/6
	 	Payload : {"bno":1,"reply":"hellohello","replyer":"hj"}
	 	Custom Headers : Content-Type application/json
	 	=> �׽�Ʈ ������ 200 OK
 		=> ���� ���Ӽ� ó���Ǿ����� Ȯ�� */
	
	
	/* ���� getList() �ڵ鷯 �ּ�ó�� �� ���� */
	// ��� ���, ��� �� ���� ��ȯ
	@GetMapping(value="/pages/{post_id}/{page}", produces={MediaType.APPLICATION_JSON_UTF8_VALUE})
	// ����Ÿ�� ����
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("post_id") Long post_id,
			@PathVariable("page") int page) {
		log.info("getList..............................");
		Criteria cri = new Criteria(page, 10);
		log.info("Criteria�� page => " + cri);
		// ����Ÿ��, getListPage �޼���� ����
		return new ResponseEntity<>(service.getListPage(cri, post_id), HttpStatus.OK);
	}
	/* (�������׽�Ʈ) http://localhost:8080/replies/pages/1/1.json
	 	= ������ �����ϰ� JSON �����͸� ���������� ReplyPageDTO��ü�� JSON���� �����ϰ� ��
	 	  => Ư�� �Խù��� ��� ����� ��ȸ�ϸ� replyCnt�� list��� �̸��� �Ӽ��� ������ JSON���ڿ��� ���� */

}
