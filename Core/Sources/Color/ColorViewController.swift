import Analytics
import UIKit

public extension ColorViewModel {
    enum Style {
        case red
        case green
        case blue
        
        fileprivate var properties: (title: String, color: UIColor) {
            switch self {
            case .red:
                return ("Red", .systemRed)
            case .green:
                return ("Green", .systemGreen)
            case .blue:
                return ("Blue", .systemBlue)
            }
        }
    }
    
    init(style: Style, analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) {
        let ciColor = CIColor(color: style.properties.color)
        
        let screenViewedEvent = ColorScreenEvent(
            properties: .init(
                title: style.properties.title,
                red: ciColor.red,
                green: ciColor.green,
                blue: ciColor.blue
            )
        )
        
        self.init(
            color: style.properties.color,
            title: style.properties.title,
            screenViewed: { analyticsTracker.track(event: screenViewedEvent) },
            completion: completion
        )
    }
}

public struct ColorViewModel {
    var color: UIColor
    var title: String
    var screenViewed: () -> Void
    var completion: () -> Void
}

class ColorViewController: UIViewController {
    private let viewModel: ColorViewModel
    
    init(viewModel: ColorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        view = ColorView(viewModel: viewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.screenViewed()
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
