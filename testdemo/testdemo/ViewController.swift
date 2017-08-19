//
//  ViewController.swift
//  testdemo
//
//  Created by lihe on 2017/8/19.
//  Copyright © 2017年 lihe. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test5()
    }


    func test0() {
        //创建一个简单的view,用snp约束
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        redView.snp.makeConstraints { (mmm) in
            mmm.left.equalTo(self.view.snp.left).offset(100)
            mmm.top.equalTo(self.view.snp.top).offset(100)
            mmm.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
    func test1() {
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        redView.snp.makeConstraints { (mmm) in
            mmm.center.equalTo(self.view.snp.center)
            mmm.width.height.equalTo(100)
        }
    }
    
    func test2() {
        //snp,给view添加约束,x,y位置约束,width ,height 宽高约束,边距,基准线,
        //添加约束后的修正,offset ,inset,倍率multipiledBy
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        //center
        redView.snp.makeConstraints { (mmm) in
            mmm.center.equalTo(self.view.snp.center)
            mmm.width.height.equalTo(200)
        }
        
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellow
        redView.addSubview(yellowView)
        
        //center,multipliedBy
        yellowView.snp.makeConstraints { (mmm) in
            mmm.center.equalTo(redView.snp.center)
            mmm.height.width.equalTo(redView).multipliedBy(0.5)
        }
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        yellowView.addSubview(blueView)
        //edge
        blueView.snp.makeConstraints { (mm) in
            mm.edges.equalTo(yellowView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        let greenView = UIView()
        greenView.backgroundColor = UIColor.green
        blueView.addSubview(greenView)
        //offset
        greenView.snp.makeConstraints { (mmm) in
            mmm.top.equalTo(blueView).offset(10)
            mmm.left.equalTo(blueView).offset(10)
            mmm.right.equalTo(blueView).offset(-10)
            mmm.bottom.equalTo(blueView).offset(-10)
        }
    }
    
    
    var yellowView : UIView?
    
    func test3() {
        //优先级priority
        /*
         priorityLow()：设置低优先级，优先级为250
         
         priorityMedium()：设置中优先级，优先级为500（默认优先级）
         
         priorityHigh()：设置高优先级，优先级为750
         
         priority()：可以设置任意的优先级，接受的参数是0-1000的数字.
         
         */
        
        let redView = UIView()
        let yellowView = UIView()
        self.yellowView = yellowView
        let blueView = UIView()
        
        redView.backgroundColor = UIColor.red
        yellowView.backgroundColor = UIColor.yellow
        blueView.backgroundColor = UIColor.blue
        
        self.view.addSubview(redView)
        self.view.addSubview(yellowView)
        self.view.addSubview(blueView)
        
        redView.snp.makeConstraints { (mmm) in
            mmm.left.equalTo(self.view.snp.left).offset(10)
            mmm.height.equalTo(80)
            mmm.bottom.equalTo(self.view.snp.bottom).offset(-10)
            
        }
        
        yellowView.snp.makeConstraints { (mmm) in
            mmm.left.equalTo(redView.snp.right).offset(10)
            
            mmm.bottom.height.width.equalTo(redView)
        }
        
        blueView.snp.makeConstraints { (mmm) in
            mmm.left.equalTo(yellowView.snp.right).offset(10)
            mmm.bottom.height.width.equalTo(redView)
            mmm.right.equalTo(self.view.snp.right).offset(-10)
            //重新设置优先级,默认情况下使用默认优先级,优先级数字越大,越先使用
            mmm.left.equalTo(redView.snp.right).offset(10).priority(250)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 1.5) {
            self.yellowView?.removeFromSuperview()
        }
    }
    
    
    var constant : Constraint?
    func test4() {
        //1 首先要引用约束,才能删除约束
        
        let btn = UIButton()
        btn.setTitle("删除约束", for: .normal)
        btn.backgroundColor = UIColor.brown
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(test4_btn_click(btn:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { (mmm) in
            mmm.center.equalTo(self.view)
           self.constant = mmm.height.width.equalTo(200).constraint
        }
        
        
        
    }
    
    func test4_btn_click(btn:UIButton) -> Void {
            self.constant?.deactivate()
    }
    
    
    var topConstant : Constraint?
    
    func test5() {
        //2通过约束的引用来更新约束
        
        let btn = UIButton()
        btn.setTitle("删除约束", for: .normal)
        btn.backgroundColor = UIColor.brown
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(test5_btn_click(btn:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { (mmm) in
            self.topConstant = mmm.top.equalTo(self.view.snp.top).offset(100).constraint
            mmm.height.width.equalTo(200)
        }
        
        
    }
    var num  = 10.0
    func test5_btn_click(btn:UIButton) -> Void {
        num += 10.0
        self.topConstant?.update(inset:num)
        
    }
    
    
}

