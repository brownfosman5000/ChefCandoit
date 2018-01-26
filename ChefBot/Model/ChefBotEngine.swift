    //
//  ChefBotEngine.swift
//  ChefBot
//
//  Created by Foster Brown on 1/25/18.
//  Copyright © 2018 Foster Brown. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
    
protocol GetFoodDelegate {
    func requestFoodInfo(message: String)
}
class ChefBotEngine {

    
    let webURL: String = "http://www.recipepuppy.com/api/"
    private var message: String?
    private var ingredients: String = ""
    private var title: String = ""
    private var foodName = ""
    var delegate: GetFoodDelegate?
    


    //Just some abstraction okayyy
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
                self.message = "Problem Connecting to the Internet"
            }
        })
    }
    
    // Get Recipe title, ingredients from the JSON
    private func getRecipeData(json: JSON){
        ingredients = (json["results"][0]["ingredients"]).stringValue
        title = (json["results"][0]["title"]).stringValue
        message = "Inside " + title + " there is " + ingredients
        delegate?.requestFoodInfo(message: message!)
    }
    
    
    
    

}
    
