//
//  CustomAccordianView.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import YNExpandableCell

protocol CustomAccordianRowProtocol {
    func didCollapseRow(rowHeight: CGFloat)
    func didExpandRow(rowHeight:CGFloat)
}

class CustomAccordianView: UIView {

    @IBOutlet weak var tableView: YNTableView!
    
    var delegate: CustomAccordianRowProtocol?
    
    
    var numberOfSection = 2

    
    var dataSource: [String] = ["ĐỘNG CƠ","VẬN HÀNH","KHUNG GẦM","KÍCH THƯỚC","BÁNH VÀ LỐP XE","TIỆN NGHI","THIẾT BỊ TIÊU CHUẨN","HỆ THỐNG GIẢI TRÍ","AN TOÀN","CÁC TÍNH NĂNG KHÁC"]
    
    var specification: [Specification] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cells = ["YNExpandableCellEx","DetailTableViewCell"]
        self.tableView.registerCellsWith(nibNames: cells, and: cells)
        self.tableView.isScrollEnabled = false
        self.tableView.ynDelegate = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        initData()

    }
    
    
    func initData() {
        // TODO: Remove when go0live
        for i in 0 ..< 5 {
            let spec: Specification = Specification(title:"Test\(i)", description: "This is a Description")
            if i == 3 {
                spec.description = nil
            }
            self.specification.append(spec)
        }
    }
    
    class func instanceFromNib() -> CustomAccordianView {
        return UINib(nibName: "CustomAccordianView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomAccordianView
    }

}

extension CustomAccordianView: YNTableViewDelegate {
    
    
    func tableView(_ tableView: YNTableView, expandCellWithHeightAt indexPath: IndexPath) -> YNTableViewCell? {
        
        
        // TODO:
        let totalCellHeight = CGFloat(specification.count) * Specification.cellHeight
        var detailTableViewCell: DetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.ID) as? DetailTableViewCell
        
        if detailTableViewCell == nil {
            detailTableViewCell = DetailTableViewCell(style: .default, reuseIdentifier: DetailTableViewCell.ID)
        }
        
        detailTableViewCell?.dataSource = self.specification
        
        let tableViewCell = YNTableViewCell()
        
        tableViewCell.cell = detailTableViewCell

        tableViewCell.height = totalCellHeight
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expandableCell = tableView.dequeueReusableCell(withIdentifier: YNExpandableCellEx.ID) as! YNExpandableCellEx
        
        let index = (dataSource.count - ( dataSource.count / (indexPath.section+1)))
        let actuallyIndex = indexPath.row + index
        
        expandableCell.titleLabel.text = dataSource[actuallyIndex]


        return expandableCell
        
    }
    
    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {
        print("Selected Section: \(indexPath.section) Row: \(indexPath.row) isExpandableCell: \(isExpandableCell) isExpandedCell: \(isExpandedCell)")
        delegate?.didExpandRow(rowHeight: 250)

    }
    
    func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {
        print("Deselected Section: \(indexPath.section) Row: \(indexPath.row) isExpandableCell: \(isExpandableCell) isExpandedCell: \(isExpandedCell)")
        delegate?.didCollapseRow(rowHeight: 250)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Specification.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count/2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Specification.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let custom = CustomHeaderSectionView.instanceFromNib()
        if section == 0 {
            custom.titleLabel.text = "THÔNG SỐ KỸ THUẬT"
        } else {
            custom.titleLabel.text = "CÔNG NGHỆ ỨNG DỤNG TRÊN XE"
        }
        return custom
    }
    
    
    
}
