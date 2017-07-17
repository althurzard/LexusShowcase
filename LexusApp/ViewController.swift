//
//  ViewController.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
class ViewController: FormViewController {

    struct Constants {
        static let overviewRow = "TỔNG QUAN"
        static let colorPicker = "CHỌN MÀU XE"
        static let designRow = "THIẾT KẾ"
        static let operationRow = "VẬN HÀNH"
        static let safetyRow = "AN TOÀN"
        static let specificationRow = "THÔNG SỐ KỸ THUẬT"
    }
    
    
    
    fileprivate lazy var heightRow:CGFloat = UIScreen.main.bounds.height - CustomHeader.height
    
    fileprivate lazy var customColorPickerRow: CustomColorPickerRow = self.form.rowBy(tag: Constants.colorPicker) as! CustomColorPickerRow
    
    fileprivate lazy var customOverviewRow: CustomOverviewRow = self.form.rowBy(tag: Constants.overviewRow) as! CustomOverviewRow
    
    fileprivate lazy var customBodyRow: CustomBodyRow = self.form.rowBy(tag: Constants.designRow) as! CustomBodyRow
    
    fileprivate lazy var customOperationRow: CustomOperationRow = self.form.rowBy(tag: Constants.operationRow) as! CustomOperationRow
    
    fileprivate lazy var customSpecificationRow: CustomSpecificationRow = self.form.rowBy(tag: Constants.specificationRow) as! CustomSpecificationRow
    
    fileprivate lazy var customSafetyRow: CustomSafetyRow = self.form.rowBy(tag: Constants.safetyRow) as! CustomSafetyRow
    
    fileprivate var currentContentOffset: CGPoint = .zero
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadForm()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customOverviewRow.cell.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let locationOnScreenY = scrollView.contentOffset.y
        
        if locationOnScreenY > currentContentOffset.y {
            if locationOnScreenY <= self.heightRow {
                self.tableView.scrollToRow(at: customColorPickerRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow, locationOnScreenY <= self.heightRow*2 {
                self.tableView.scrollToRow(at: customBodyRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 2, locationOnScreenY <= self.heightRow * 3 {
                self.tableView.scrollToRow(at: customOperationRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 3, locationOnScreenY <= self.heightRow * 4 {
                self.tableView.scrollToRow(at: customSafetyRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                self.tableView.scrollToRow(at: customSpecificationRow.indexPath!, at: .top, animated: true)
            }

        } else {
            if locationOnScreenY <= self.heightRow {
                self.tableView.scrollToRow(at: customOverviewRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow, locationOnScreenY <= self.heightRow*2 {
                self.tableView.scrollToRow(at: customColorPickerRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 2, locationOnScreenY <= self.heightRow * 3 {
                self.tableView.scrollToRow(at: customBodyRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 3, locationOnScreenY <= self.heightRow * 4 {
                self.tableView.scrollToRow(at: customOperationRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 5 {
                self.tableView.scrollToRow(at: customSafetyRow.indexPath!, at: .top, animated: true)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                self.tableView.scrollToRow(at: customSpecificationRow.indexPath!, at: .top, animated: true)
            }
        }

        self.currentContentOffset.y = locationOnScreenY
        print("end scrolling")
        
    }
    
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let locationOnScreenY = scrollView.contentOffset.y
        self.currentContentOffset.y = locationOnScreenY
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationOnScreenY = scrollView.contentOffset.y
        stopScrolling()
        if locationOnScreenY < customOverviewRow.cell.height!() / 2 {
            customOverviewRow.cell.startAnimation()
        } else {
            customOverviewRow.cell.prepareAnimation()
        }
            
        if locationOnScreenY < self.heightRow * 1.5, locationOnScreenY > self.heightRow / 2 {
            
            customColorPickerRow.cell.startAnimation()
        } else {
            customColorPickerRow.cell.prepareAnimation()
        }
            
        if locationOnScreenY < self.heightRow * 2.5, locationOnScreenY > self.heightRow * 1.5 {
            customBodyRow.cell.startAnimation()
        } else {
            customBodyRow.cell.prepareAnimation()
        }
        
        if locationOnScreenY < self.heightRow * 3.5, locationOnScreenY > self.heightRow * 2.5 {

            customOperationRow.cell.startAnimation()
        } else {
            customOperationRow.cell.prepareAnimation()
        }
        
        if locationOnScreenY < self.heightRow * 4.5, locationOnScreenY > self.heightRow * 3.5 {
            customSafetyRow.cell.startAnimation()
        } else {
            customSafetyRow.cell.prepareAnimation()
        }
        
        
    }
    
    func stopScrolling() {
        tableView.isScrollEnabled = false
        tableView.isScrollEnabled = true
    }
    
    func loadForm() {
     
        
        self.form
        +++
            Section(""){ section in
                
                let customHeaderProvider = HeaderFooterProvider<CustomHeader>.nibFile(name: "CustomHeader", bundle: nil)
                let customHeaderView = HeaderFooterView<CustomHeader>(customHeaderProvider)
                section.header = customHeaderView
        }
        
            <<< CustomOverviewRow(Constants.overviewRow) {
                $0.cell.height = { self.heightRow}
                
                
            }
            
            <<< CustomColorPickerRow(Constants.colorPicker) {
                $0.cell.height = { self.heightRow }
            }
        
            <<< CustomBodyRow(Constants.designRow) {
                $0.cell.height = { self.heightRow}
        }
            
            <<< CustomOperationRow(Constants.operationRow) {
                $0.cell.height = { self.heightRow }
            }
            
            <<< CustomSafetyRow(Constants.safetyRow) {
                $0.cell.height = { self.heightRow }
            }
        
            
            <<< CustomSpecificationRow(Constants.specificationRow) {
                
                let tableView = $0.cell.accordianTableView
                let totalHeight = CGFloat(tableView!.dataSource.count) * Specification.cellHeight + CGFloat(tableView!.numberOfSection) * Specification.cellHeight
                
                $0.cell.height = { self.heightRow }
                $0.cell.accordianTableView.delegate = self
        }
        
            <<< CustomBodyRow("abc") {
                $0.cell.height = { 490 }
        }
                

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}


extension ViewController: CustomAccordianRowProtocol {
    func didExpandRow(rowHeight: CGFloat) {

        let currentHeight = self.customSpecificationRow.cell.height!()
        print(currentHeight)
        self.tableView.beginUpdates()
        self.customSpecificationRow.cell.accordianTableView.tableView.beginUpdates()
        self.customSpecificationRow.cell.height = {currentHeight + rowHeight}

        self.tableView.endUpdates()
        self.customSpecificationRow.cell.accordianTableView.tableView.endUpdates()

        
    }
    
    func didCollapseRow(rowHeight: CGFloat) {
        let currentHeight = self.customSpecificationRow.cell.height!()
        print(currentHeight)

        self.tableView.beginUpdates()
        self.customSpecificationRow.cell.accordianTableView.tableView.beginUpdates()
        self.customSpecificationRow.cell.height = {currentHeight - rowHeight}

        self.tableView.endUpdates()
        self.customSpecificationRow.cell.accordianTableView.tableView.endUpdates()

    }
}
