//
//  ViewController.swift
//  100 Days Of Swift- Project 1
//
//  Created by Arda Büyükhatipoğlu on 28.05.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var viewCount = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(barButtonClicked))
        
        DispatchQueue.global().async {
            let fm = FileManager.default //Default filemanager
            let path = Bundle.main.resourcePath! //Path of the project folder
            let items = try! fm.contentsOfDirectory(atPath: path) //Return paths of contained items
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self.pictures.append(item)
                }
            }
            self.pictures.sort()
            
            //Try to load the view count array from user defaults.
            self.loadViewCount()
        }
        
        
    }
    
    func loadViewCount() {
        let defaults = UserDefaults.standard
        
        if let views = defaults.object(forKey: "viewCount") as? [Int] {
            viewCount = views
        } else {
            viewCount = Array(repeating: 0, count: pictures.count)
        }
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(viewCount, forKey: "viewCount")
    }
    
    @objc func barButtonClicked() {
        let siteLink = "https://github.com/ardabho/100-Days-Of-Swift--Project-1"
        
        let vc = UIActivityViewController(activityItems: [siteLink], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    
    //MARK: - Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "View Count: \(viewCount[indexPath.row])"
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewCount[indexPath.row] += 1
        save()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageNumberTitle = "Picture \(indexPath.row + 1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.reloadData()
    }
}

