//
//  ImportImageViewController.swift
//  SeeFood-CoreML
//
//  Created by 吳姵瑩 on 28/5/19.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Social

class ImportImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var searchResult:String?
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image,animated: true)
        {
            
        }
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            myImageView.image = image
            
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            
            detect(image: ciImage)
            
        } else {
            // Error message
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            //                if topResult.identifier.contains("hotdog") {
            //                    DispatchQueue.main.async {
            self.navigationItem.title = topResult.identifier.components(separatedBy: ",").first;
            self.searchResult = topResult.identifier.components(separatedBy: ",").first
            //            self.navigationController?.navigationBar.barTintColor = UIColor.green
            self.navigationController?.navigationBar.isTranslucent = false

        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do { try handler.perform([request]) }
        catch { print(error) }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWikiView" {
            let wikiView = segue.destination as! WiKiViewController
            
            wikiView.text = self.searchResult
        }
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
