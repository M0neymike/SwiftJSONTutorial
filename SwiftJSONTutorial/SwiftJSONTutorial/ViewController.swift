//
//  ViewController.swift
//  SwiftJSONTutorial
//
//  Created by Jeffrey Wheeler on 3/19/18.
//  Copyright © 2018 Jeffrey Wheeler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //the json file url
    let URL_RANKS = "https://api.myjson.com/bins/xbi63";
    
    //A string array to save all the names
    var objects = [String]()
    
    //the label we create
    @IBOutlet var JSONLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //calling the function that will fetch the json
        getJsonFromUrl();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this function is fetching the json from URL
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: URL_RANKS)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj!.value(forKey: "ranks")!)
                
                //getting the ranks tag array from json and converting it to NSArray
                if let majorArray = jsonObj!.value(forKey: "ranks") as? NSArray {
                    //looping through all the elements
                    for major in majorArray{
                                
                                //adding the name to the array
                                self.objects.append((major as? String)!)
                            }
                            
                        }
                    }
            
            OperationQueue.main.addOperation({
                //calling another function after fetching the json
                //it will show the names to label
                self.showRanks()
            })
            
        }).resume()
    }
    func showRanks(){
        //looing through all the elements of the array
        for rank in objects{
            
            //appending the names to label
            JSONLabel.text = JSONLabel.text! + rank + "\n";
        }
    }
    
}

