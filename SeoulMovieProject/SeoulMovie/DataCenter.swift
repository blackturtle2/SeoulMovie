//
//  DataCenter.swift
//  SeoulMovie
//
//  Created by leejaesung on 2017. 10. 30..
//  Copyright © 2017년 leejaesung. All rights reserved.
//

import Foundation

struct MovieClass {
    
    var number: Int
    var idCultCode: Int // 문화행사코드
    var subjcode: Int // 장르분류코드
    var codeName: String? // 장르분류명
    var title: String? // 제목
    var startDate: String? // 시작일자
    var endDate: String? // 종료일자
    var place: String? // 장소
    var mainImage: String? // 대표이미지
    
    init(number: Int, idCultCode: Int, subjcode: Int, codeName: String, title: String, startDate: String, endDate: String, place: String, mainImage: String?) {
        self.number = number
        self.idCultCode = idCultCode
        self.subjcode = subjcode
        self.codeName = codeName
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.place = place
        self.mainImage = mainImage
    }
    
    init(numberData: Int, dicData: [String:Any]) {
        self.number = numberData
        self.idCultCode = dicData["CULTCODE"] as! Int
        self.subjcode = dicData["SUBJCODE"] as! Int
        self.codeName = dicData["CODENAME"] as? String ?? ""
        self.title = dicData["TITLE"] as? String ?? ""
        self.startDate = dicData["STRTDATE"] as? String ?? ""
        self.endDate = dicData["END_DATE"] as? String ?? ""
        self.place = dicData["PLACE"] as? String ?? ""
        self.mainImage = dicData["MAIN_IMG"] as? String ?? ""
    }
    
}

struct MovieDetailClass {
    var idCultCode: Int // 문화행사코드
    var title: String // 제목
    var startDate: String // 시작일자
    var endDate: String // 종료일자
    var place: String // 장소
    var mainImage: String? // 대표이미지
    
    var time: String
    var gcode: String
    var userTarger: String
    var useFee: String
    var sponsor: String
    var inquiry: String
    var etcDesc: String
    var content: String
    var program: String
    
    var orgLink: String

}

