//
//  DetailViewController.swift
//
//  Created by admin on 20.04.2023.
//


import UIKit


class DetailView: UIViewController {
    
    var article: Article?
    
    
    @IBOutlet weak var viewTitle: UINavigationItem!
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailDateLabel: UILabel!
    
    @IBOutlet weak var detailSourseLabel: UILabel!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var detailDiscriptLabel: UILabel!
    
    @IBOutlet weak var detailGoButton: UIButton!
    
    var urlWeb = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataForDetailVC()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func detailButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "webSegue", sender: self)
    }
    
    
    
    
    
    
    
    func dataForDetailVC() {
        if let selectArticle = article {
            print("артикль пришёл")
            print(selectArticle.publishedAt)
            detailTitleLabel.text = selectArticle.title
            detailDateLabel.text = formatData(dateString: selectArticle.publishedAt)
            viewTitle.title = selectArticle.source.name
            
            detailDiscriptLabel.text = selectArticle.description
            detailSourseLabel.text = selectArticle.author ?? selectArticle.source.name
            urlWeb = selectArticle.url
            
            if selectArticle.urlToImage == nil {
                detailImageView.image = UIImage(named: "noPhotoImage")
            } else {
                DispatchQueue.global().async {
                    let URLlink = selectArticle.urlToImage
                    guard let imageURL = URL(string:URLlink!) else { return }
                    guard let imageData = try? Data(contentsOf: imageURL) else { return }
                    DispatchQueue.main.async {
                        
                        self.detailImageView.image = UIImage(data: imageData)
                    }
                    
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webSegue" {
            if let WebVC = segue.destination as? WebView {
                WebVC.urlWeb = urlWeb
            }
        }
    }
    
    func formatData(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }


}

