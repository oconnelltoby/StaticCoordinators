# StaticCoordinators

## Aims

This project is an experiment around the idea of stateless coordinators with the aim of making navigation logic more testable.

### Objectives

1. Abstract `UIKit` away from coordinator logic to make testing easier
2. Keep coordinators stateless, so memory management is easy

### Solutions

1. Wrap `UINavigationController` and `UIViewController` in `Pushing` and `Presenting` protocols
2. Make coordinator functions static
