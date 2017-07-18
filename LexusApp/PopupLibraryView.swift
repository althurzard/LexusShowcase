//
//  PopupLibraryView.swift
//  LexusApp
//
//  Created by MacOS on 7/18/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Spring

class PopupLibraryView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: DesignableImageView!
    
    
    @IBOutlet weak var backgroundView: UIView!
    
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
        
        imageView.addGestureRecognizer(createGesture())
        imageView.image = dataSourceImages.first
        
        backgroundView.addGestureRecognizer(createGesture())
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    
        // Select first cell for default
        let indexPath = IndexPath(row: 0, section: 0)
        if let row = tableView.cellForRow(at: indexPath) as? GLCollectionTableViewCell {
            if let cell = row.collectionView.visibleCells.first {
                let indexPath = row.collectionView.indexPath(for: cell)
                row.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(row.collectionView, didSelectItemAt: indexPath!)
            }
        }
        
    }
    
    func createGesture() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }
    
    
     func didTapView(sender: UIGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    enum SelectedDirection {
        case Left
        case Right
    }
    
    @IBAction func didTapLeftImageSlider(_ sender: Any) {
        selectCell(direction: .Left)
    }
    
    @IBAction func didTapRightImageSlider(_ sender: Any) {
        selectCell(direction: .Right)
    }
    
    func selectCell(direction: SelectedDirection) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let row = tableView.cellForRow(at: indexPath) as? GLCollectionTableViewCell {
            for cell in row.collectionView.visibleCells {
                if cell.isSelected {
                    if let currentCellIndexPath = row.collectionView.indexPath(for: cell) {
                        var indexPath: IndexPath!
                        switch direction {
                        case .Left:
                            indexPath = IndexPath(item: currentCellIndexPath.item - 1 , section: currentCellIndexPath.section)
                        
                        case .Right:
                            indexPath = IndexPath(item: currentCellIndexPath.item + 1 , section: currentCellIndexPath.section)
                            
                        }
                        
                        if let _ = row.collectionView.cellForItem(at: indexPath) {
                            row.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                            self.collectionView(row.collectionView, didSelectItemAt: indexPath)
                        }
                        
                        
                        break
                    }
                    
                   
                }
            }
        }
        
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
        if let cell = collectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell {
            self.imageView.image = cell.imageView.image
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
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

