//
//  ProductDetailsViewController.swift
//  ShopIt
//
//  Created by Krystian Gontarek on 17.10.2015.
//  Copyright © 2015 KreskowDev. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    var product : Product? = nil

    @IBOutlet weak var productNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLabel.text = product?.productName
    }

}
