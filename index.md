---
title       : eBay Car Price Checker
subtitle    : 
author      : James Capstick
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Purpose

This website is designed to help you find the average sold price on eBay for different types of car.

It provides:
- A search box to enter search terms (e.g. "Ford Focus")
- An output of the average eBay sold price of cars matching those search terms entered
- A list of the cars matching the search terms, with links to the eBay website

---

## How to use

Simply enter a search term in the box provided on the left. The output will update automatically.

For example, enter the search term "Mitsubishi Starion" and the website will show you the average sold price:


```
## [1] "Average Sale Price:  $ 3509.33"
```

---

## Item list

The website will also show you a list of the items returned: