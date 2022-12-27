package com.team3.model.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
@Slf4j
public class UserMailSendService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private MemberDAO dao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    public int mailSendWithPassword(String mem_id, String mem_email) {
        String key = getKey(false, 8);

        MemberDTO getMemInfo = dao.selectMember(mem_id);
        String name = getMemInfo.getMem_name();

        MimeMessage mail = mailSender.createMimeMessage();
        String htmlStr = "<div style=\"width:100%; min-width:690px; height:auto; margin:0; padding:50px 0px; box-sizing:border-box; background:#f4f4f7; font-family: 'Noto Sans KR', sans-serif;\">\n" +
                "    <div style=\"width:690px; height:auto; margin:0 auto;\">\n" +
                "        <div align=\"center\" style=\"width:548px; height:auto; margin:0; padding:60px 70px; background:#fff; border-left:1px solid #f4f4f7; border-right:1px solid #f4f4f7;\"><p style=\"font-size:18px; font-weight:700; color:#000; line-height:1; letter-spacing:-0.075em; margin-bottom:9px;\">&nbsp;회원님의 임시 비밀번호는&nbsp;<span style=\"color:#ff3c00;\">" + key + "</span>&nbsp;입니다.</p>\n" +
                "            <p style=\"font-size:15px; font-weight:400; color:#000; line-height:1.7; letter-spacing:-0.075em; margin:0;\">안내드린 정보로 접속하신 후 비밀번호를 변경하세요.<br>더욱 편리한 COWORK 서비스를 제공하기 위해 최선을 다하겠습니다.</p>\n" +
                "            <a href=\"http://localhost:8888/\" style=\"font-size:15px; font-weight:500; letter-spacing:-0.075em; text-decoration:none; color:#fff; background:#7BE66D; padding:13px 29px 15px; border-radius:50px; display:inline-block; margin:28px 0 0;\" rel=\"noreferrer noopener\">로그인 페이지로 이동하기</a>\n" +
                "            <div style=\"width:100%; height:1px; background:#e9e9eb; margin:45px 0 38px\">\n" +
                "            </div>\n" +
                "            <p style=\"  font-size:14px; font-weight:400; color:#000; line-height:1.5; letter-spacing:-0.075em; margin-bottom:8px;\">본 메일은 발신전용 메일이므로, 회신을 통한 문의는 처리되지 않습니다.</p>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</div>";
        try {
            mail.setSubject("[COWORK] 임시 비밀번호가 발급되었습니다.", "UTF-8");
            mail.setText(htmlStr, "UTF-8", "html");
            mail.addRecipient(Message.RecipientType.TO, new InternetAddress(mem_email));
            mailSender.send(mail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        key = passwordEncoder.encode(key);

        HashMap<String, Object> map = new HashMap<>();

        map.put("mem_id", mem_id);
        map.put("mem_email", mem_email);
        map.put("key", key);

        int check = dao.updatePwd(map);

        System.out.println("check >> " + check);

        return check;
    }

    private String init() {
        Random random = new Random();

        StringBuilder sb = new StringBuilder();

        int no = 0;

        do {
            no = random.nextInt(75) + 48;
            if (no <= 57 || no >= 65 && no <= 90 || no >= 97) {
                sb.append((char) no);
            }
        } while (sb.length() < size);
        if (lowerCheck) {
            return sb.toString().toLowerCase();
        }
        return sb.toString();
    }

    private boolean lowerCheck;
    private int size;

    public String getKey(boolean lowerCheck, int size) {
        this.lowerCheck = lowerCheck;
        this.size = size;
        return init();
    }
}
