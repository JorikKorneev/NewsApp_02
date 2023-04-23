//
//  ViewController.swift
//
//  Created by admin on 20.04.2023.
//

import UIKit
import Foundation


protocol NetworkServiceDelegate: AnyObject {
    func didUpdateData()
}

class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    var NewsData: [Article] = []
    
    //Retrieve data by URL
    func fetchData() {

        print("111")

        let URLadress = "https://newsapi.org/v2/everything?"
        let URL = URL(string: URLadress)

        var URLcomponents = URLComponents(url: URL!, resolvingAgainstBaseURL: false)

        URLcomponents?.queryItems = [
            URLQueryItem(name: "q", value: "news"),
            URLQueryItem(name: "sortBy", value: "date"),
            //URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "apiKey", value: "67f14e5c6d504d399e065f80d785d53a")
        ]

        var request = URLRequest(url: (URLcomponents?.url)!)
        request.httpMethod = "GET"

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                guard let data = data,
                      let response = response as? HTTPURLResponse
                        
                else { return }
                self.parsJSON(withData: data) // Call JSON parsing
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData() // Update data in the table

                }
                print("Status Code: \(response.statusCode)")
            }
            
        }
        .resume()
    }

    
    // Parsing JSON
    func parsJSON (withData  data: Data)  {
        
        let decoder = JSONDecoder()
        do {
            let parsData = try decoder.decode(NewsItem.self, from: data)
            guard let articles = parsData.articles else { return }
            NewsData = articles
            NewsData = NewsData.filter { $0.source.id != "google-news" }
            //агрегатор гугла не корректно отображался, отфильтровал его из массива

            
        } catch  let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
}
    
    
    
  
