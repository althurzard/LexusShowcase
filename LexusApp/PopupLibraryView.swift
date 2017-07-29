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
    
    var initialScrollDone = false
    
    var selectedIndex: Int?
    
    lazy var dataSourceImages: [UIImage] = {
        var images: [UIImage] = []
        images.append(UIImage(named: "1")!)
        images.append(UIImage(named: "2.jpg")!)
        images.append(UIImage(named: "3")!)
        images.append(UIImage(named: "4")!)
        images.append(UIImage(named: "5")!)
        images.append(UIImage(named: "6")!)
        images.append(UIImage(named: "7")!)
        images.append(UIImage(named: "8")!)
        return images
    }()
    
    static let LibraryTableCellID = "LibraryTableCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self

        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeftImage))
        swipeLeftGesture.direction = .left
        
        imageView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRightImage))
        swipeRightGesture.direction = .right
        imageView.addGestureRecognizer(swipeRightGesture)
        
        imageView.image = dataSourceImages.first
        
        let tapBackground = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        backgroundView.addGestureRecognizer(tapBackground)
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    

        if selectedIndex! > dataSourceImages.count / 2 {
            let indexPath = IndexPath(row: 0, section: 0)
            if let row = tableView.cellForRow(at: indexPath) as? GLCollectionTableViewCell {
                row.collectionView.scrollToItem(at: IndexPath(item: dataSourceImages.count/2, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
        delay(delay: 0.2) {
            if let index = self.selectedIndex {
                self.selectCell(byIndex: index)
            }
        }
        
    }
    
    
    func didSwipeLeftImage(sender: UIGestureRecognizer) {
        selectCell(direction: .Right)
    }
    
    func didSwipeRightImage(sender: UIGestureRecognizer) {
        selectCell(direction: .Left)
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
                            let item = currentCellIndexPath.item - 1  < 0 ? dataSourceImages.count - 1 : currentCellIndexPath.item - 1
                            
                            indexPath = IndexPath(item: item , section: currentCellIndexPath.section)
                        
                            
                        case .Right:
                            let item = currentCellIndexPath.item + 1  == dataSourceImages.count  ? 0 : currentCellIndexPath.item + 1
                            indexPath = IndexPath(item: item , section: currentCellIndexPath.section)
                            
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
    
    func selectCell(byIndex index: Int) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let row = tableView.cellForRow(at: indexPath) as? GLCollectionTableViewCell {
                var indexPath: IndexPath!
                indexPath = IndexPath(item: index , section: 0)
            
            
                
                if let _ = row.collectionView.cellForItem(at: indexPath) {
                    row.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                    self.collectionView(row.collectionView, didSelectItemAt: indexPath)
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

        if !initialScrollDone {
            initialScrollDone = true
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            
        }
        return cell
    }
    
}

extension PopupLibraryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell {
            self.imageView.image = cell.imageView.image

            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            NotificationCenter.default.post(name: Notification.Name.init(rawValue: Constant.Notification.tapInteractionNotification), object: nil)
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

