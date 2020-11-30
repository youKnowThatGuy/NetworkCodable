//
//  ViewController.swift
//  NetworkCodable
//
//  Created by Клим on 30.11.2020.
//

import UIKit

class ViewController: UIViewController {
    private var moscowSt = [Station]()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkLoad()
    }
    
    func networkLoad(){
        NetworkService.loadData { (stations, error) in
            DispatchQueue.main.async {
                if let error = error{
                    self.showAlertError(title: error.localizedDescription)
                }
                self.moscowSt = stations
                //self.collectionView.reloadData()
            }
        }
    }
    
    private func showAlertError(title: String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fine", style: .default))
        present(alert, animated: true, completion: nil)
    }


}

