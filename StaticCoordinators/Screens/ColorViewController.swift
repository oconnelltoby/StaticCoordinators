import UIKit

extension ColorViewModel {
    enum Style {
        case red
        case green
        case blue
    }
    
    init(style: Style, completion: @escaping () -> Void) {
        switch style {
        case .red:
            self.init(color: .systemRed, title: "Red", completion: completion)
        case .green:
            self.init(color: .systemGreen, title: "Green", completion: completion)
        case .blue:
            self.init(color: .systemBlue, title: "Blue", completion: completion)
        }
    }
}

struct ColorViewModel {
    var color: UIColor
    var title: String
    var completion: () -> Void
}

class ColorViewController: UIViewController {
    init(viewModel: ColorViewModel) {
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        view = ColorView(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ColorView: UIView {
    init(viewModel: ColorViewModel) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = viewModel.color
        configuration.baseForegroundColor = .label
        configuration.title = "Continue"
        
        let action = UIAction { _ in viewModel.completion() }
        
        let button = UIButton(configuration: configuration, primaryAction: action)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            button.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
