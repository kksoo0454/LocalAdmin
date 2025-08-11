package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
   private MemberService service;
   
   
   
   @GetMapping("/dashboard")
   public String dashboard() {
      return "/admin/dashboard";
   }

   @GetMapping("/login")
   public void login() {
      log.info("login =>");
   }
   
   @GetMapping("/resident/register")
   public String showRegisterForm() {
       return "admin/resident/register"; // ����� jsp ���
   }

   @PostMapping("/resident/register")
   public String register(MemberVO member, RedirectAttributes rttr) {
       service.register(member);
       rttr.addFlashAttribute("message", "����� �Ϸ�Ǿ����ϴ�.");
       return "redirect:/admin/resident/list";
   }
   
   @GetMapping("/resident/view")
   public String view(@RequestParam("member_id") String member_id, Model model) {
       MemberVO member = service.get(member_id);
       model.addAttribute("member", member);
       return "admin/resident/view"; // �� ��� �������� JSP ��ġ ������
   }

   @GetMapping("/resident/update")
   public String updateForm(@RequestParam("member_id") String member_id, Model model) {
       MemberVO member = service.get(member_id);
       model.addAttribute("member", member);
       return "admin/resident/update"; // ���� ���� JSP ���
   }
   
   @PostMapping("/resident/update")
   public String update(MemberVO member, RedirectAttributes rttr) {
       service.update(member);
       rttr.addFlashAttribute("message", "�����Ǿ����ϴ�.");
       return "redirect:/admin/resident/view?jumin=" + member.getJumin();
   }
     
     @GetMapping("/resident/list") 
     public String list(Model model) {
     List<MemberVO> list = service.getList();
     model.addAttribute("memberList", list); return "/admin/resident/list"; }
    
     @GetMapping("/resident/delete")
     public String delete(@RequestParam("member_id") String member_id, Model model) {
    	 service.delete(member_id);
    	 return "redirect:/admin/resident/list";
     }

}
