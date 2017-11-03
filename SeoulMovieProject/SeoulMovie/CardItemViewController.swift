//
//  CardItemViewController.swift
//  SeoulMovie
//
//  Created by leejaesung on 2017. 10. 30..
//  Copyright © 2017년 leejaesung. All rights reserved.
//

import UIKit
import Kingfisher

protocol CardDelegate {
    func removeCard(_ user: MovieClass)
    func moveToDetailView(_ user: MovieClass)
}

class CardItemViewController: UIViewController {

    @IBOutlet weak var imageViewNumber: UIImageView!
    @IBOutlet weak var imageViewMainPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var buttonMoveDetailView: UIButton!
    
    var movieData: MovieClass!
    var delegate: CardDelegate!
    var number: Int?
    
    /*******************************************/
    //MARK:-        LifeCycle                  //
    /*******************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelTitle.text = self.movieData.title
        self.labelPlace.text = self.movieData.place
        
        guard let realStartDate = self.movieData.startDate else { return }
        guard let realEndDate = self.movieData.endDate else { return }
        self.labelDate.text = realStartDate + " ~ " + realEndDate
        
        guard let realNumber = self.number else { return }
        self.imageViewNumber.image = UIImage(imageLiteralResourceName: "icon_letter\(realNumber)")
        
        // UI
        self.buttonMoveDetailView.layer.cornerRadius = self.buttonMoveDetailView.frame.size.height / 2
        
        // MainImage
        guard let realMainImage = self.movieData.mainImage else { return }
        self.imageViewMainPoster.kf.setImage(with: URL(string: realMainImage))
        
    }
    
    /*******************************************/
    //MARK:-         Functions                 //
    /*******************************************/
    func animateImage(){
        guard self.imageViewNumber != nil else {
            return
        }
        
        UIView.transition(with: self.imageViewNumber, duration: 0.5, options: .transitionFlipFromTop, animations: nil)
    }
    
    @IBAction func buttonMoveDetailViewAction(_ sender: UIButton) {
        self.delegate.moveToDetailView(self.movieData)
        
    }
    
}
