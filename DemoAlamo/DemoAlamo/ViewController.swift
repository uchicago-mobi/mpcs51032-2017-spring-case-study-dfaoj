//
//  ViewController.swift
//  DemoAlamo
//
//  Created by Dan Olsen on 5/22/17.
//  Copyright © 2017 olsen.me. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBAction func newRequest(_ sender: Any) {
        
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            
            //Print header
            print("MAKING A REQUEST")
            
            //Print original URL request
            print("URL REQUEST: \(response.request!)")
            
            //Print HTTP URL response
            print("URL RESPONSE: \(response.response!)")
            
            //Print server data
            print("SERVER DATA: \(response.data!)")
            
            //Print result of response serialization
            print("RESULT: \(response.result)")
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    @IBAction func newResponse(_ sender: Any) {
        Alamofire.request("https://httpbin.org/get").responseData { response in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }

    @IBAction func newJSON(_ sender: Any) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    @IBAction func newValidation(_ sender: Any) {
        
        //Success
        if randomBool() {
            print("REQUESTING VALID HTTP REQUEST")
            Alamofire.request("https://httpbin.org/get").validate().responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
            }
        }
        //Failed
        else {
            print("REQUESTING BROKEN HTTP REQUEST")
            Alamofire.request("https://google.com/get").validate().responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    @IBAction func newHeader(_ sender: Any) {
        
        //Your headers
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        
        //The request
        Alamofire.request("https://httpbin.org/headers", headers: headers).responseJSON { response in
            print("HEADERS")
            debugPrint(response)
        }
    }
    
    @IBAction func newAuth(_ sender: Any) {
        
        //Your credentials
        let user = "user"
        let password = "password"
        
        print("AUTHENTICATION")
        
        //The request
        Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(user: user, password: password)
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
    //https://stackoverflow.com/a/34241495
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

