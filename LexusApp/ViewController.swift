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
        static let sectionTag = "Section"
        static let overviewRow = "TỔNG QUAN"
        static let colorPicker = "CHỌN MÀU XE"
        static let designRow = "THIẾT KẾ"
        static let operationRow = "VẬN HÀNH"
        static let safetyRow = "AN TOÀN"
        static let libraryRow = "THƯ VIỆN"
        static let specificationRow = "THÔNG SỐ"
    }
    
    
    
    fileprivate lazy var heightRow:CGFloat = UIScreen.main.bounds.height - CustomHeader.height
    
    fileprivate lazy var customColorPickerRow: CustomColorPickerRow = self.form.rowBy(tag: Constants.colorPicker) as! CustomColorPickerRow
    
    fileprivate lazy var customOverviewRow: CustomOverviewRow = self.form.rowBy(tag: Constants.overviewRow) as! CustomOverviewRow
    
    fileprivate lazy var customBodyRow: CustomBodyRow = self.form.rowBy(tag: Constants.designRow) as! CustomBodyRow
    
    fileprivate lazy var customOperationRow: CustomOperationRow = self.form.rowBy(tag: Constants.operationRow) as! CustomOperationRow
    
    fileprivate lazy var customSpecificationRow: CustomSpecificationRow = self.form.rowBy(tag: Constants.specificationRow) as! CustomSpecificationRow
    
    fileprivate lazy var customSafetyRow: CustomSafetyRow = self.form.rowBy(tag: Constants.safetyRow) as! CustomSafetyRow
    
    fileprivate lazy var customLirabryRow: CustomLibraryRow = self.form.rowBy(tag: Constants.libraryRow) as! CustomLibraryRow
    
    fileprivate var headerView: CustomHeader?
    
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
                
                goToRowBy(indexPath: customColorPickerRow.indexPath!, category: .TongQuan)
                
            } else if locationOnScreenY > self.heightRow, locationOnScreenY <= self.heightRow*2 {
                
                goToRowBy(indexPath: customBodyRow.indexPath!, category: .ThietKe)
                
            } else if locationOnScreenY > self.heightRow * 2, locationOnScreenY <= self.heightRow * 3 {
                
                goToRowBy(indexPath: customOperationRow.indexPath!, category: .VanHanh)
                
            } else if locationOnScreenY > self.heightRow * 3, locationOnScreenY <= self.heightRow * 4 {
                
                goToRowBy(indexPath: customSafetyRow.indexPath!, category: .AnToan)
                
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                
                goToRowBy(indexPath: customSpecificationRow.indexPath!, category: .ThongSo)
                
            } else if locationOnScreenY > self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                goToRowBy(indexPath: customLirabryRow.indexPath!, category: .ThuVien)
            }

        } else {
            if locationOnScreenY <= self.heightRow {
                headerView?.hideUnderline()
                self.tableView.scrollToRow(at: customOverviewRow.indexPath!, at: .top, animated: true)
                
            } else if locationOnScreenY > self.heightRow, locationOnScreenY <= self.heightRow*2 {
                goToRowBy(indexPath: customColorPickerRow.indexPath!, category: .TongQuan)
            } else if locationOnScreenY > self.heightRow * 2, locationOnScreenY <= self.heightRow * 3 {
                goToRowBy(indexPath: customBodyRow.indexPath!, category: .ThietKe)
            } else if locationOnScreenY > self.heightRow * 3, locationOnScreenY <= self.heightRow * 4 {
                goToRowBy(indexPath: customOperationRow.indexPath!, category: .VanHanh)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 5 {
                goToRowBy(indexPath: customSafetyRow.indexPath!, category: .AnToan)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                goToRowBy(indexPath: customSpecificationRow.indexPath!, category: .ThongSo)
            } else if locationOnScreenY > self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                goToRowBy(indexPath: customSpecificationRow.indexPath!, category: .ThongSo)
            }
        }

        self.currentContentOffset.y = locationOnScreenY
        print("end scrolling")
        
    }
    
    func goToRowBy(indexPath: IndexPath, category: CustomHeader.LabelName) {
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        headerView?.switchState(category: category)
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
        
        if locationOnScreenY > self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
            customLirabryRow.cell.startAnimation()
        } else {
            customLirabryRow.cell.prepareAnimation()
        }
        
        
        
    }
    
    func stopScrolling() {
        tableView.isScrollEnabled = false
        tableView.isScrollEnabled = true
    }
    
    func loadForm() {
     

        
        self.form
        +++
            Section(Constants.sectionTag){ section in
                
                let customHeaderProvider = HeaderFooterProvider<CustomHeader>.nibFile(name: "CustomHeader", bundle: nil)
                var customHeaderView = HeaderFooterView<CustomHeader>(customHeaderProvider)
                customHeaderView.onSetupView = { (view,section)  in
                    self.headerView = view
                    view.delegate = self
                }
                section.header = customHeaderView
                
                let customFooterProvider = HeaderFooterProvider<CustomFooterView>.nibFile(name: "CustomFooterView", bundle: nil)
                let customFooterView = HeaderFooterView<CustomFooterView>(customFooterProvider)
                section.footer = customFooterView
            
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
                
//                let tableView = $0.cell.accordianTableView
//                let totalHeight = CGFloat(tableView!.dataSource.count) * Specification.cellHeight + CGFloat(tableView!.numberOfSection) * Specification.cellHeight
                
                $0.cell.height = { self.heightRow }
                $0.cell.accordianTableView.delegate = self
        }
        
            <<< CustomLibraryRow(Constants.libraryRow) {
                $0.cell.height = { self.heightRow }
        }
        
           
                

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}

extension ViewController: CustomHeaderProtocol {
    func didTapCategory(name: CustomHeader.LabelName) {
        switch name {
        case .TongQuan:
            goToRowBy(indexPath: customColorPickerRow.indexPath!, category: name)
        case .ThietKe:
            goToRowBy(indexPath: customBodyRow.indexPath!, category: name)
        case .VanHanh:
           goToRowBy(indexPath: customOperationRow.indexPath!, category: name)
        case .AnToan:
           goToRowBy(indexPath: customSafetyRow.indexPath!, category: name)
        case .ThongSo:
            goToRowBy(indexPath: customSpecificationRow.indexPath!, category: name)
        case .ThuVien:
            goToRowBy(indexPath: customLirabryRow.indexPath!, category: name)
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
