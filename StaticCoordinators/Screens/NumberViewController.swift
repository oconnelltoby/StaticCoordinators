import UIKit

extension NumberViewModel {
    init(number: Int, completion: @escaping () -> Void, dismiss: @escaping () -> Void) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let speltOutNumber = formatter.string(from: NSNumber(value: number))!.capitalized
        self.init(title: speltOutNumber, label: "\(number)", completion: completion, dismiss: dismiss)
    }
}

struct NumberViewModel {
    var title: String
    var label: String
    var completion: () -> Void
    var dismiss: () -> Void
}

class NumberViewController: UIViewController {
    init(viewModel: NumberViewModel) {
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        view = NumberView(viewModel: viewModel)
        
        navigationItem.rightBarButtonItem = .init(systemItem: .close, primaryAction: .init { _ in viewModel.dismiss() })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NumberView: UIView {
    init(viewModel: NumberViewModel) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .systemBackground
        configuration.title = "Continue"
        let action = UIAction { _ in viewModel.completion() }
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.setContentHuggingPriority(.required, for: .vertical)

        let label = UILabel()
        label.numberOfLines = .zero
        label.adjustsFontForContentSizeCategory = true
        label.text = viewModel.label
        label.font = .systemFont(ofSize: 200)
        label.textColor = UIColor.label.withAlphaComponent(0.25)
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -12),
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 12),

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
