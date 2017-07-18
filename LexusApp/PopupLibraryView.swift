//
//  PopupLibraryView.swift
//  LexusApp
//
//  Created by MacOS on 7/18/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class PopupLibraryView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataSourceImages: [UIImage] = {
        var images: [UIImage] = []
        images.append(UIImage(named: "RC3004")!)
        images.append(UIImage(named: "RC3402")!)
        images.append(UIImage(named: "RC6089")!)
        images.append(UIImage(named: "RC5047")!)
        images.append(UIImage(named: "Big-Image-1-(1000x560)")!)
        images.append(UIImage(named: "Big-Image-2-(1000x560)")!)
        images.append(UIImage(named: "Big-Image-4-(1000x560)")!)
        images.append(UIImage(named: "img_gallery_02.jpg")!)
        images.append(UIImage(named: "img_gallery_04.jpg")!)
        images.append(UIImage(named: "img_gallery_05.jpg")!)
        images.append(UIImage(named: "Small-image-1")!)
        return images
    }()
    
    static let LibraryTableCellID = "LibraryTableCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(gesture)
    }
    
    func didTapView(sender: UIGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    class func instanceFromNib() -> PopupLibraryView {
        return UINib(nibName: "PopupLibraryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PopupLibraryView
    }
    
    

}

extension PopupLibraryView: UITableViewDelegate {
    
    // MARK: <UITableView Delegate>
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: GLCollectionTableViewCell = cell as? GLCollectionTableViewCell else {
            return
        }
        

        cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)
        

    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }

    
}

extension PopupLibraryView: UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Instead of having a single cellIdentifier for each type of
        // UITableViewCells, like in a regular implementation, we have multiple
        // cellIDs, each related to a indexPath section. By Doing so the
        // UITableViewCells will still be recycled but only with
        // dequeueReusableCell of that section.
        //
        // For example the cellIdentifier for section 4 cells will be:
        //
        // "tableViewCellID_section_#3"
        //
        // dequeueReusableCell will only reuse previous UITableViewCells with
        // the same cellIdentifier instead of using any UITableViewCell as a
        // regular UITableView would do, this is necessary because every cell
        // will have a different UICollectionView with UICollectionViewCells in
        // it and UITableView reuse won't work as expected giving back wrong
        // cells.
        var cell: GLCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: PopupLibraryView.LibraryTableCellID + indexPath.section.description) as? GLCollectionTableViewCell
        
        if cell == nil {
            cell = GLCollectionTableViewCell(style: .default, reuseIdentifier: PopupLibraryView.LibraryTableCellID + indexPath.section.description)
            
            // Configure the cell...
            cell!.selectionStyle = .none
            cell!.collectionViewPaginatedScroll = true
  
            
        }
        
        return cell!
        
    }
    
}

extension PopupLibraryView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: BaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.identifier, for: indexPath) as? BaseCollectionViewCell else {
            fatalError("UICollectionViewCell must be of ContactCollectionViewCell type")
        }
        
        guard let _: GLIndexedCollectionView = collectionView as? GLIndexedCollectionView else {
            fatalError("UICollectionView must be of GLIndexedCollectionView type")
        }
        
        // Configure the cell...
        cell.imageView.image = self.dataSourceImages[indexPath.item]
        return cell
    }
    
}

extension PopupLibraryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
}

extension PopupLibraryView: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionTopInset, left: collectionLeftInset, bottom: collectionBottomInset, right: collectionRightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tableViewCellHeight: CGFloat = self.tableView.frame.height
        let collectionItemWidth: CGFloat = tableViewCellHeight - (collectionLeftInset + collectionRightInset)
        let collectionViewHeight: CGFloat = collectionItemWidth
        
        return CGSize(width: collectionItemWidth, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}

private let collectionTopInset: CGFloat = 0
private let collectionBottomInset: CGFloat = 0
private let collectionLeftInset: CGFloat = 5
private let collectionRightInset: CGFloat = 5

