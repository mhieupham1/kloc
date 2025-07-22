# Feature-based Tagging & KLOC Comparison

## Purpose
This guide describes a practical workflow for tagging Git commits at the **end of each feature**. It enables you to easily measure the number of lines of code changed (KLOC) between any two features at any time.

---

## Workflow

### 1. Tag the End of Each Feature

- **Before starting a new feature** (or whenever you want to compare features), identify the commit that marks the end of the previous feature.
- **Tag that commit** using the format:  
  `end-{feature_name}`

**Example:**
```bash
git tag end-login <commit_sha_of_end_of_login>
```

After finishing the current feature and committing all changes, tag the latest commit:
```bash
git tag end-{current_feature}
```

**Example:**
```bash
git tag end-payment
```

Push your tags to the remote so teammates can use them:
```bash
git push origin end-login end-payment
```

Or push all tags:
```bash
git push --tags
```

### 2. Compare KLOC Between Two Features

**Before first use, make the script executable:**
```bash
chmod +x compare_commit_lines.sh
```

**Important:** Ensure your working directory is clean (no uncommitted changes) before running the script, as it switches between commits:
```bash
git status  # Check for uncommitted changes
git stash   # If you have uncommitted changes, stash them
```

Use your Bash script `compare_commit_lines.sh` to compare the total lines of code between any two tags:

```bash
./compare_commit_lines.sh . end-login end-payment
```

### 3. Why Tag Features?

- You can always see exactly how many lines changed for any feature, even much later.
- This makes tracking, code review, and reporting easy and reliable.
- Tags are permanent markers in Git history and do not affect your code or workflow.
- By using a consistent naming convention (`end-{feature_name}`), everything remains clear and organized.

### 4. Notes & Best Practices

- Always tag at the **end commit** of each feature, not at the start.
- **Keep your working directory clean** before running the comparison script, as it switches between commits frequently.
- If you forget to tag, use `git log` to find the correct commit and tag it retroactively:
  ```bash
  git tag end-feature-name <commit_sha>
  ```
- **If you tagged the wrong commit** (not the actual end of the feature), fix it by:
  1. Delete the incorrect tag:
     ```bash
     git tag -d end-feature-name
     git push origin :refs/tags/end-feature-name  # Delete from remote
     ```
  2. Tag the correct final commit:
     ```bash
     git tag end-feature-name <correct_commit_sha>
     git push origin end-feature-name
     ```
- Use lowercase and hyphens for feature names, e.g. `end-user-profile`, `end-payment`.
- Always push tags to the remote after creating them.
- For large projects, keep a list of features and corresponding tags if necessary.

---

## Example Workflow

After finishing the "login" feature:
```bash
git tag end-login
git push origin end-login
```

After finishing the "payment" feature:
```bash
git tag end-payment
git push origin end-payment
```

Compare KLOC between the two features:
```bash
# Ensure working directory is clean first
git status
chmod +x compare_commit_lines.sh  # If not already executable
./compare_commit_lines.sh . end-login end-payment
```

---

## Summary

Tagging the end of each feature using a clear, consistent pattern allows you to accurately measure code changes between any two features—making tracking, code review, and reporting much easier for you and your team.
