//
//  AccordionView.swift
//  AccordionMenuExample
//
//  Created by MacOS on 7/19/17.
//  Copyright © 2017 Victor Sigler. All rights reserved.
//

import UIKit

struct Constant {
    struct Notification {
        static let tapInteractionNotification = "tapInteractionNotification"
    }
}


class AccordionView: UIView {
    
    open var total = 0
    
    /// Notification when interact with table view
    
    
    /// The identifier for the parent cells.
    let parentCellIdentifier = "ParentCell"
    
    /// The identifier for the child cells.
    let childCellIdentifier = "ChildCell"
    
    /// The data source
    open var dataSource: [Parent]!
    
    /// Define wether can exist several cells expanded or not.
    open var numberOfCellsExpanded: NumberOfCellExpanded = .one
    
    /// Constant to define the values for the tuple in case of not exist a cell expanded.
    let NoCellExpanded = (-1, -1)
    
    /// The index of the last cell expanded and its parent.
    var lastCellExpanded : (Int, Int)!
    
    var sectionTitle: String?
    
    var heightForHeaderInSection: CGFloat = 50.0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lastCellExpanded = NoCellExpanded
        
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    /**
     Expand the cell at the index specified.
     
     - parameter index: The index of the cell to expand.
     */
    open func expandItemAtIndex(_ index : Int, parent: Int) {
        
        // the data of the childs for the specific parent cell.
        let currentSubItems = self.dataSource[parent].childs
        
        // update the state of the cell.
        self.dataSource[parent].state = .expanded
        
        // position to start to insert rows.
        var insertPos = index + 1
        
        let indexPaths = (0..<currentSubItems.count).map { _ -> IndexPath in
            let indexPath = IndexPath(row: insertPos, section: 0)
            insertPos += 1
            return indexPath
        }
        
        // insert the new rows
        self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        // update the total of rows
        self.total += currentSubItems.count
    }
    
    open func collapseAllCell() {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView(self.tableView, didSelectRowAt: indexPath)
        }
    }
    
    /**
     Collapse the cell at the index specified.
     
     - parameter index: The index of the cell to collapse
     */
    open func collapseSubItemsAtIndex(_ index : Int, parent: Int) {
        
        var indexPaths = [IndexPath]()
        
        let numberOfChilds = self.dataSource[parent].childs.count
        
        // update the state of the cell.
        self.dataSource[parent].state = .collapsed
        
        guard index + 1 <= index + numberOfChilds else { return }
        
        // create an array of NSIndexPath with the selected positions
        indexPaths = (index + 1...index + numberOfChilds).map { IndexPath(row: $0, section: 0)}
        
        // remove the expanded cells
        self.tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        
        // update the total of rows
        self.total -= numberOfChilds
    }
    
    /**
     Update the cells to expanded to collapsed state in case of allow severals cells expanded.
     
     - parameter parent: The parent of the cell
     - parameter index:  The index of the cell.
     */
    open func updateCells(_ parent: Int, index: Int) {
        
        switch (self.dataSource[parent].state) {
            
        case .expanded:
            self.collapseSubItemsAtIndex(index, parent: parent)
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.cellForRow(at: indexPath)!.setHighlighted(false, animated: false)
            self.tableView.reloadRows(at: [indexPath], with: .none)
            self.lastCellExpanded = NoCellExpanded
            
        case .collapsed:
            switch (numberOfCellsExpanded) {
            case .one:
                // exist one cell expanded previously
                if self.lastCellExpanded != NoCellExpanded {
                    
                    let (indexOfCellExpanded, parentOfCellExpanded) = self.lastCellExpanded
                    
                    self.collapseSubItemsAtIndex(indexOfCellExpanded, parent: parentOfCellExpanded)
                    
                    // cell tapped is below of previously expanded, then we need to update the index to expand.
                    if parent > parentOfCellExpanded {
                        let newIndex = index - self.dataSource[parentOfCellExpanded].childs.count
                        self.expandItemAtIndex(newIndex, parent: parent)
                        self.lastCellExpanded = (newIndex, parent)
                    }
                    else {
                        self.expandItemAtIndex(index, parent: parent)
                        self.lastCellExpanded = (index, parent)
                    }
                }
                else {
                    self.expandItemAtIndex(index, parent: parent)
                    self.lastCellExpanded = (index, parent)
                }
            case .several:
                self.expandItemAtIndex(index, parent: parent)
            }
        }
    }
    
    /**
     Find the parent position in the initial list, if the cell is parent and the actual position in the actual list.
     
     - parameter index: The index of the cell
     
     - returns: A tuple with the parent position, if it's a parent cell and the actual position righ now.
     */
    open func findParent(_ index : Int) -> (parent: Int, isParentCell: Bool, actualPosition: Int) {
        
        var position = 0, parent = 0
        guard position < index else { return (parent, true, parent) }
        
        var item = self.dataSource[parent]
        
        repeat {
            
            switch (item.state) {
            case .expanded:
                position += item.childs.count + 1
            case .collapsed:
                position += 1
            }
            
            parent += 1
            
            // if is not outside of dataSource boundaries
            if parent < self.dataSource.count {
                item = self.dataSource[parent]
            }
            
        } while (position < index)
        
        // if it's a parent cell the indexes are equal.
        if position == index {
            return (parent, position == index, position)
        }
        
        item = self.dataSource[parent - 1]
        return (parent - 1, position == index, position - item.childs.count - 1)
    }
}


extension AccordionView: UITableViewDelegate,UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.total
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
        if !isParentCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! DetailSpecificationCell
            let data = self.dataSource[parent].childs[indexPath.row - actualPosition - 1]
            if let desc = data.description {
                cell.lblDescription.text = desc
                
            }
            
            if data.cellHeight == 80.0 {
                let attributedString = NSMutableAttributedString(string: data.title!)
                
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyle = NSMutableParagraphStyle()
                
                // *** set LineSpacing property in points ***
                paragraphStyle.lineSpacing = 15 // Whatever line spacing you want in points
                paragraphStyle.lineBreakMode = .byWordWrapping
                cell.lblTitle.numberOfLines = 0;
                // *** Apply attribute to string ***
                attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
                
                // *** Set Attributed String to your label ***
                cell.lblTitle.attributedText = attributedString;
                
            } else {
                cell.lblTitle.text = data.title
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier, for: indexPath) as! ExpandableCell
            cell.titleLabel.text = self.dataSource[parent].title
            
            return cell
        }
        
    }
    
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection
    }
    
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let custom = CustomHeaderSectionView.instanceFromNib()
        if section == 0 {
            custom.titleLabel.text = sectionTitle
        } else {
            custom.titleLabel.text = ""
        }
        return custom
    }
    
    // MARK: UITableViewDelegate
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
        guard isParentCell else {
            NSLog("A child was tapped!!!")
            
            // The value of the child is indexPath.row - actualPosition - 1
            NSLog("The value of the child is \(self.dataSource[parent].childs[indexPath.row - actualPosition - 1])")
            
            return
        }
        
        self.tableView.beginUpdates()
        self.updateCells(parent, index: indexPath.row)
        self.tableView.endUpdates()
        
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: Constant.Notification.tapInteractionNotification), object: nil)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        if !isParentCell {
            let cell = self.dataSource[parent].childs[indexPath.row - actualPosition - 1]
            return cell.cellHeight
        }
        return 48.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: Constant.Notification.tapInteractionNotification), object: nil)
    }
}
