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
        static let bodyRow = "THIẾT KẾ, VẬN HÀNH & AN TOÀN"
        static let specificationRow = "THÔNG SỐ KỸ THUẬT"
    }
    
    fileprivate lazy var customColorPickerRow: CustomColorPickerRow = self.form.rowBy(tag: Constants.colorPicker) as! CustomColorPickerRow
    
    fileprivate lazy var customOverviewRow: CustomOverviewRow = self.form.rowBy(tag: Constants.overviewRow) as! CustomOverviewRow
    
    fileprivate lazy var customBodyRow: CustomBodyRow = self.form.rowBy(tag: Constants.bodyRow) as! CustomBodyRow
    
    fileprivate lazy var customSpecificationRow: CustomSpecificationRow = self.form.rowBy(tag: Constants.specificationRow) as! CustomSpecificationRow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadForm()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customColorPickerRow.cell.startAnimation()
        self.customOverviewRow.cell.startAnimation()
        self.customBodyRow.cell.startAnimation()
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let locationOnScreenY = scrollView.contentOffset.y
        
        if locationOnScreenY < customOverviewRow.cell.height!() , locationOnScreenY > customOverviewRow.cell.height!() / 2 {
            self.tableView.scrollToRow(at: customColorPickerRow.indexPath!, at: .top, animated: true)
            
        }
        
        if locationOnScreenY > customOverviewRow.cell.height!() / 2 {
            customOverviewRow.cell.prepareAnimation()
        }
        
        
        
        
        
        print(locationOnScreenY)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationOnScreenY = scrollView.contentOffset.y
        
        if locationOnScreenY < customOverviewRow.cell.height!() / 2 {
            customOverviewRow.cell.startAnimation()
        }
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
                $0.cell.height = { 250 }
                
            }
            
            <<< CustomColorPickerRow(Constants.colorPicker) {
                $0.cell.height = { 600 }
            }
        
            <<< CustomBodyRow(Constants.bodyRow) {
                $0.cell.height = { 490 }
        }
        
            <<< CustomSpecificationRow(Constants.specificationRow) {
                
                let tableView = $0.cell.accordianTableView
                let totalHeight = CGFloat(tableView!.dataSource.count) * Specification.cellHeight + CGFloat(tableView!.numberOfSection) * Specification.cellHeight
                
                $0.cell.height = { totalHeight }
                $0.cell.accordianTableView.delegate = self
        }
        
            <<< CustomBodyRow("abc") {
                $0.cell.height = { 490 }
        }
                

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
