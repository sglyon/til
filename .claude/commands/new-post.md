New Post command

**Variables:**

user_notes: $ARGUMENTS

**ARGUMENTS PARSING:**
Parse the following arguments from "$ARGUMENTS":
1. `user_notes` - notes from the user that describe the main purpose of the til post
2. `output_dir` - Directory where iterations will be saved
3. `count` - Number of iterations (1-N or "infinite")

**Instructions**

This project contains today I learned (TIL) notes I keep for myself.

You are to write a new post based on the provided user notes

Posts are written in the `content/posts` directory. Filenames match `YYYY-MM-DD-slug.md` with the current date

Post must follow the followings structure:

```md
---
title: "{TITLE}"
date: {DATE}
draft: false
tags: {LIST OF STRINGS AS TAGS, OPTIONAL}
categories: {LIST OF STRINGS AS CATEGORIES, OPTIONAL}
---

{CONTENT}
```

**Writing style**

  • Direct and practical - gets straight to the point with minimal fluff
  • Semi-informal conversational tone - professional but approachable, uses contractions
  • Heavy first-person perspective - consistent "I" usage to share personal discoveries
  • Problem-solution structure - typically starts with a challenge, ends with the fix
  • Code-heavy - extensive use of well-formatted code snippets and examples
  • Concise posts - brief, focused entries under 50 lines each
  • Authentic voice - admits mistakes, shows genuine excitement about learning
  • Developer-to-developer communication - assumes technical background
  • TIL documentation style - personal development journal sharing real-world experiences
  • Practical utility focus - values efficiency and getting things done over comprehensive explanations
