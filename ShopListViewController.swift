//
//  ShopListViewController.swift
//  ShopIt App
//
//  Created by Krystian "Kreskow" Gontarek on 16.10.2015.
//  Copyright © 2015 KreskowDev. All rights reserved.
//

import UIKit
import CoreData

class ShopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shoppingList : [Product] = []
    var selectedProduct : Product? = nil

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
            self.tableView.delegate = self
            self.tableView.dataSource = self
        
            // Design stuff
            self.tableView.backgroundColor = UIColor(red: 0, green: 0.7255, blue: 0.949, alpha: 1.0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let context = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        let request = NSFetchRequest(entityName: "Product")
        let results = try? context?.executeFetchRequest(request)
        
        if results != nil {
            self.shoppingList = results as! [Product]
        }
        
        createTestProducts()
        try! context!.save()
        self.tableView.reloadData()
    }
    
    func createTestProducts () {
        let context = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        let product = NSEntityDescription.insertNewObjectForEntityForName("Product", inManagedObjectContext: context!) as! Product
        product.productName = "Test123"
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        // Design stuff
        self.selectedProduct = shoppingList[indexPath.row]
        cell.backgroundColor = UIColor(red: 0, green: 0.7255, blue: 0.949, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        // Code stuff
        cell.textLabel?.text = selectedProduct!.productName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("shopListToDetailsSegue", sender: self)
        print(self.selectedProduct?.productName)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "shopListToDetailsSegue") {
            let detailVC = segue.destinationViewController as? ProductDetailsViewController
            detailVC?.product = self.selectedProduct
        }
    }
    
}

