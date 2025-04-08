# qScroll — SAT Question Scroller for iOS

**qScroll** is a minimal iOS app designed to deliver SAT-style math questions one at a time in a vertically scrollable interface. The app is part of a broader project focused on helping students prepare more effectively for standardized tests through accessible practice tools and meaningful feedback.

## Features

- Vertical "TikTok-style" swipe between questions  
- Double-tap to check answers instantly  
- Visual feedback: green outline for correct answers, red for incorrect  
- Full dark mode support  
- Lightweight launch screen for branded startup experience  

## Purpose

This app is part of an ongoing larger project to create simple and intuitive interfaces for students to scroll through SAT-style questions. The primary goal is not only practice but also to collect and provide accurate performance data and concise feedback so students can prepare better for the SAT and similar standardized tests.

## Tech Stack

- SwiftUI for declarative UI
- UIKit bridge for vertical paging via `UIScrollView`
- Native iOS 18.2+ compatibility
- Fully local: no external dependencies or data storage (yet)

## Roadmap

- [ ] Add a summary screen or progress tracker  
- [ ] Load questions from JSON or cloud storage  
- [ ] Add admin mode to input/edit questions  
- [ ] Enable score tracking and personalized review

## Getting Started

1. Open the project in Xcode (16 or later)
2. Connect a real iPhone (or use the iOS 18+ simulator)
3. Set the run target and press Run to build
4. Trust the developer certificate on your device if needed (Settings → General → Device Management)

