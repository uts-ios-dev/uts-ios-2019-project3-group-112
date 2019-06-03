
import UIKit

class WiKiViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var text: String?
    var sImage : UIImage?
    override func viewDidLoad() {
        var text2 = self.text
    
        text2 = text2?.replacingOccurrences(of: " ", with: "_")
        super.viewDidLoad()
        let urlt = URL(string: "http://en.wikipedia.org/wiki/\(text2!)")
        let requestt = URLRequest(url: (urlt)!)
        webView.loadRequest(requestt)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
