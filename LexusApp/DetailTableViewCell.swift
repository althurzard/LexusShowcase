//
//  DetailTableViewCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit


class DetailTableViewCell: UITableViewCell {
    
    static let ID = "DetailTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [Specification] = [] 
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setup()
        
    }
    
    func setup() {
       
        tableView.register(UINib(nibName: DetailSpecificationCell.ID, bundle: nil), forCellReuseIdentifier: DetailSpecificationCell.ID)
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)

    }
    
    

    
}

extension DetailTableViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Specification.cellHeight
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailSpecificationCell.ID) as! DetailSpecificationCell
        
        if dataSource.count > 0 {
            detailCell.lblTitle.text = dataSource[indexPath.row].title
            
            if let description = dataSource[indexPath.row].description {
                detailCell.lblDescription.text = description
            } else {
                detailCell.lblTitle.font = UIFont(name: "NobelVnu-Bold", size: 20)
            }
            
            return detailCell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    
}

extension DetailTableViewCell: UITableViewDelegate {
    
}

