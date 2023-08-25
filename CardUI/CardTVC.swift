//
//  CardTVC.swift
//  CardUI
//
//  Created by Vikram Kunwar on 24/08/23.
//

import UIKit

protocol CardTVCDelegate: AnyObject {
    func rotateButtonDidTap(in cell: CardTVC)
}

class CardTVC: UICollectionViewCell {
    
    weak var delegate: CardTVCDelegate?
    
    @IBOutlet weak var cardImage : UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var rotateBtn: UIButton!
    
    var isRotated = false
    
    weak var collectionView: UICollectionView?  // Reference to the collection view

    
    override func awakeFromNib() {
            super.awakeFromNib()
            initialSetup()
        }
        
        func initialSetup() {
            // Rotate the image by 90 degrees when the cell loads
            cardImage.transform = cardImage.transform.rotated(by: .pi / 2)
        }
    
    @IBAction func rotateButtonTapped(_ sender: UIButton) {
        
        delegate?.rotateButtonDidTap(in: self)
        let rotationAngle: CGFloat = .pi / 2
                let animationDuration: TimeInterval = 0.7
                
                UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    if !self.isRotated {
                        self.cardImage.transform = CGAffineTransform(rotationAngle: 0)  // Rotate to 0 degrees
                    } else {
                        self.cardImage.transform = CGAffineTransform(rotationAngle: .pi / 2)  // Rotate back to 90 degrees
                    }
                    
                    // Update rotation for all visible cells in the collection view
                    self.collectionView?.visibleCells.forEach { cell in
                        if let cardCell = cell as? CardTVC, cardCell != self {
                            cardCell.cardImage.transform = self.cardImage.transform
                        }
                    }
                }) { _ in
                    self.isRotated.toggle()  // Toggle the rotation state
                }
            }
    
    
}
