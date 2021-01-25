//
//  DetailsViewController.swift
//  FlinkTest
//
//  Created by Mauricio Zarate on 24/01/21.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var specielbl: String?
    var statuslbl: String?
    var namelbl: String?
    var image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = namelbl
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.detailImage.load(urlString: self.image!)
        }
    }
  
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

