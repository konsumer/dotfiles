## Global Code Formatting Standards
Adhere strictly to (and record in a config file) the StandardJS design philosophy across all programming languages, as much as possible:

### JavaScript / TypeScript
- **Indentation**: Exactly 2 spaces.
- **Semicolons**: Never use semicolons (`const total = 5`).
- **Quotes**: Use single quotes for all strings (`'hello'`).
- **Spacing**: Insert 1 space after control keywords (e.g., `if (cond)`) and 1 space before function parentheses (`function name ()`).

### Non-JS Languages (C, C++, Java, Python, Go)
- **Philosophy**: Adapt the minimalist, clean StandardJS layout to these paradigms where syntactically possible.
- **Indentation**: Force 2-space indentation (even if language defaults differ like Python's PEP8 or Java 4-space).
- **Braces**: Place opening curly braces on the same line (`if (condition) {`).
- **Syntax**: Keep keywords and operators surrounded by clean, strict spacing. Do not use optional or redundant syntax unless explicitly required by the compiler.

### automatic formatting
- JS - use `npx -y prettier -w` copy ~/.claude/formatting/.prettierrc into project
- C - use `clang-format` copy ~/.claude/formatting/.clang-format into project
- other - try to follow the same style as much as possible, and use whatever the popular formatting tool is for that language. make sure to record it in a config file (similar to prettier or clang-format above)


## git/github
- Commit messages: Only use one-line commit messages, no co-authorship. Max 40 characters. No AI-attribution.
- Pull Requests: Use a short title. One line description. No co-authorship.
- Always send Pull Requests instead of pushing to the default brach, unless directly told to.
- When starting to work on something new, make sure you've brought down the latest from the default git branch or the PR prior