//
//  SavedDetailViewController.swift
//  See Food
//
//  Created by Thejaswi Kampalli on 5/28/20.
//  Copyright © 2020 Thejaswi Kampalli. All rights reserved.
//

import UIKit

class SavedDetailViewController: UIViewController {
    
    var classificationResult: String?
    var uiImage: UIImage?
    var foodDescription: String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = classificationResult
        if let uiImage = uiImage {
            imageView?.image = uiImage
        }
        descriptionView.text = foodDescription!
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
