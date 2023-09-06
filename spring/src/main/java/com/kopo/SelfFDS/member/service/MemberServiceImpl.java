package com.kopo.SelfFDS.member.service;

import com.kopo.SelfFDS.member.model.dao.MemberMapper;
import com.kopo.SelfFDS.member.model.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {
    private MemberMapper memberMapper;

    @Autowired
    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public List<Member> getAllMember() {
        return memberMapper.getAllMember();
    }
    @Override
    public Member selectNameOfMember(String email) {
        return memberMapper.selectNameOfMember(email);
    }
    @Override
    public Member loginMember(HashMap<String, String> loginData) {
        return memberMapper.loginMember(loginData);
    }

    @Override
    public void joinMember(Member member) {
        memberMapper.insertMember(member);
    }

    @Override
    public void modifyMember(Member member) {
        memberMapper.updateMember(member);
    }

    @Override
    public void deleteMember(String email) {
        memberMapper.deleteMember(email);
    }

    @Override
    public List<Card> getAllCard() {
        return memberMapper.getAllCard();
    }


    public List<Card> selectCardOfEmail(String email) {
        return memberMapper.selectCardOfEmail(email);
    }


    @Override
    public Card selectCardOfCardId(String cardId) {
        return memberMapper.selectCardOfCardId(cardId);
    }

    @Override
    public void updateSelfFdsStatus(Card card) {
        memberMapper.updateSelfFdsStatus(card);

    }

    @Override
    public void updateFdsStatus(Card card) {
        memberMapper.updateFdsStatus(card);
    }


    @Override
    public List<String> selectAllRegionName() {
        return memberMapper.selectAllRegionName();
    }

    @Override
    public List<String> selectAllBigCategory() {
        return memberMapper.selectAllBigCategory();
    }

    @Override
    public List<SafetyRegister> selectSmallCategoryOfBigCategory(String categoryBig) {
        return memberMapper.selectSmallCategoryOfBigCategory(categoryBig);
    }


    @Override
    public List<CardHistory> selectCountRegionOfCardId(String cardId) {
        return memberMapper.selectCountRegionOfCardId(cardId);
    }

    @Override
    public List<CardHistory> selectCountSmallCategoryOfCardIdCategoryBig(String cardId,String categoryBig) {
        return memberMapper.selectCountSmallCategoryOfCardIdCategoryBig(cardId,categoryBig);
    }

    @Override
    public List<CardHistory> selectCountTimeOfCardId(String cardId) {
        return memberMapper.selectCountTimeOfCardId(cardId);
    }


    @Override
    public List<CardHistory> selectAllCardHistoryOfCardId(String cardId) {
        return memberMapper.selectAllCardHistoryOfCardId(cardId);
    }

    @Override
    public List<SafetyCard> selectAllSafetyCardOfCardId(String cardId) {
        return memberMapper.selectAllSafetyCardOfCardId(cardId);
    }

    @Override
    public void insertSafetySetting(SafetyCard safetyCard) {

    }

}