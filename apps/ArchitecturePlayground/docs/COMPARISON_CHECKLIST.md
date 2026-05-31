# Comparison Checklist

Use this checklist when reviewing each architecture implementation.

## Structure

- Is the folder layout easy to understand?
- Is the state owner obvious?
- Are dependencies explicit?

## Feature Work

- How easy is it to add bookmark-only mode?
- How easy is it to add weekly review?
- How easy is it to add one more filter?

## Testing

- Can filtering logic be tested without UI?
- Can navigation be tested clearly?
- How much mocking is required?

## Tradeoffs

- What gets simpler in this architecture?
- What gets more verbose?
- What becomes painful first?

## Completion Check

- Does this architecture express the full shared feature set?
- Is there a dedicated README explaining when to use it?
- Does it reuse `SharedDomain` instead of inventing a separate model world?
