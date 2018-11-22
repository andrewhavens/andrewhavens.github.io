---
layout: post
title: In defense of Cucumber
date: 2017-02-27
---

https://robots.thoughtbot.com/better-acceptance-tests-with-page-objects

matt [2:17 PM]
Did we come to a conclusion on cucumber?

andrew [2:17 PM]
I don't think we discussed it yet.

[2:18]  
But my thoughts are that it's the best tool for the job (for this use-case). (edited)

lukemelia [2:18 PM]
I’m on board with cucumber for this

matt [2:19 PM]
Could you spell out why you think it’s better to introduce a new testing pattern?

andrew [2:20 PM]
well...because we are introducing a new testing pattern. We're testing features across multiple apps.

matt [2:20 PM]
I’m not necessarily pushing back, but it’s not an obvious choice for me so I’d like to understand

andrew [2:21 PM]
Cucumber is ideal for this in that it allows you to describe the feature at a high level, then implement the individual steps

You could achieve something similar using just RSpec and feature specs, and other custom abstractions to simplify the readability of the code, but you sort of get that out-of-the-box with Cucumber

matt [24 minutes ago]
andrew: From what I can see in the test suite, that out-of-box-ness of cucumber comes at with a cost. Those feature specs look simple but they’re hiding a huge abstraction. Tests are hard enough to write as it is.

matt [23 minutes ago]
I feel bad being negative here. I know you put a couple days into this work

matt [21 minutes ago]
I’m fine dropping my objection in light that the work is already done and that this suite will be changed not very often

andrew [2 minutes ago]
Don't feel bad. I'm confident in my decision and support of Cucumber, so I just want to help you see the benefit. If there is something specific that is lacking/confusing about any of my code, let me know and we can address it. Bad abstractions come at a cost, but good abstractions are beneficial. The way I think of using Cucumber is in small circles of responsibility. A feature file is responsible for describing the business logic in a way that is clear to anyone and is not obfuscated by code. Then each step definition is sort of like a miniature test that is focused toward performing/validating that specific step, which makes it easy to see what it is/should be doing. There are certainly people who have had bad experiences using Cucumber, but I'm convinced that those concerns can be easily corrected.
