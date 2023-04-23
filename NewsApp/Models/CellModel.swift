//
//  CellModel.swift
//
//  Created by admin on 20.04.2023.
//
// Custom cell model
import UIKit

class NewsCell:  UITableViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var tapCounter = 0 // счетчик
    
    func configure (with Article: Article) {
        countLabel.text = String(tapCounter) // счетчик
        newsImage.image = UIImage(named: "noPhotoImage")
        newsImage.layer.cornerRadius = 8
        newsImage.contentMode = .scaleAspectFill
        
        newsTitleLabel.text = Article.title
        
        
        
        DispatchQueue.global().async {
            guard let URLlink = Article.urlToImage else { return }
            
            guard let imageURL = URL(string:URLlink) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                
                self.newsImage.image = UIImage(data: imageData)
            }
            
        }
        
    }
    func incrementCounter() {// счетчик
        tapCounter += 1
        countLabel.text = String(tapCounter)
    }
}
 
