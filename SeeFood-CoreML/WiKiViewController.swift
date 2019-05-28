//
//  WiKiViewController.swift
//  SeeFood-CoreML
//
//  Created by Justin Huang on 27/5/19.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WiKiViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var text: String?
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
