//
//  MainViewController.swift
//  SeoulMovie
//
//  Created by leejaesung on 2017. 10. 30..
//  Copyright © 2017년 leejaesung. All rights reserved.
//

import UIKit
import Alamofire
import PageControl
import SwiftyJSON
import Toaster

class MainViewController: UIViewController {
    
    var pageController: PageControlViewController!
    var data: [MovieClass]?
    var dataController: [UIViewController] = []
    
    @IBOutlet weak var containerView: UIView!
    
    
    /*******************************************/
    //MARK:-        LifeCycle                  //
    /*******************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("///// prepare()- 9836 \n")
        if let controller = segue.destination as? PageControlViewController {
            self.pageController = controller
            self.pageController.delegate = self
            self.pageController.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("///// viewDidLoad()- 9362 \n")
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.red
        
        var count = 1
        guard let realData = self.data else { return }
        for i in realData {
            let vc = CardItemViewController()
            vc.movieData = i
            vc.number = count
            count += 1
            vc.delegate = self
            self.dataController.append(vc)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /*******************************************/
    //MARK:-         Functions                 //
    /*******************************************/
    
}
    

/*******************************************/
//MARK:-         extenstion                //
/*******************************************/
extension MainViewController: CardDelegate {
    func moveToDetailView(_ user: MovieClass) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        nextVC.cultCode = user.idCultCode
        self.navigationController?.pushViewController(nextVC, animated: true)

        self.pageController.refresh = false // '자세히 보기' 뷰에서 다시 메인으로 돌아왔을 때의 리프레시 방지 코드.
    }
    
    
    func removeCard(_ user: MovieClass) {
        guard var realData = self.data else { return }
        for position in 0..<realData.count {
            let dataUser = realData[position]
            if dataUser.codeName == user.codeName {
                realData.remove(at: position)
                self.dataController.remove(at: position)
                break
            }
        }
        self.pageController.updateData()
    }

}


extension MainViewController: PageControlDelegate {
    
    func pageControl(_ pageController: PageControlViewController, atSelected viewController: UIViewController) {
        (viewController as! CardItemViewController).animateImage()
        
        if (viewController as! CardItemViewController).number == self.dataController.count {
            print("///// last viewController- 5223\n")
        }
    }
    
    func pageControl(_ pageController: PageControlViewController, atUnselected viewController: UIViewController) {
        
    }
    
}

extension MainViewController: PageControlDataSource {
    
    func numberOfCells(in pageController: PageControlViewController) -> Int {
        return self.dataController.count
    }
    
    func pageControl(_ pageController: PageControlViewController, cellAtRow row: Int) -> UIViewController! {
        return self.dataController[row]
    }
    
    func pageControl(_ pageController: PageControlViewController, sizeAtRow row: Int) -> CGSize {
        let width = pageController.view.bounds.size.width - 50
        let height = pageController.view.bounds.size.height
        if row == pageController.currentPosition {
            return CGSize(width: width, height: height)
        }
        return CGSize(width: width, height: height)
    }
    
}

