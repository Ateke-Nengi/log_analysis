#!/bin/bash
# ============================================================
# Exercise 3 — Analysis of access-2.log
# Analyst: Ateke Tamunonengieofori
# Environment: Kali Linux
# ============================================================

# Q1: How many GET requests were made?
grep -c '"GET ' access-2.log
# Answer: 60

# Q2: How many unique IP addresses made requests?
awk '{print $1}' access-2.log | sort -u | wc -l
# Answer: 48

# Q3: How many requests yielded a 200 status?
grep -c '200' access-2.log
# Answer: 19

# Q4: How many requests yielded a 400 status?
grep -c '400' access-2.log
# Answer: 38

# Q5: What IP address "rang at the doorbell"?
grep -E 'doorbell|Ringing' access-2.log
# Answer: 186.64.69.141 (accessed /Ringing.at.your.dorbell!)

# Q6: What version of Googlebot visited the website?
grep -o 'Googlebot/[0-9.]*' access-2.log | sort -u
# Answer: Googlebot/2.1

# Q7: What was the most frequent version of Firefox used?
grep -o 'Firefox/[0-9.]*' access-2.log | sort | uniq -c | sort -nr | head -1
# Answer: Firefox/31.0 (9 occurrences)

# Q8: What was the most common HTTP method used?
awk -F'"' '{print $2}' access-2.log | awk '{print $1}' | sort | uniq -c | sort -nr | head -1
# Answer: GET (60 times)
