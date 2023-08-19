package com.kopo.SelfFDS.controller;

import com.kopo.SelfFDS.model.dto.Card;
import com.kopo.SelfFDS.model.dto.CardHistory;
import com.kopo.SelfFDS.service.CardHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/chart")
public class ChartController {

    private final CardHistoryService cardHistoryService;

    @Autowired
    public ChartController(CardHistoryService cardHistoryService) {
        this.cardHistoryService = cardHistoryService;
    }

    @GetMapping ("/regionServiceChart")
    public ResponseEntity<List<CardHistory>> regionServiceChart(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String card_id = (String) session.getAttribute("card_id");
        List<CardHistory> resultList = cardHistoryService.selectCountRegionOfCardId(card_id);
        System.out.println("CardHistory"+resultList);
        for (CardHistory ch : resultList) {
            System.out.println("Card ID: " + ch.getRegion_name());
            System.out.println("Region Name: " + ch.getRegion_cnt());
            // 필요한 다른 정보도 필요한대로 출력
            System.out.println("----------------------------------");
        }
        if (!resultList.isEmpty()) {
            return ResponseEntity.ok(resultList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}