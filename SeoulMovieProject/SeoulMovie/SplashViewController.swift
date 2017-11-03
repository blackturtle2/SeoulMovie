//
//  SplashViewController.swift
//  SeoulMovie
//
//  Created by leejaesung on 2017. 10. 30..
//  Copyright © 2017년 leejaesung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster

class SplashViewController: UIViewController {
    
    var data: [MovieClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // 서울시 문화행사정보 장르별 검색
        // http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-139&tMenu=11
        Alamofire.request(
            "\(JSsecretKey.rootDomain)/\(JSsecretKey.MyKey)/json/SearchPerformanceBySubjectService/1/9/18/", method: HTTPMethod.get, parameters: nil, headers: nil).responseJSON { (response) in
                print("///// response- 4123: \n", response)
                
                switch response.result {
                case .success(let value):
                    print("///// response.success.value- 4123: \n", value)
                    
                    let json = JSON(value)
                    let rawData = json["SearchPerformanceBySubjectService"]["row"]
                    
                    for jsonItem in rawData.arrayValue {
                        let movieData = MovieClass(number: 0,
                                                   idCultCode: jsonItem["CULTCODE"].intValue,
                                                   subjcode: jsonItem["SUBJCODE"].intValue,
                                                   codeName: jsonItem["CODENAME"].stringValue,
                                                   title: jsonItem["TITLE"].stringValue,
                                                   startDate: jsonItem["STRTDATE"].stringValue,
                                                   endDate: jsonItem["END_DATE"].stringValue,
                                                   place: jsonItem["PLACE"].stringValue,
                                                   mainImage: jsonItem["MAIN_IMG"].stringValue)
                        self.data.append(movieData)
                    }
                    print("///// self.data- 9384: \n", self.data)
                    
                    
                    DispatchQueue.main.async {
                        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                        nextVC.data = self.data
                        let motherVC = UINavigationController(rootViewController: nextVC)
//                        motherVC.navigationBar.backgroundColor = UIColor.black
                        
                        self.present(motherVC, animated: true, completion: nil)
                        
                    }
                    
                case .failure(let error):
                    print("///// error- 4123: \n", error)
                }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
