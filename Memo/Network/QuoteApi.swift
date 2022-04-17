//
//  QuoteApi.swift
//  Memo
//
//  Created by Markus Nivasalo on 13.4.2022.
//
//  API class for retrieving the daily quote for the home page
//

import Foundation
import SwiftyJSON
import Alamofire

class QuoteApi : ObservableObject {
    @Published var dailyQuote : String = ""
    @Published var dailyAuthor : String = ""
    
    func callAPI() {
        let url = URL(string: "https://zenquotes.io/api/today/")!
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let quote = json[0]["q"].string {
                    self.dailyQuote = quote
                    print(self.dailyQuote)
                }
                if let author = json[0]["a"].string {
                    self.dailyAuthor = author
                    print(self.dailyAuthor)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

