//
//  RowViewController.swift
//  See Food
//
//  Created by Thejaswi Kampalli on 5/28/20.
//  Copyright © 2020 Thejaswi Kampalli. All rights reserved.
//

import UIKit
import CoreData

class RowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var managedObjectContext: NSManagedObjectContext!
    var foodItems = [FoodItem]()
    @IBOutlet weak var foodItemsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        foodItemsTable.delegate = self
        foodItemsTable.dataSource = self
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
    }
    
    func loadData() {
        let foodRequest:NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        do {
            foodItems = try managedObjectContext.fetch(foodRequest)
            self.foodItemsTable.reloadData()
        } catch {
            print("could not load data from database")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowViewCell", for: indexPath) as! RowItemViewCell
        let foodItem = foodItems[(indexPath as NSIndexPath).row]
        cell.imgView?.image = UIImage(data: foodItem.img!)
        cell.titleLabel!.text = foodItem.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            managedObjectContext.delete(foodItems[indexPath.row])
            foodItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try managedObjectContext.save()
            } catch {
                print("Failed to delete")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let savedDetailViewController = storyboard?.instantiateViewController(identifier: "savedDetailView") as! SavedDetailViewController
        let foodItem = foodItems[indexPath.item]
        savedDetailViewController.uiImage = UIImage(data: foodItem.img!)
        savedDetailViewController.classificationResult = foodItem.title
        savedDetailViewController.foodDescription = foodItem.foodDescription
        self.navigationController?.pushViewController(savedDetailViewController, animated: true)
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
