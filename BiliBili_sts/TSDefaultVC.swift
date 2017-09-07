//
//  TSDefaultVC.swift
//  BiliBili_sts
//
//  Created by sts on 2017/9/7.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
import UIKit

class TSDefaultVC :TSViewController{
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        // setupConstraints
    }
    
    
    lazy var hintLbl: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        lbl.center = self.view.center
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 2
        lbl.text = "https://github.com/sunyanyan \n 欢迎交流学习"
        return lbl
    }()
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(hintLbl)
    }
}
