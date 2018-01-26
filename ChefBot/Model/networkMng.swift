//
//  networkMng.swift
//  ChefBot
//
//  Created by Foster Brown on 1/16/18.
//  Copyright © 2018 Foster Brown. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class NetworkingManager{
    
    var webURL: String = "http://www.recipepuppy.com/api/"
    var ingredients: String?
    var title: String?
    
    init(){
        
    }
    init(webURL: String){
        self.webURL = webURL
    }
    
    func initializeFoodInformation(foodName: String){
        getRecipeJSON(parameters: ["q" : foodName])
    }

    
    // Get the json from the webURL
    private func getRecipeJSON(parameters: [String:String]){
        Alamofire.request(webURL, parameters: parameters).responseJSON(completionHandler: { response in
            if response.result.isSuccess{
                print("Success got the JSON Data!!")
                let json = JSON(response.result.value!)
                self.getRecipeData(json: json)
            }
                
            else{
                print("Error: \(String(describing: response.error))")
            }
        })
    }
    
    // Get Recipe title, ingredients from the JSON
    private func getRecipeData(json: JSON){
        print(json["results"][0]["title"])
        ingredients = (json["results"][0]["ingredients"]).string
        print(ingredients)
        title = json["results"][0]["title"].string
        print(title)
        
    }
    
    
    
    
    
    
}
