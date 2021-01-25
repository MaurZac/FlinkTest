//
//  ViewController.swift
//  FlinkTest
//
//  Created by Mauricio Zarate on 22/01/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    private var data: CharactersModel!
    private var realData: CharactersModel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var names: String?
    var species: String?
    var status: String?
    var image: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://rickandmortyapi.com/api/character/")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        NSURLConnection.sendAsynchronousRequest(request, queue: .main) { (response, data, error) in
            guard let data = data else{
                print(error as Any)
                return
            }
            let responseString: String! = String(data: data, encoding: .utf8)
            let decoder = JSONDecoder()
            do{
                self.data = try decoder.decode(CharactersModel.self, from: data)
                self.realData = self.data
                self.collectionView.reloadData()
                print(self.data.results.count)
            }catch{
                print(error)
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let singleCell: SingleCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCell", for: indexPath) as! SingleCellView
        singleCell.charName.text = self.data?.results[indexPath.item].name
        names =  self.data?.results[indexPath.item].name
        status = self.data?.results[indexPath.item].status
        species = self.data?.results[indexPath.item].species
        image = self.data?.results[indexPath.item].image
        DispatchQueue.main.async {
            singleCell.charImg.load(urlString: (self.data?.results[indexPath.item].image!)!)
        }
        return singleCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "searchingBar", for: indexPath)
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.data.results.removeAll()
        
        for item in self.realData.results {
            if item.name!.lowercased().contains(searchBar.text!.lowercased()){
                self.data.results.append(item)
            }
        }
        if (searchBar.text!.isEmpty){
            self.data.results = self.realData.results
        }
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.namelbl = names
            destinationVC.image = image
        }
    }
    
}
extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString)else{
            return
        }
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
                
            }
        }
    }
}

