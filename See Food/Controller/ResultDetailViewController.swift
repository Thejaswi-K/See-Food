//
//  ResultDetailViewController.swift
//  See Food
//
//  Created by Thejaswi Kampalli on 5/28/20.
//  Copyright © 2020 Thejaswi Kampalli. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class ResultDetailViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext!
    
    var classificationResult: String?
    var uiImage: UIImage?
    
    
    @IBOutlet weak var descriptionView: UITextView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        DispatchQueue.main.async {
            self.requestInfo(itemName: self.classificationResult!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = classificationResult
        if let uiImage = uiImage {
            imageView?.image = uiImage
        }
//        descriptionView.text = foodDescription
    }
    
    @IBAction func saveItem(_ sender: Any) {
        createItem(img: uiImage!)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func createItem(img image: UIImage) {
        let foodItem = FoodItem(context: managedObjectContext)
        let jpg = image.jpegData(compressionQuality: 0.3)
        //let foodItem = NSEntityDescription.insertNewObject(forEntityName: "FoodItem", into: managedObjectContext) as! FoodItem
        foodItem.img = jpg
        foodItem.title = self.classificationResult
        foodItem.foodDescription = self.descriptionView.text
        do {
            try self.managedObjectContext.save()
            print("\(foodItem.title!) saved")
        } catch {
            print("failed saving data")
        }
    }
    
    func requestInfo(itemName: String) {
        let wikipediaURL = "https://en.wikipedia.org/w/api.php"
        let parameters: [String: String] = [
            "format": "json",
            "action": "query",
            "prop":"extracts",
            "exintro": "",
            "explainext": "",
            "titles": itemName,
            "indexpageids": "",
            "redirects": "1"
        ]
        AF.request(wikipediaURL, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let responseJSON: JSON = JSON(value)
                    let pageID = responseJSON["query"]["pageids"][0].stringValue
                    print("Response from API: \(responseJSON["query"]["pages"][pageID]["extract"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))")
                    self.descriptionView.text = responseJSON["query"]["pages"][pageID]["extract"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                case .failure(let error):
                    print("failed to get intro section: \(error)")
            }
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
