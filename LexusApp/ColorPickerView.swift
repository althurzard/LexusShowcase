//
//  ColorPickerView.swift
//  LexusApp
//
//  Created by MacOS on 7/18/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit


class ColorPickerView: UIView {
    
    static let identifer = "ColorPickerView"
    static let notificationName = "ColorPickerNotification"
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataSourceImages: [UIImage] = {
        var images: [UIImage] = []
        images.append(#imageLiteral(resourceName: "btn-sonic-titanium"))
        images.append(#imageLiteral(resourceName: "btn-sonic-quartz"))
        images.append(#imageLiteral(resourceName: "btn-platinum silver-metallic"))
        images.append(#imageLiteral(resourceName: "btn-mercury-gray-mc"))
        images.append(#imageLiteral(resourceName: "btn-black"))
        images.append(#imageLiteral(resourceName: "btn-graphite-black"))
        images.append(#imageLiteral(resourceName: "btn-radiant-red-cl"))
        return images
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    class func instanceFromNib() -> ColorPickerView {
        return UINib(nibName: "ColorPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ColorPickerView
    }

}

extension ColorPickerView: UITableViewDelegate {
    
    // MARK: <UITableView Delegate>
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: GLCollectionTableViewCell = cell as? GLCollectionTableViewCell else {
            return
        }
        cell.collectionView.backgroundColor = .white
        cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    
}

extension ColorPickerView: UITableViewDataSource {
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
        var cell: GLCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ColorPickerView.identifer + indexPath.section.description) as? GLCollectionTableViewCell
        
        if cell == nil {
            cell = GLCollectionTableViewCell(style: .default, reuseIdentifier: PopupLibraryView.LibraryTableCellID + indexPath.section.description)
            
            // Configure the cell...
            cell!.selectionStyle = .none
            cell!.collectionViewPaginatedScroll = true
            
            
        }
        
        return cell!
        
    }
    
}

extension ColorPickerView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ColorPickerViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickerViewCell.identifier, for: indexPath) as? ColorPickerViewCell else {
            fatalError("UICollectionViewCell must be of ContactCollectionViewCell type")
        }
        
        guard let _: GLIndexedCollectionView = collectionView as? GLIndexedCollectionView else {
            fatalError("UICollectionView must be of GLIndexedCollectionView type")
        }
        
        
        // Configure the cell...
        cell.imageView.image = self.dataSourceImages[indexPath.item]
        
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            cell.colorName = "Ghi Sonic Titanium <1J7>"
        } else if indexPath.item == 1 {
            cell.colorName = "Trắng Sonic Quartz <085>"
        } else if indexPath.item == 2 {
            cell.colorName = "Bạc Platinum Silver Metallic <1J4>"
            
        } else if indexPath.item == 3 {
            cell.colorName = "Xám Mercury Gray MC. <1H9>"
        } else if indexPath.item == 4 {
            cell.colorName = "Đen Black <212>"
            
        } else if indexPath.item == 5 {
            cell.colorName = "Đen Graphite Black <223>"
            
        } else if indexPath.item == 6 {
            cell.colorName = "Đỏ Radiant Red CL. <3T5>"
            
        }
        
        cell.indexPath = indexPath
        
        return cell
    }
    
}

extension ColorPickerView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorPickerViewCell {
           NotificationCenter.default.post(name: Notification.Name.init(rawValue: ColorPickerView.notificationName), object: cell)
        }
        
    }
    
    
}

extension ColorPickerView: UICollectionViewDelegateFlowLayout {
    
    
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
private let collectionLeftInset: CGFloat = 2.5
private let collectionRightInset: CGFloat = 2.5

