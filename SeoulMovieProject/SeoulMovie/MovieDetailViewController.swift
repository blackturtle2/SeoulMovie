//
//  MovieDetailViewController.swift
//  SeoulMovie
//
//  Created by leejaesung on 2017. 10. 30..
//  Copyright © 2017년 leejaesung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SafariServices

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var viewTableHeader: UIView!
    @IBOutlet weak var viewTableFooter: UIView!
    
    @IBOutlet weak var imageViewMainPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelGcode: UILabel!
    @IBOutlet weak var labelUserTarget: UILabel!
    @IBOutlet weak var labelUseFee: UILabel!
    @IBOutlet weak var labelSponsor: UILabel!
    @IBOutlet weak var labelInquiry: UILabel!
    @IBOutlet weak var labelEtcDesc: UILabel!
    
    @IBOutlet weak var labelContent: UILabel!
    
    var data:MovieDetailClass?
    var cultCode:Int?
    
    /*******************************************/
    //MARK:-        LifeCycle                  //
    /*******************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.tableViewMain.delegate = self
        self.tableViewMain.dataSource = self

        guard let realCultCode = self.cultCode else { return }
        
        // 서울시 문화행사 정보 API ( 문화행사코드를 매개변수로 받아 문화행사 상세정보 검색 )
        // http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-135
        Alamofire.request("http://openAPI.seoul.go.kr:8088/4f73734e4a626c61333849614c5153/json/SearchConcertDetailService/1/24/\(realCultCode)/", method: HTTPMethod.get, parameters: nil, headers: nil).responseJSON {[unowned self] (response) in
                
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print("///// json- 7834: \n", json)
                    let rawData = json["SearchConcertDetailService"]["row"]
                    print("///// rawData- 7834: \n", rawData)
                    
                    for jsonItem in rawData.arrayValue {
                        let movieDetailData = MovieDetailClass(idCultCode: jsonItem["CULTCODE"].intValue,
                                                         title: jsonItem["TITLE"].stringValue,
                                                         startDate: jsonItem["STRTDATE"].stringValue,
                                                         endDate: jsonItem["END_DATE"].stringValue,
                                                         place: jsonItem["PLACE"].stringValue,
                                                         mainImage: jsonItem["MAIN_IMG"].stringValue,
                                                         time: jsonItem["TIME"].stringValue,
                                                         gcode: jsonItem["GCODE"].stringValue,
                                                         userTarger: jsonItem["USE_TRGT"].stringValue,
                                                         useFee: jsonItem["USE_FEE"].stringValue,
                                                         sponsor: jsonItem["SPONSOR"].stringValue,
                                                         inquiry: jsonItem["INQUIRY"].stringValue,
                                                         etcDesc: jsonItem["ETC_DESC"].stringValue,
                                                         content: jsonItem["CONTENTS"].stringValue,
                                                         program: jsonItem["PROGRAM"].stringValue,
                                                         orgLink: jsonItem["ORG_LINK"].stringValue)
                        self.data = movieDetailData
                    }
                    
                    guard let realData = self.data else { return }
                    print("///// self.data- 9384: \n", realData)
                    
                    DispatchQueue.main.async {
                        self.labelTitle.text = realData.title
                        self.labelStartDate.text = realData.startDate
                        self.labelEndDate.text = " ~ " + realData.endDate
                        self.labelPlace.text = realData.place
                        self.labelTime.text = realData.time
                        self.labelGcode.text = realData.gcode
                        self.labelUserTarget.text = realData.userTarger
                        self.labelUseFee.text = realData.useFee
                        self.labelSponsor.text = realData.sponsor
                        self.labelInquiry.text = realData.inquiry
                        self.labelEtcDesc.text = realData.etcDesc
                        
                        var strContent = ""
                        if realData.content != "" && realData.content != "-" && realData.content != " " {
                            strContent += realData.content + "\n\n"
                        }
                        if realData.etcDesc != "" && realData.etcDesc != "-" && realData.etcDesc != " " {
                            strContent += realData.etcDesc + "\n\n"
                        }
                        if realData.program != "" && realData.program != "-" && realData.program != " " {
                            strContent += realData.program + "\n\n"
                        }
                        self.labelContent.text = strContent
                        
                        guard let realMainImage = realData.mainImage else { return }
                        self.imageViewMainPoster.kf.setImage(with: URL(string: realMainImage))
                        
                        self.resizeTableHeaderView()
                        self.tableViewMain.reloadData()
                    }
                    
                case .failure(let error):
                    print("///// error- 7834: \n", error)
                }
                
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*******************************************/
    //MARK:-         Functions                 //
    /*******************************************/
    // MARK: 테이블헤더 뷰 리사이즈
    func resizeTableHeaderView() {
        self.tableViewMain.tableHeaderView?.layoutIfNeeded()
        if let headerView = self.tableViewMain.tableHeaderView {
            // 테이블헤더 뷰에 데이터를 입력한 후, 헤더뷰의 높이를 재조정합니다.
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                self.tableViewMain.tableHeaderView = headerView
            }
        }
    }
    
    // MARK: 인앱웹뷰(SFSafariView) 열기 function 정의
    // `SafariServices`의 import가 필요합니다.
    func openSafariViewOf(url:String) {
        guard let realURL = URL(string: url) else { return }
        
        // iOS 9부터 지원하는 `SFSafariViewController`를 이용합니다.
        let safariViewController = SFSafariViewController(url: realURL)
        //        safariViewController.delegate = self // 사파리 뷰에서 `Done` 버튼을 눌렀을 때의 액션 정의를 위한 Delegate 초기화입니다.
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: 검색 엔진 function
    func openSearchEngineOf(keyword: String, google: Bool, naver: Bool, daum: Bool) {
        let strKeyword = "영화 " + keyword
        guard let realKeyword = strKeyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        if google {
            self.openSafariViewOf(url: "https://www.google.co.kr/search?q=\(realKeyword)")
        }else if naver {
            self.openSafariViewOf(url: "http://search.naver.com/search.naver?query=\(realKeyword)")
        }else if daum {
            self.openSafariViewOf(url: "http://search.daum.net/search?q=\(realKeyword)")
        }
    }
    
    // MARK: 다음 지도 검색 function
    func openSearchDaumMapOf(keyword: String) {
        guard let realKeyword = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        self.openSafariViewOf(url: "https://m.map.daum.net/actions/searchView?q=\(realKeyword)")
    }

}

/*******************************************/
//MARK:-         extenstion                //
/*******************************************/
// MARK: extension - UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 터치한 표시를 제거하는 액션
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: //moveWebsiteCell
                print("///// select moveWebsiteCell- 0001\n")
                guard let realURL = self.data?.orgLink else { return }
                self.openSafariViewOf(url: realURL)
            case 1: //callInquiryCell
                print("///// select callInquiryCell- 0001\n")
                guard let realInquiry = self.data?.inquiry else { return }
                guard let url = URL(string: "tel://02\(realInquiry)") else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
                
            case 2: //findPlaceMapCell
                print("///// select findPlaceMapCell- 0001\n")
                guard let realPlace = self.data?.place else { return }
                self.openSearchDaumMapOf(keyword: realPlace)
            default:
                print("///// select default- 0001\n")
            }
        case 1:
            guard let realKeyword = self.data?.title else { return }
            
            switch indexPath.row {
            case 0: //searchGoogleCell
                print("///// select searchGoogleCell- 0001\n")
                self.openSearchEngineOf(keyword: realKeyword, google: true, naver: false, daum: false)
            case 1: //searchNaverCell
                print("///// select searchNaverCell- 0001\n")
                self.openSearchEngineOf(keyword: realKeyword, google: false, naver: true, daum: false)
            case 2: //searchDaumCell
                print("///// select searchDaumCell- 0001\n")
                self.openSearchEngineOf(keyword: realKeyword, google: false, naver: false, daum: true)
            default:
                print("///// select default- 0001\n")
            }
        default:
            print("///// select default- 0001\n")
        }

        
    }
}

// MARK: extension - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    // MARK: TableView- numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: TableView- numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    // MARK: TableView- titleForHeaderInSection
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return " "
//    }
    
    // MARK: TableView- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let myCell = tableView.dequeueReusableCell(withIdentifier: "moveWebsiteCell", for: indexPath)
                return myCell
            case 1:
                let myCell = tableView.dequeueReusableCell(withIdentifier: "callInquiryCell", for: indexPath)
                
                if let realInquiry = self.data?.inquiry {
                    myCell.detailTextLabel?.text = "02-" + realInquiry
                }
                
                return myCell
            case 2:
                let myCell = tableView.dequeueReusableCell(withIdentifier: "findPlaceMapCell", for: indexPath)
                if let realGCode = self.data?.gcode {
                    myCell.detailTextLabel?.text = realGCode
                }
                
                return myCell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                let myCell = tableView.dequeueReusableCell(withIdentifier: "searchGoogleCell", for: indexPath)
                return myCell
            case 1:
                let myCell = tableView.dequeueReusableCell(withIdentifier: "searchNaverCell", for: indexPath)
                return myCell
            case 2:
                let myCell = tableView.dequeueReusableCell(withIdentifier: "searchDaumCell", for: indexPath)
                return myCell
            default:
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
        }
    }
    
}
