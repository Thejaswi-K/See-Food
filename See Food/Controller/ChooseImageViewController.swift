//
//  ChooseImageViewController.swift
//  See Food
//
//  Created by Thejaswi Kampalli on 5/28/20.
//  Copyright © 2020 Thejaswi Kampalli. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ChooseImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum ToolBarButtonType: Int {
        case camera = 0, albums
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var clear: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var identifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        clear.isEnabled = false
        identifyButton.isEnabled = false
        identifyButton.isEnabled = false
    }

    @IBAction func presentImagePickerView(_ sender: UIBarButtonItem) {
        switch(ToolBarButtonType(rawValue: sender.tag)!){
        case .camera:
            let cameraView = UIImagePickerController()
            cameraView.delegate = self
            cameraView.sourceType = .camera
            self.present(cameraView, animated: true, completion: nil)
        case .albums:
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        if imageView.image != nil {
            let alert = UIAlertController(title: "Discard" , message: "Are you sure you want to discard the image?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
                self.imageView.image = nil
                self.clear.isEnabled = false
                self.identifyButton.isEnabled = false
            }
            let no  = UIAlertAction(title: "No", style: .default, handler: nil)
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func identify(_ sender: Any) {
        guard let ciImage = CIImage(image: imageView.image!) else {
            print("failed converting UIImage.image to CIImage")
            return
        }
        
        guard let model = try? VNCoreMLModel(for: Food101().model) else {
            print("Loading CoreML model failed")
            return
        }
        
        let request = VNCoreMLRequest(model: model, completionHandler: {(request, error) in
            DispatchQueue.main.async {
                guard let results = request.results as? [VNClassificationObservation] else {
                    print("Model failed to process image")
                    return
                }
                
                if let firstResult = results.first {
                    let resultDetailViewController = self.storyboard?.instantiateViewController(identifier: "resultDetailView") as! ResultDetailViewController
                    resultDetailViewController.uiImage = self.imageView.image
                    resultDetailViewController.classificationResult = firstResult.identifier.replacingOccurrences(of: "_", with: " ").capitalized
                    self.navigationController?.pushViewController(resultDetailViewController, animated: true)
                }
                self.imageView.image = nil
                self.clear.isEnabled = false
                self.identifyButton.isEnabled = false
            }
         })
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage)
            
            do {
                try handler.perform([request])
            } catch {
                print("error handling CVRequest")
            }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        clear.isEnabled = true
        identifyButton.isEnabled = true
        picker.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

