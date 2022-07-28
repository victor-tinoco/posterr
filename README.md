# Posterr - Victor Tinoco

It's a challenge project to Stripe. A new social media based on an user-generated text-based content.

In this MVP version, there are two main screens:
- Home: a timeline where you can see posts from different authors.
- Profile: shows information about the logged user, and all its shared content.

Through both of these screens it is possible to create a content.

## Getting Started

### Prerequisites

It's an application based on Flutter, so you can take a look at flutter's [get-started](https://docs.flutter.dev/get-started/install). Also, please setup all initial steps like setup emulators, add flutter and dart CLI on path, etc.

### Installation

1. Get all pub packages
```sh
flutter pub get
```
2. Run code generation, which is required by some packages
```sh
flutter pub run build_runner build
```
3. Run the application. Press `F5` or
```sh
flutter run
```

## Critique

### Improvements

- [x] Add profile page
    - [x] Get information about user
    - [x] Get information about its shared content
    - [x] Show all its content
    - [x] Allow to share content
- [x] Add home page
    - [x] Get all timeline content
    - [x] Allow to share content
- [ ] Improve the dependences injector approach
- [ ] With priority, provide tests at least for the main usecases in the domain layer!
- [ ] Improve error handlings and loading states
- [ ] Add pagination to timelines

### Crash scenario

> Assuming you've got multiple crash reports and reviews saying the app is not working properly and is slow for specific models, what would be your strategy to tackle the problem? (assuming the app is supposed to work well for these models)

First of all, our app must be integrated with a crash tracking service, like crashlytics. Also, we must provide proper logs in order to be possible, when analysing these crashs, to understand the crash's scenario and what was the user's way until that crash. So, with these information we probably would have enough data to understand the wrong behavior and address it fastly.

### Growth scenario

> Assuming your app has now thousands of users thus a lot of posts to show in the feed. What do you believe should be improved in this initial version and what strategies/proposals you could formulate for such a challenge?

Firstly, we must deal better with loading and error states.

As I already put into the _Improvements_ section, pagination would be a good improvement since we would get the content gradually (I've already formatted the structure and architecture to be possible implementing this feature on the screen). It probably would help with performance and delay.

Also, we should allow users to re-post and quote-post, edit and remove its posts.

Lastly, would be required to have an user screen (we could re-use the profile page's structure) and a follow-user-feature in order to be possible an interaction between users.

For an initial roadmap these would be good proposals for a more complete MVP. Also, we should understand what these thousand of users are desiring in our application, so we can know if we are in the correct way.
