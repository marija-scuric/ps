# Getting started

##### _Follow the directions in the [Rails walkthrough](https://platform-docs.docs.shopify.io/getting_started/rails-walkthrough) for specific instructions to set your app up._

Shopify-flavoured Rails apps are different from vanilla Rails apps in a few exciting ways:

- Shiny new application structure ✨
- A bunch of useful commands 🤖
- CI and production deployment is configured and ready to roll 🚢🚀

## What you get out of the box 💎

The generated app comes with several things configured and ready to run, such as the latest version of Ruby, and Ruby on Rails backend. You now have to do very minimal setup to start developing your code.

Your app also comes with other features set up by default:

- _dev_: dev is set up just like you use it everywhere, with `dev test`, `dev server`, and `dev console`.
- _Type checking and linters_: Type checkers and linters follow the Shopify style guides. To simplify your life, `dev style` and `dev typecheck` are included. Not only that, but the code you get upon creation is already linted and type-checked, starting your app from a clean slate.
- _Dependabot_: Your dependencies are automatically checked and Dependabot will remind you to upgrade them when an update is available.
- _CI_: Your app is configured for CI via Shopify Build (Setup is completed in the Rails walkthrough).
- _Production deploy_: Your app includes a production ready pipeline via Shopify Build (Setup is completed in the Rails walkthrough).

All you need to do is write code and ship it!

## Useful commands 🗣

Show the machine who’s in charge!

- `dev console` to access your Rails console in development
- `dev server` to run your app in development
- `dev style` for code linting with Rubocop, TypeScript, eslint, Prettier, and stylelint
- `dev test` to run your ruby test suites
- `dev test-frontend` to run your node test suites
- `dev typecheck` for static type checking with Sorbet and eslint
