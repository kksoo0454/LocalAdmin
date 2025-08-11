package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AdminVO;
import org.zerock.domain.DashboardVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.AdminMapper;
import org.zerock.service.DashboardService;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
   private MemberService service;
   private DashboardService dashboardService;
   private AdminMapper adminMapper;
   
   @GetMapping("/dashboard")
   public String dashboardchk(Model model, Authentication authentication, HttpServletRequest request, HttpServletResponse response) {
      System.out.println("/admin/dashboard ��Ʈ�ѷ� ����");
      log.info(">> �α��� ������ �����: " + authentication.getName());
       authentication.getAuthorities().forEach(auth -> {
           log.info(">> ����: " + auth.getAuthority());
       });
       
       // 1. ������ ����� ���� ������ (UserDetails)
       User user = (User) authentication.getPrincipal();
       String username = user.getUsername();
       log.info("�α����� �����: " + username);

       // 2. DB���� AdminVO ��������
       AdminVO admin = adminMapper.findByAdminName(username);  // �ʰ� ���� ���� �̸��� ���� �ٸ�
       log.info("DB���� ������ ������: " + admin);

       // 3. ���ǿ� ����
       HttpSession session = request.getSession();
       session.setAttribute("loginAdmin", admin);
       
       DashboardVO dashboard = dashboardService.getDashboard();
      model.addAttribute("dashboard", dashboard);
       return "/admin/dashboard";
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
       return "redirect:/admin/resident/view?member_id=" + member.getMember_id();
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
