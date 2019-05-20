

//
//  ViewController2.swift
//  MapKitTutorial
//
//  Created by programming-xcode on 10/18/16.
//  Copyright © 2016 Thorn Technologies. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {
    
    //@IBOutlet weak var webView: UIWebView!
    @IBOutlet var webView: UIWebView!
    //@IBOutlet var searchBAR: UITextField!
    //@IBOutlet var searchbutton: UIButton!
    var text: String?
    
//    @IBAction func search(_ sender: AnyObject) {
//        let urlt = URL(string: "http://en.wikipedia.org/wiki/\(searchBAR.text!)")
//        let requestt = URLRequest(url: (urlt)!)
//        webView.loadRequest(requestt)
//    }
    
//    func search() {
//                let urlt = URL(string: "http://en.wikipedia.org/wiki/rule")
//                let requestt = URLRequest(url: (urlt)!)
//                webView.loadRequest(requestt)
//            }
    
    override func viewDidLoad() {
       var text2 = self.text
        text2 = text2?.replacingOccurrences(of: " ", with: "_")
        super.viewDidLoad()
        var wikitext = self.text
        let urlt = URL(string: "http://en.wikipedia.org/wiki/\(text2!)")
        let requestt = URLRequest(url: (urlt)!)
//        webView.loadRequest(requestt)
//        _ = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(WikiViewController.check), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
          webView.loadRequest(requestt)
        
    
    }
    
//    @objc func check() {
//        if searchBAR.text == "" {
//            searchbutton.isHidden = true
//        } else {
//            searchbutton.isHidden = false
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

