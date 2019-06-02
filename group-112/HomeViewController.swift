

import UIKit
import CoreML
import Vision
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoText: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var classificationResults : [VNClassificationObservation] = []
    
    let imagePicker = UIImagePickerController()
    var searchResult: String?
    var sImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.saveScore(playerName: "11111")
        imagePicker.delegate = self
        
    }
    
    func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        //send a request to the ML model and get back all the results
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                // get the first result from the result list, the first one has the highest confidence
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
                }
            

            self.navigationItem.title = topResult.identifier.components(separatedBy: ",").first;
            self.searchResult = topResult.identifier.components(separatedBy: ",").first

            self.navigationController?.navigationBar.isTranslucent = false
            
            let sImage = self.sImage
            
            let imageData = sImage?.pngData()
            
            
            
            //save the first result text to core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveResult(sDesc: self.searchResult!, sImage: imageData!)
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do { try handler.perform([request]) }
        catch { print(error) }
    }
    
    //use imagePicker to pick the image for passing to ML model
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //orginalImage comes from taken photo or album
        if let image = info[.originalImage] as? UIImage {
                    
            imageView.image = image
            
            self.sImage = image
            
            imagePicker.dismiss(animated: true, completion: nil)
            
            //convert the image that user picked to a ciImage
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            
            detect(image: ciImage)
            photoText.text = ""
            
        }
    }
        

    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //pass the result to wiki page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWikiView" {
            let wikiView = segue.destination as! WiKiViewController
            
            wikiView.text = self.searchResult
            
            
        }
    }
   
}
 
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
