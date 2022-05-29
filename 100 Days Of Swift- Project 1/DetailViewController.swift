//
//  DetailViewController.swift
//  100 Days Of Swift- Project 1
//
//  Created by Arda Büyükhatipoğlu on 29.05.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    var imageNumberTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = imageNumberTitle
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
