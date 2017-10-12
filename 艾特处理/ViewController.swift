//
//  ViewController.swift
//  艾特处理
//
//  Created by karl on 2017/10/10.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

struct HGAtUser {
  var name = ""
  var id = 0
  var range = NSRange(location: 0, length: 0)
}

class ViewController: UIViewController {

  let text = "adas@呵a🐽住😱嘻: 哈哈哈哈@呵😪a😪嘻: 哈哈哈sss哈@呵a👏呵呵👋嘻: 哈哈哈哈"
  let userInfo = ["@呵a🐽住😱嘻": 1, "@呵😪a😪嘻": 2, "@呵a👏呵呵👋嘻": 3]
  override func viewDidLoad() {
    super.viewDidLoad()

    test()
    test2()
  }
  
  func test2() {
    let textView = HGPlazaDetailTextView(frame: CGRect(x: 50, y: 30, width: 300, height: 200))
    textView.textAlignment = .center
    let attr = NSMutableAttributedString(string: text)
    attr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: (text as NSString).length))
    var atUsers = [HGAtUser]()
    
    //1:
    /******************************** 用正则匹配 *************************************/
    do {
      let pattern = "@[\\S]+:"
      let regex = try NSRegularExpression(pattern: pattern)
      let array = regex.matches(in: text, range: NSRange(location: 0, length: (text as NSString).length))
      array.forEach({ (result) in
        let range = NSRange(location: result.range.location, length: result.range.length - 1)
        let userName = text.substring(with: range)
        attr.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: range)
        let atUser = HGAtUser(name: userName, id: userInfo[userName]!, range: range)
        
        atUsers.append(atUser)
      })
    } catch {}
    
    //2:
    /****************************** 用for循环自己找出字符串的range ***************************************/
    /*
    for (userName, id) in userNames {
      let range = text.range(userName)
      if range.length > 0 {
        let atUser = HGAtUser(name: userName, id: id, range: range)
        atUsers.append(atUser)
      }
    }
    
    for atUser in atUsers {
      attr.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: atUser.range)
    }
    */
    /*********************************************************************/
    
    if atUsers.count > 0 {
      attr.addAttribute("atUsers", value: atUsers, range: NSRange(location: 0, length: 1))
    }
    
    textView.attributedText = attr
    
    
    view.addSubview(textView)
    
  }

  func test() {
    let label = UILabel()
    label.frame = CGRect(x: 50, y: 250, width: 300, height: 200)
    label.numberOfLines = 0
    label.textAlignment = .center
    view.addSubview(label)
    let s = "adas@呵a🐽住😱嘻: 哈哈哈哈@呵😪a😪嘻: 哈哈哈sss哈@呵a👏呵呵👋嘻: 哈哈哈哈"
    let atts = NSMutableAttributedString(string: s)
    
    do {
      let pattern = "@[\\S]+:"
      let regex = try NSRegularExpression(pattern: pattern)
      let array = regex.matches(in: s, range: NSRange(location: 0, length: (s as NSString).length))
      array.forEach({ (result) in
        atts.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location: result.range.location, length: result.range.length - 1))
      })
      print(array.count)
      
    } catch {
    }
    label.attributedText = atts
  }
}


extension String {
  public func range(of searchString: String) -> NSRange {
    return (self as NSString).range(of: searchString)
  }
  
  public func substring(with range: NSRange) -> String {
    return (self as NSString).substring(with: range)
  }
}

