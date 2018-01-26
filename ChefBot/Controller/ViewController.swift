//
//  ViewController.swift
//  ChefBot
//
//  Created by Foster Brown on 1/16/18.
//  Copyright © 2018 Foster Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GetFoodDelegate {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var botResponse: UILabel!
    
    var botText: String!
    let bot: ChefBotEngine = ChefBotEngine()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bot.delegate = self
    }
        
    
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func ask(_ sender: UIButton){
        if let food = messageField.text{
            bot.initializeFoodInformation(foodName: food)
        }
        else{
            botResponse.text = "I cannot find the food requested "
        }
    }
    
    func requestFoodInfo(message: String) {
        botText = message
        print(botText)
        botResponse.text = message
    }
 
    
    //Close keyboard when touched anywhere on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        messageField.resignFirstResponder()
}

    
    

    


}

