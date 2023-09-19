package com.kopo.SelfFDS.admin.service;

import com.kopo.SelfFDS.admin.model.dto.CardHistoryStats;
import com.kopo.SelfFDS.admin.model.dto.CardStats;
import com.kopo.SelfFDS.admin.model.dto.Fds;
import com.kopo.SelfFDS.admin.model.dto.MemberStats;
import com.kopo.SelfFDS.payment.model.dto.PaymentLog;

import java.util.List;
import java.util.Map;

public interface AdminService {

//    adminmain
    int getAllMemberCnt();
    int getAllCardCnt();
    int getAllAmountSumOfDay();

    List<MemberStats> getMemberCntByYear();
    List<CardStats> getCardCntByYear();
    List<CardHistoryStats> getAmountSumByDate();

    double getMemberCntByYearRate();
    double getCardCntByYearRate();
    double getAmountSumByDateRate();

//    fds
    List<Fds> selectFdsAndMember();

    List<PaymentLog> getAllAnomalyData();

    PaymentLog getAnomalyDataById(int paymentLogId);

    Map<String, Object> calStats(String cardId);

    List<List<Double>> statsToPdf(double mean, double stdDev);

    double[] linspace(double start, double end, int points);

    List<CardHistoryStats> getRegionGroupCntByCardId(String cardId);
    List<CardHistoryStats> getCategoryGroupCntByCardId(String cardId);

}
