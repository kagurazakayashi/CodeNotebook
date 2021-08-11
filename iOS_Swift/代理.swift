// ViewController.swift 代码
import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .purple;
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // 05.2 在第一次实例化 CustomCell 的时候, 设置代理
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// 05.1 遵守代理协议
/** extension
 -- extension 类似于 OC 中的 Category
 -- 格式: extension 类名 {}
 -- Swift中 代码可读性差, 通过 extension 完成代码分块, 增强可读性, 单一模块单独处理, 增大了当前类的作用域
 -- extension 中 可以添加计算型属性 不能添加存储型属性; 可以定义便利构造函数 不能定义指定构造函数
 */
extension ViewController: CustomCellDelegate{
    // 06. 实现代理方法
    func whiteButtonClick() {
        print("ViewController中监听到了按钮点击")
    }
}



// CustomCell.swift 代码
import UIKit

// 01. 定义协议
protocol CustomCellDelegate: NSObjectProtocol{
    // 02. 定义协议方法
    func whiteButtonClick ()
}

class CustomCell: UITableViewCell {
    // 03. 声明代理属性 (注:使用weak修饰, 该协议需要继承NSObjectProtocol基协议, 且注意代理名称是否重复)
    weak var delegate: CustomCellDelegate?
    
    lazy var button: UIButton = {
       
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.white
        btn.frame = CGRect(x: 50, y: 20, width: 60, height: 60)
        btn.addTarget(self, action: #selector(ButtonClick), for: .touchUpInside)
        return btn
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(button)
    }
    
    @objc func ButtonClick() {
        // 04. 执行代理
        delegate?.whiteButtonClick()
    }
}


// https://www.jianshu.com/p/c208b2610478