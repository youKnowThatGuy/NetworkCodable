//
//  CollectionViewController.swift
//  NetworkCodable
//
//  Created by Клим on 30.11.2020.
//

import UIKit

class CollectionViewController: UIViewController {
    private var moscowLn = [Line]()
    
    @IBOutlet weak var stationsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        networkLoad()
    }
    
    
    func networkLoad(){
        NetworkService.loadData { (lines, error) in
                if let error = error{
                    self.showAlertError(title: error.localizedDescription)
                }
                self.moscowLn = lines
                self.stationsCollection.reloadData()
            }
        }
    
    
    func configureCollection(){
        self.stationsCollection.delegate = self
        self.stationsCollection.dataSource = self
    }
    
    
    private func showAlertError(title: String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fine", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    //-MARK: Flow Layout constansts
    private let spacing: CGFloat = 10
    private let numberOfItemsPerRow: CGFloat = 3


}



//-MARK: Delegate&DataSource
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moscowLn[section].stations.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        moscowLn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewTitle.identifier, for: indexPath) as? CollectionViewTitle{
            sectionHeader.titleLabel.text = "Линия: \(moscowLn[indexPath.section].name)"
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetroCell.identifier, for: indexPath) as? MetroCell else{
            fatalError("Invalid cell id")
        }
        let station = moscowLn[indexPath.section].stations[indexPath.row]
        cell.stNameLable.text = station.name
        cell.idLable.text = "ID: \(station.id)"
        
        return cell
    }
    
    
}




//-MARK: Layout
extension CollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let summarySpacing = spacing * (numberOfItemsPerRow - 1)
        let insets = 2  * spacing
        
        let cellWidth = (width - summarySpacing - insets) / numberOfItemsPerRow
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
}

