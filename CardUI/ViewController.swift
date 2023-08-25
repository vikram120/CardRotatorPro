//
//  ViewController.swift
//  CardUI
//
//  Created by Vikram Kunwar on 24/08/23.
//

import UIKit

class ViewController: UIViewController, CardTVCDelegate {
    
    @IBOutlet weak var cardCollection : UICollectionView!
    
    @IBOutlet weak var cardListTable: UITableView!
    
    @IBOutlet weak var statement: UILabel!
    
    @IBOutlet weak var listView: UIView!
    
    
    
    var images = ["Card1","Card2","Card3","Card4","Card5"]
    
    var img = ["apple","amazon","shop","nike","flipkart"]
    
    var titl = ["Apple Store","Amazon Store","Super Market","Nike Store","Flip Kart"]
    
    var name = ["Apple Store","Amazon Store","Super Market","Nike Store","Flip Kart"]

    
    var charges = ["5,000 RS","6,000 RS","3,000 RS","4,000 RS","7,000 RS"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.transform = CGAffineTransform(translationX: 0, y: self.listView.frame.height)

        self.listView.layer.cornerRadius = 32
        
        self.listView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        
        
        cardListTable.layer.cornerRadius = 32
        cardListTable.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        

        

        
        
        
        // Register a tap gesture recognizer for the collection view cells
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:)))
        cardCollection.addGestureRecognizer(tapGestureRecognizer)
        cardCollection.isUserInteractionEnabled = true  // Ensure user interaction is enabled
    }
    
    @objc func handleCellTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if let tappedCell = gestureRecognizer.view as? UICollectionViewCell,
           let indexPath = cardCollection.indexPath(for: tappedCell),
           let cell = cardCollection.cellForItem(at: indexPath) as? CardTVC {
            
            let rotationAngle: CGFloat = .pi / 2
            
            // Rotate the UIView
            UIView.animate(withDuration: 0.3) {
                cell.cardView.transform = cell.cardView.transform.rotated(by: rotationAngle)
            }
            
            // Rotate the image view within the cell
            UIView.animate(withDuration: 0.3) {
                cell.cardImage.transform = cell.cardImage.transform.rotated(by: rotationAngle)
                cell.cardImage.transform = cell.cardImage.transform.translatedBy(x: -cell.cardImage.frame.width / 2, y: -cell.cardImage.frame.height / 2)
            }
        }
    }

}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardTVC
        cell.rotateBtn.addTarget(self, action: #selector(rotateButtonTapped(_:)), for: .touchUpInside)
        cell.collectionView = collectionView
        cell.delegate = self
        cell.cardImage.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    @objc func rotateButtonTapped(_ sender: UIButton) {
            if let cell = sender.superview?.superview as? CardTVC {
                let rotationAngle: CGFloat = .pi / 2
                
                // Rotate the UIView
                UIView.animate(withDuration: 0.3) {
                    cell.cardView.transform = cell.cardView.transform.rotated(by: rotationAngle)
                }
                
                // Rotate the image view within the cell
                UIView.animate(withDuration: 0.3) {
                    cell.cardImage.transform = cell.cardImage.transform.rotated(by: rotationAngle)
                    cell.cardImage.transform = cell.cardImage.transform.translatedBy(x: -cell.cardImage.frame.width / 2, y: -cell.cardImage.frame.height / 2)
                }
            }
        }
    
    func rotateButtonDidTap(in cell: CardTVC) {
            if let indexPath = cardCollection.indexPath(for: cell) {
                

                // Update the label text based on the rotation state
                if !cell.isRotated {
                    statement.text = "Available Credit Limit $1000"
                } else {
                    statement.text = "Statement"
                }
                
                UIView.transition(with: statement, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)
                
                if !cell.isRotated {
                                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: [], animations: {
                                    self.listView.transform = .identity
                                }, completion: nil)
                            } else {
                                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: [], animations: {
                                    self.listView.transform = CGAffineTransform(translationX: 0, y: self.listView.frame.height)
                                }, completion: nil)
                            }

            }
        }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardListTable.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ListTableCell
        
        cell.productImg.image = UIImage(named: img[indexPath.row])
        
     
        
        cell.productImg.layer.cornerRadius = cell.productImg.frame.size.width / 2
        cell.productImg.clipsToBounds = true
        
        cell.imageVi.layer.cornerRadius = 20
        
        cell.productName.text = name[indexPath.row]
        cell.productTitle.text = titl[indexPath.row]
        
        cell.productPrice.text = charges[indexPath.row]
        return cell
        
    }
    
    
}

