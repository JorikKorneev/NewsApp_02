//
//  ViewController.swift
//  YanPractice23.03
//
//  Created by admin on 23.03.2023.
//

import UIKit
import Foundation


protocol NetworkServiceDelegate: AnyObject {
    func didUpdateData()
}

class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    var NewsData: [Article] = []
    
    //Получаем данные по URL
    func fetchData() {

        print("1")

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
                self.parsJSON(withData: data) // Вызываем парсинг JSONa
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData() // Обновляем данные в таблице

                }
                print("Status Code: \(response.statusCode)")
            }
            
        }
        .resume()
    }

    
    // Парсим JSON
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
    
    
    
    
    
    //var inputArray: [String] = ["23jsdv", "654khjb", "7jhb", "jhwc9"]
    //var sortArray: [Int : String] = [:]
    //var indices: [Int] = []
    //
    //while let line = readLine() {
    //    inputArray.append(line)
    //}
    //
    //for elements in inputArray {
    //
    //    var chars = String()
    //    var numbers = String()
    //
    //
    //    elements.forEach { char in
    //        if char.isNumber {
    //            numbers.append(char)
    //        } else {
    //            chars.append(char)
    //        }
    //    }
    //    indices.append(Int(numbers)!)
    //    sortArray[(Int(numbers)!)] = chars
    //}
    //
    //let sortIndices = indices.sorted()
    //
    //for i in sortIndices {
    //    print(sortArray[i]!)
    //}
    //   ..................
    
    //var sortArray: [Int : String] = [:]
    //var indices = 0
    //
    //while let line = readLine() {
    //    indices += 1
    //    let myChars = line.filter { $0.isLetter }
    //    let myNumbers = line.filter { $0.isNumber }
    //    sortArray[Int(myNumbers)!] = myChars
    //}
    //for i in 1...indices {
    //    print(sortArray[i]!)
    //}
    
    
    
    
    
    //
    ////                    import Foundation
    //
    //    // Создаем пустой словарь для хранения строк и индексов.
    //    var arStr2 = [Int: String]()
    //    // Объявляем переменные для хранения числовых и строковых значений.
    //    var intStr = ""
    //    var str: String
    //
    //    // Начинаем бесконечный цикл, который будет считывать ввод с консоли.
    //    while let input = readLine() {
    //        // Если ввод не равен "null", то продолжаем выполнение кода.
    //        if input != "null" {
    //            // Итерируемся по каждому символу ввода.
    //            for char in input {
    //                // Если символ является числом, то добавляем его к переменной intStr.
    //                if char.isNumber {
    //                    intStr.append(char)
    //                }
    //            }
    //            // Удаляем из строки все числа, используя регулярное выражение.
    //            str = input.replacingOccurrences(of: "\\d", with: "", options: .regularExpression)
    //            // Преобразуем intStr в число и вычитаем 1, чтобы получить индекс.
    //            arStr2[Int(intStr)! - 1] = str
    //            // Сбрасываем значение intStr.
    //            intStr = ""
    //        } else {
    //            // Если ввод равен "null", то прерываем цикл.
    //            break
    //        }
    //    }
    //
    //    // Итерируемся по каждому индексу в словаре и выводим соответствующее значение на консоль.
    //    for i in 0..<arStr2.count {
    //        print(arStr2[i]!)
    //    }
    
    //}

