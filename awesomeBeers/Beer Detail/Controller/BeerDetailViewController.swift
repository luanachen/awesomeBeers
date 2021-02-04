import Kingfisher
import UIKit

private enum Constants {
    static let AccessibilityIdentifier = "beerDetailView"
}

class BeerDetailViewController: UIViewController {

    let detailView: DetailView!
    var viewModel: BeerDetailViewModel!

    init(viewModel: BeerDetailViewModel) {
        detailView = DetailView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = Constants.AccessibilityIdentifier

        setupView()

        show()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.title = viewModel.getBeer().name
    }

    private func setupView() {
        view.addSubview(detailView)
        detailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }

    private func show() {
        detailView.show(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
