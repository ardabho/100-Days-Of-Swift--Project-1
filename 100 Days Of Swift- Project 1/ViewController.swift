//
//  ViewController.swift
//  100 Days Of Swift- Project 1
//
//  Created by Arda Büyükhatipoğlu on 28.05.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default //Default filemanager
        let path = Bundle.main.resourcePath! //Path of the project folder
        let items = try! fm.contentsOfDirectory(atPath: path) //REturn paths of contained items
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
}

