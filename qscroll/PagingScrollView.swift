import SwiftUI
import UIKit

struct PagingScrollView<Content: View>: UIViewRepresentable {
    let pages: [Content]
    @Binding var currentPage: Int  // binding for current page

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for page in pages {
            let hostingController = UIHostingController(rootView: page)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(hostingController.view)
            // Force each page to exactly fill the screen height.
            NSLayoutConstraint.activate([
                hostingController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
            ])
        }
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Calculate the offset for the current page.
        let targetOffset = CGFloat(currentPage) * UIScreen.main.bounds.height
        if abs(uiView.contentOffset.y - targetOffset) > 1 {
            uiView.setContentOffset(CGPoint(x: 0, y: targetOffset), animated: true)
        }
    }
    
    // Coordinator to sync scrolling with the binding.
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PagingScrollView
        
        init(_ parent: PagingScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            // Update the binding when the user swipes manually.
            let page = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            if parent.currentPage != page {
                parent.currentPage = page
            }
        }
    }
}
